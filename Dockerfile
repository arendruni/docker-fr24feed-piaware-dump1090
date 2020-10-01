FROM arm32v7/debian:buster

ENV PIAWARE_VERSION=3.8.0
ENV FR24FEED_VERSION=1.0.24-7

RUN apt-get update && \
    apt-get install -y wget pkg-config ca-certificates --no-install-recommends && \
    apt-get clean

# PIAWARE and DUMP1090-FA
WORKDIR /tmp
RUN wget https://it.flightaware.com/adsb/piaware/files/packages/pool/piaware/p/piaware-support/piaware-repository_${PIAWARE_VERSION}_all.deb && \
    dpkg -i piaware-repository_${PIAWARE_VERSION}_all.deb && apt-get update && apt-get -y install piaware dump1090-fa
RUN mkdir /run/dump1090-fa && touch /run/dump1090-fa/aircraft.json
COPY config.js /usr/share/dump1090-fa/html/
COPY piaware.conf /etc/

# FR24FEED
WORKDIR /fr24feed
RUN wget https://repo-feed.flightradar24.com/rpi_binaries/fr24feed_${FR24FEED_VERSION}_armhf.tgz \
    && tar -xvzf *armhf.tgz
COPY fr24feed.ini /etc/

RUN apt-get update && apt-get install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8754 8080 30001 30002 30003 30004 30005 30104 

CMD ["/usr/bin/supervisord"]
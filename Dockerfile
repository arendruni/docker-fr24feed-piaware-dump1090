FROM arm32v7/debian:buster

MAINTAINER arendruni@aim.com

RUN apt-get update && \
    apt-get install -y wget pkg-config ca-certificates --no-install-recommends && \
    apt-get clean

# PIAWARE and DUMP1090-FA
WORKDIR /tmp
RUN wget https://it.flightaware.com/adsb/piaware/files/packages/pool/piaware/p/piaware-support/piaware-repository_3.8.0_all.deb && \
    dpkg -i piaware-repository_3.8.0_all.deb && apt-get update && apt-get -y install piaware dump1090-fa
COPY config.js /usr/share/dump1090-fa/html/
#COPY upintheair.json /usr/share/dump1090-fa/html/
COPY piaware.conf /etc/

# FR24FEED
WORKDIR /fr24feed
RUN wget https://repo-feed.flightradar24.com/rpi_binaries/fr24feed_1.0.24-7_armhf.tgz \
    && tar -xvzf *armhf.tgz
COPY fr24feed.ini /etc/

RUN apt-get update && apt-get install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8754 8080 30001 30002 30003 30004 30005 30104 

CMD ["/usr/bin/supervisord"]
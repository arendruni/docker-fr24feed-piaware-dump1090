IMAGE := fatoldsun/fr24feed-piaware
PIAWARE_VERSION := $(shell grep -m 1 PIAWARE_VERSION Dockerfile | awk '{print $2}' | cut -d '=' -f 2)
FR24FEED_VERSION := $(shell grep -m 1 FR24FEED_VERSION Dockerfile | awk '{print $2}' | cut -d '=' -f 2)
VERSION := ${PIAWARE_VERSION}_${FR24FEED_VERSION}

test:
	true

image:
	docker build -t ${IMAGE}:${VERSION} .
	docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest

push:
	docker push ${IMAGE}:${VERSION}
	docker push ${IMAGE}:latest

.PHONY: image push test

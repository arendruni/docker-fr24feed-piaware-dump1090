IMAGE := fatoldsun/fr24feed-piaware
VERSION := $(shell grep -m 1 PIAWARE_VERSION Dockerfile | awk '{print $2}' | cut -d '=' -f 2)

test:
	true

image:
	docker build -t ${IMAGE}:${VERSION}
	docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest

push:
	docker push ${IMAGE}:${VERSION}
	docker push ${IMAGE}:latest

.PHONY: image push test

.DEFAULT_GOAL := help
.PHONY: *

build:
	echo "Building Tag: $(TAG)"
	@docker build \
		--no-cache \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		-t ghcr.io/bogdankharchenko/vapor-ci:$(TAG) \
		-f Dockerfile-$(TAG) .

test:
	echo "Testing Tag: $(TAG)"
	dgoss run -it bogdankharchenko/ci:$(TAG)

build-all:
	make build TAG="7.4"
	make build TAG="8.0"

push-all:
	docker push ghcr.io/bogdankharchenko/vapor-ci:7.4
	docker push ghcr.io/bogdankharchenko/vapor-ci:8.0

clean:
	docker ps -a -q | xargs docker rm -f
	docker images -q | xargs docker rmi -f

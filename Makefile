.DEFAULT_GOAL := help
.PHONY: *

build:
	echo "Building Tag: $(TAG)"
	@docker build \
		--no-cache \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		-t scriptor2k2/vapor-ci:$(TAG) \
		-f Dockerfile .

test:
	echo "Testing Tag: $(TAG)"
	dgoss run -it scriptor2k2/ci:$(TAG)

build-all:
	make build TAG="7.4"

push-all:
	docker push scriptor2k2/vapor-ci:7.4

clean:
	docker ps -a -q | xargs docker rm -f
	docker images -q | xargs docker rmi -f

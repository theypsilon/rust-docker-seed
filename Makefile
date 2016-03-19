.PHONY: docker-image docker-push docker-pull docker-test docker-run

REGISTRY=localhost
PROJECT=rustseed
TAG=latest
IMAGE=$(REGISTRY)/$(PROJECT):$(TAG)

docker-image:
	docker build -t $(IMAGE) .

docker-push:
	docker push $(IMAGE)

docker-pull:
	docker pull $(IMAGE)

NAME=rustseed_container
PORT=6767

docker-run: docker-image
	docker run --name $(NAME)_server --rm -it -p $(PORT):6767 $(IMAGE)

docker-test: docker-image
	docker run --name $(NAME)_test --rm  $(IMAGE) cargo test

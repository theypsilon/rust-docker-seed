.PHONY: docker-image docker-push docker-pull docker-test docker-run

PROJECT=rustseed
TAG=latest
IMAGE=$(PROJECT):$(TAG)

docker-image:
	docker build -t $(IMAGE) .

docker-push:
	docker push $(IMAGE)

docker-pull:
	docker pull $(IMAGE)

NAME=rustseed_1
PORT=6767

docker-run:
	docker run --name $(NAME) --rm -it -p $(PORT):6767 $(IMAGE)

docker-test:
	docker run --name $(NAME)_test --rm  $(IMAGE) cargo test

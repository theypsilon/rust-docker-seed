.PHONY: docker-image docker-push docker-pull docker-test docker-ft commit-stage functional-tests

PROJECT=rustseed
TAG=latest
IMAGE=$(PROJECT):$(TAG)
UPDATE_CARGO=$(PROJECT)-update-cargo-lock

DC_TEST=TAG=$(TAG) docker-compose -p nextcheftest -f compose/base.yml -f compose/integration-test.yml
DC_FT=TAG=$(TAG) docker-compose -p nextchefft -f compose/base.yml -f compose/functional-test.yml

docker-image:
	docker build -t $(IMAGE) .

docker-push:
	docker push $(IMAGE)

docker-pull:
	docker pull $(IMAGE)

docker-test:
	$(DC_TEST) run --rm app
	$(DC_TEST) down

docker-ft:
	$(DC_FT) run --rm jmeter
	$(DC_FT) down

commit-stage: docker-image docker-test docker-push
functional-tests: docker-pull docker-ft

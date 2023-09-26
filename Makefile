# Set $ROOT to top-level directory of the repository
ROOT ?= $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

IMG_NAME=webimg
IMG_HOME=/home/developer
IMG_REGI=javierarroyo/webimg

build-env:
	docker build -f ${ROOT}/Dockerfile \
	--progress=plain --rm -t ${IMG_NAME} .

build-env-no-cache:
	docker build -f ${ROOT}/Dockerfile \
	--no-cache \
	--progress=plain --rm -t ${IMG_NAME} .

COMMAND_RUN=docker run \
		--name ${IMG_NAME} \
		--detach=false \
		--network=host \
		--rm \
		-v ${ROOT}:${IMG_HOME}/wedding:rw \
		-w ${IMG_HOME}/wedding/example \
		${IMG_NAME} 

run-env-interactive:
	docker run \
		--name ${IMG_NAME} \
		--detach=false \
		--network=host \
		--rm \
		-it \
		-v ${ROOT}:${IMG_HOME}/wedding:rw \
		-w ${IMG_HOME}/wedding/example \
		${IMG_NAME} 

push:
	docker tag ${IMG_NAME} ${IMG_REGI}
	docker push ${IMG_REGI}

pull:
	docker pull ${IMG_REGI}
	docker tag ${IMG_REGI} ${IMG_NAME}

run-and-build:
	$(COMMAND_RUN) /bin/bash -c "git config --global --add safe.directory /home/developer/wedding && cd .. && npx webpack && cd example && bundle exec jekyll build"

run-and-serve:
	$(COMMAND_RUN) /bin/bash -c "git config --global --add safe.directory /home/developer/wedding && cd .. && npx webpack && cd example && bundle exec jekyll serve"
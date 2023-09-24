# Set $ROOT to top-level directory of the repository
ROOT ?= $(shell dirname \
  $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST)))))

IMG_NAME=weddingweb
IMG_HOME=/home/developer

build-env:
	docker build -f ${ROOT}/example/Dockerfile \
	--progress=plain --rm -t ${IMG_NAME} .

build-env-no-cache:
	docker build -f ${ROOT}/example/Dockerfile \
	--no-cache \
	--progress=plain --rm -t ${IMG_NAME} .

run-env:
	docker run \
		--name ${IMG_NAME} \
		--detach=false \
		--network=host \
		--rm \
		-v ${ROOT}:${IMG_HOME}/wedding:rw \
		-w ${IMG_HOME}/wedding/example \
		${IMG_NAME} 

build-web:
	bundle exec jekyll build

serve-web:
	bundle exec jekyll serve


# Makefile for build the pstl docker image

RELEASE_IMAGE_TAG=jtcheng/pstl:v0.1

release:
	@echo "building the pstl docker image ..."
	DOCKER_BUILDKIT=1 docker build --progress=plain --no-cache=true --target=release --tag=$(RELEASE_IMAGE_TAG) .
clean:
	@echo "remove the pstl docker image ..."
	-docker rmi $(RELEASE_IMAGE_TAG)
	-docker builder prune -a -f

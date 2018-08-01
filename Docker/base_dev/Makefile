#
ImageName := mooxe/ocaml_base:dev

build:
	@cmd="docker build" && \
	if [ ! -z ${MIRROR_LP} ]; then \
		cmd="$${cmd} --build-arg MIRROR_LP=$${MIRROR_LP}"; \
	fi && \
	cmd="$${cmd} -t ${ImageName} ." && \
	bash -c "$${cmd}"

# env MIRROR_LP="192.168.0.108:8080\\/launchpad" make rebuild

rebuild:
	@cmd="docker build" && \
	cmd="$${cmd} --no-cache"; \
	if [ ! -z ${MIRROR_LP} ]; then \
		cmd="${cmd} --build-arg MIRROR_LP=$${MIRROR_LP}"; \
	fi && \
	cmd="$${cmd} -t ${ImageName} ." && \
	bash -c "$${cmd}"

in:
	docker run --rm -ti \
		--name=node \
		-v $$(pwd):/root/node \
			${ImageName} /bin/bash

publish:
	docker push ${ImageName}

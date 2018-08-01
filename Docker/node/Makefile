#
ImageName := mooxe/ocaml_node

build:
	docker build -t ${ImageName} .

rebuild:
	docker build --no-cache -t ${ImageName} .

in:
	docker run --rm -ti \
		--name=node \
		-v $$(pwd):/root/node \
			${ImageName} /bin/bash

push:
	docker push ${ImageName}

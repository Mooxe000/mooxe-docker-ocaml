pjName := mooxe/ocaml

build:
	docker build -t ${pjName} .

rebuild:
	docker build --no-cache=true -t ${pjName} .

in:
	docker run --rm \
		--name=mooxe_ocaml \
		-ti \
		-v $$(pwd):/root/ocaml \
		${pjName} \
			/bin/bash

push:
	docker push ${pjName}

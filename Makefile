build:
	docker build -t rfdickerson/opencvbuilder .

compile:
	docker run -it --rm \
	--runtime=nvidia \
	-v `pwd`:/build \
	rfdickerson/opencvbuilder \
	/bin/bash

build:
	docker build -t rfdickerson/opencvbuilder .

compile:
	docker run --rm \
	--runtime=nvidia \
	-v /tmp/package:/package \
	-v /tmp/build:/build \
	rfdickerson/opencvbuilder


#!/bin/bash -x
set -e

DOCKER_OPS="--rm -d --cap-add=SYS_ADMIN -p 4444:4444 -p 5900:5900"

for BROWSER_VERSION in latest nightly beta 
do
	echo "Testing firefox $BROWSER_VERSION"
	docker run --name firefox $DOCKER_OPS elastestbrowsers/firefox:$BROWSER_VERSION
	sleep 5
	curl -X POST -d '{"desiredCapabilities":{"browserName":"firefox","version":"","platform":"ANY"}}' http://localhost:4444/wd/hub/session
	docker stop firefox
done

for BROWSER_VERSION in latest unstable beta 
do
	echo "Testing chrome $BROWSER_VERSION"
	docker run --name chrome $DOCKER_OPS elastestbrowsers/chrome:$BROWSER_VERSION
	sleep 5
	curl -X POST -d '{"desiredCapabilities":{"browserName":"chrome","version":"","platform":"ANY"}}' http://localhost:4444/wd/hub/session
	docker stop chrome
done

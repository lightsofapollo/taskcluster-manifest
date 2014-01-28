clone:
	# Clone the jobqueue from where-ever it lives
	git clone https://github.com/jonasfj/taskcluster-jobqueue.git

	# Clone the AWS provisioner
	git clone https://github.com/taskcluster/aws-provisioner.git

	# Clone the docker-worker repository
	git clone https://github.com/taskcluster/docker-worker.git

	# Clone the docker-services repository
	git clone https://github.com/taskcluster/docker-services.git

clean:
	# Remove docker images
	-docker rmi docker-aws-provisioner
	-docker rmi jobqueue
	-cd aws-provisioner && node utils/cleanup-aws.js
	rm -rf taskcluster-jobqueue aws-provisioner docker-worker docker-services

setup: clone
	cd aws-provisioner && node utils/setup-aws.js

build-images: setup
	make -C taskcluster-jobqueue docker-build
	make -C aws-provisioner docker-build

run: build-images
	./docker-services/bin/docker-services exec provisioner

.PHONY: clone setup build-images clean
projects:
	@mkdir -p projects

	# Clone the jobqueue from where-ever it lives
	cd projects && git clone https://github.com/jonasfj/taskcluster-jobqueue.git

	# Clone the AWS provisioner
	cd projects && git clone https://github.com/taskcluster/aws-provisioner.git
	cd projects/aws-provisioner && node utils/setup-aws.js

	# Clone the docker-worker repository
	cd projects && git clone https://github.com/taskcluster/docker-worker.git

	# Clone the docker-services repository
	cd projects && git clone https://github.com/taskcluster/docker-services.git


build-images: projects
	make -C projects/taskcluster-jobqueue docker-build
	make -C projects/aws-provisioner docker-build

run: build-images
	./projects/docker-services/bin/docker-services exec provisioner

remove-images:
	-docker ps -a | cut -f 1 -d ' ' | tail -n +2 | xargs docker rm
	-docker rmi docker-aws-provisioner
	-docker rmi jobqueue

clean: remove-images
	-cd projects/aws-provisioner && node utils/cleanup-aws.js
	rm -rf projects

.PHONY: build-images remove-images clean
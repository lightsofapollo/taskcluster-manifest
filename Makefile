all: configure

projects:
	@mkdir -p projects

	# Clone the jobqueue from where-ever it lives
	cd projects && git clone https://github.com/jonasfj/taskcluster-jobqueue.git

	# Clone the AWS provisioner
	cd projects && git clone https://github.com/taskcluster/aws-provisioner.git

	# Clone the docker-worker repository
	cd projects && git clone https://github.com/jonasfj/docker-worker.git

configure: projects
	-cd projects/aws-provisioner && node utils/setup-aws.js
	-make -C projects/taskcluster-jobqueue database

clean:
	cd projects/aws-provisioner && node utils/cleanup-aws.js
	rm -rf projects

.PHONY: all clean configure

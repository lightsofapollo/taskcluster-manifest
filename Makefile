all: install

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

install: configure
	sudo cp taskcluster-aws-provisioner.conf /etc/init/;
	sudo cp taskcluster-queue.conf /etc/init/;

start:
	sudo service taskcluster-aws-provisioner start
	sudo service taskcluster-queue start

post-task:
	curl -X POST -d @test-task.json http://localhost:8314/0.1.0/job/new

stop:
	-sudo service taskcluster-aws-provisioner stop
	-sudo service taskcluster-queue stop


clean: stop
	cd projects/aws-provisioner && node utils/cleanup-aws.js
	rm -rf projects
	sudo rm -f /etc/init/taskcluster-aws-provisioner.conf /etc/init/taskcluster-queue.conf

.PHONY: all install start post-task stop clean configure

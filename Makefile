all: configure

projects/docker-worker:
	git clone https://github.com/jonasfj/docker-worker.git $@

projects/aws-provisioner:
	git clone https://github.com/taskcluster/aws-provisioner.git $@

projects/taskcluster-jobqueue:
	git clone https://github.com/jonasfj/taskcluster-jobqueue.git $@

projects: projects/taskcluster-jobqueue \
					projects/aws-provisioner \
					projects/docker-worker

configure: projects
	-cd projects/aws-provisioner && node utils/setup-aws.js
	-make -C projects/taskcluster-jobqueue database

clean:
	# This will ignore the .gitkeep
	rm -Rf projects/docker-worker
	rm -Rf projects/aws-provisioner
	rm -Rf projects/taskcluster-jobqueue
	#cd projects/aws-provisioner && node utils/cleanup-aws.js

.PHONY: all clean configure

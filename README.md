TaskCluster Manifest
====================
_This repository contains the script and configuration required to deploy an
instance of the TaskCluster._

Spin up a vagrant instance with `vagrant up` and enter it with `vagrant ssh`.
Use `make install` to install upstart scripts, then it can be started/stopped
with `make start` and `make stop`.

Please make sure to do a `make clean` when done, otherwise AWS resources may be
left-over server side.

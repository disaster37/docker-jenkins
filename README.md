Dockerized version of Jenkins-CI + Goodies
===========

This dockerized image is based of excelent image redbuffstudio/docker-jenkins. We extends it we the last version of Jenkins and upgrade some goodies.

We also update the Dockerfile to permit in easy way to update all software.

Base:

* [Jenkins v1.598](http://jenkins-ci.org/)

Languages & Platforms:

* [PHP v5.6.2](http://php.net/ChangeLog-5.php#5.6.2)
* [Node.JS v0.10.33](http://blog.nodejs.org/2014/10/23/node-v0-10-33-stable/)
* [Ruby 2.1.5](https://www.ruby-lang.org/en/news/2014/11/13/ruby-2-1-5-is-released/)
* [Java 8u31](http://www.oracle.com/technetwork/java/javase/8u31-relnotes-2389094.html)

Utilities:

* [Fleet v0.8.3](https://github.com/coreos/fleet)
* [Composer](http://getcomposer.org/)
* [Bundler](http://bundler.io)
* [Bower](http://bower.io)
* [Grunt](http://gruntjs.com)
* [Gulp](http://gulpjs.com)
* [Wrapdocker](https://github.com/jpetazzo/dind/blob/master/wrapdocker)

# Usage

Suggested workflow:

* Install application dependencies & run tests.
* Run wrapdocker in a shell step.
* Package application into a docker image with the.
  [Docker Jenkins Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Docker+build+step+plugin)).
* Push image to private registry.
* Clean up previous tags if necessary.
* Deploy unit file to cluster with fleetOs.
* Register with ETCD.
* Service discovery with confd to configure Vulcan/HAproxy.
* Unregister previous versions with ETCD.

Example run:

`docker run --rm --name jenkins -p 80:8080 -v <persistance path>:/jenkins webcenter/jenkins:1.598-1`

# License
-------

 * Dockerized Application Copyright 2014 [Red Buff Studio LTD](http://redbuffstudio.com) and Webcenter
 * Distributed under the MIT License (hereby included)


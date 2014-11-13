Dockerized version of Jenkins-CI + Goodies
===========

Base:

* [Jenkins v1.589](http://jenkins-ci.org/)

Languages & Platforms:

* [PHP v5.6.2](http://php.net/ChangeLog-5.php#5.6.2)
* [Node.JS v0.10.33](http://blog.nodejs.org/2014/10/23/node-v0-10-33-stable/)
* [Ruby 2.1.3](https://www.ruby-lang.org/en/news/2014/09/19/ruby-2-1-3-is-released/)
* [Java 8u25](http://www.oracle.com/technetwork/java/javase/8u25-relnotes-2296185.html)

Utilities:

* [Fleet v0.8.3](https://github.com/coreos/fleet)
* [Composer](http://getcomposer.org/)
* [Bundler](http://bundler.io)
* [Bower](http://bower.io)
* [Grunt](http://gruntjs.com)
* [Wrapdocker](https://github.com/jpetazzo/dind/blob/master/wrapdocker)

# Usage

Suggested workflow:

* Install application dependencies & run tests.
* Run wrapdocker in a shell step.
* Package application into a docker image with the
  [Docker Jenkins Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Docker+build+step+plugin))
* Push image to private registry.
* Deploy unit file to cluster with fleetOs.
* Service discovery with Haproxy/Vulcan

Example run:

`docker run --privileged --rm --name jenkins -p 80:8080  -v /var/run/docker.sock:/var/run/docker.sock -v <persistance path>:/jenkins redbuffstudio/docker-jenkins:1.589-4`

# License
-------

 * Dockerized Application Copyright 2014 [Red Buff Studio LTD](http://redbuffstudio.com)
 * Distributed under the MIT License (hereby included)

# Supported tags and respective `Dockerfile` links

-	[`0.1.13`, `0.1.13-node-5.1.0`, `latest` (*grunt/Dockerfile*)](https://github.com/andreptb/Dockerfiles/blob/master/grunt/Dockerfile)

![logo](http://gruntjs.com/img/grunt-logo.svg)

## Why use a task runner?

In one word: automation. The less work you have to do when performing repetitive tasks like minification, compilation, unit testing, linting, etc, the easier your job becomes. After you've configured it through a [Gruntfile](http://gruntjs.com/sample-gruntfile), a task runner can do most of that mundane work for you—and your team—with basically zero effort.

## Why use Grunt?

The Grunt ecosystem is huge and it's growing every day. With literally hundreds of plugins to choose from, you can use Grunt to automate just about anything with a minimum of effort. If someone hasn't already built what you need, authoring and publishing your own Grunt plugin to npm is a breeze. See how to [get started](http://gruntjs.com/getting-started).

# How to use this image

The most straightforward way to use this image is to run the following (considering that *$PWD* directory contains a validhttp://gruntjs.com/getting-started#the-gruntfile

* Download [npm](https://www.npmjs.com/) dependencies:
```
docker run -it --rm --name grunt-task -v $PWD:/data grunt
```
* Download [bower](http://bower.io/) dependencies:
```
docker run -it --rm --name grunt-task -v $PWD:/data bower install
```
* Run a [grunt](http://gruntjs.com/getting-started#how-the-cli-works) task:
```
docker run -it --rm --name grunt-task -v $PWD:/data grunt
```

# What are the contents of this image ?

* Doesn't extend [library/node](http://registry.hub.docker.com/_/node). Uses  [dockerfile/debian:jessie](https://registry.hub.docker.com/_/debian/) and installs [NodeJS](https://nodejs.org) in a similar fashion. However only images for version 5.x is provided.
* Provides [Bower](http://bower.io/) package manager.
* Provides [Ruby](https://www.ruby-lang.org) with [SASS](sass-lang.com) CSS compiler.


# License

View license information for the software contained in this image:

* [Node](https://raw.githubusercontent.com/nodejs/node/master/LICENSE).
* [GruntJS](https://raw.githubusercontent.com/gruntjs/grunt/master/LICENSE-MIT).
* [Bower](https://raw.githubusercontent.com/bower/bower/master/LICENSE).
* [SASS](http://sass-lang.com/documentation/file.MIT-LICENSE.html).
* [Ruby](https://www.ruby-lang.org/en/about/license.txt);

# Supported Docker versions

This image is officially supported on Docker version 1.7.0.

# Issues

If you have any problems with or questions about this image, please contact me through a [GitHub issue](https://github.com/andreptb/Dockerfiles/issues).

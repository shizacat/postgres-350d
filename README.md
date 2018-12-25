# pg350d

Docker build of postgresql-10.6 changing the dimension limit for the cube extension, raising it to 128.

This is needed to be able to work with words embedding with postgres.

You can easily generate a build for your own need in term of dimensions by editing this dockerfile.


## What is the problem again?

The cube extension, which you'll use to perform operations on vectors, has a hard limit of 100 dimensions per vector.


## But I can create vectors with more than 100 dimensions!

Yup, I managed to do it too. With `INSERT` and `UPDATE`, the hard limit seems not to be properly checked.

The problem happens (at least) when you try to import a dump. It will fail saying that you can't have
vectors with more than 100 dimensions.

If you are using 101+ dimensions vectors with postgres currently, know that you won't be able to restore
your backups (and not upgrade postgres if you usually do so through dump/import) :)



## Download

The image dockerhub page is [here](https://cloud.docker.com/repository/docker/shizacat/pg350d).

To pull it:

```
docker pull shizacat/pg350d:10.6
```


## Is it safe?

Patching the hardcoded limit is [the recommended way in postgres doc](https://www.postgresql.org/docs/10/static/cube.html#AEN169535).

I've been using it for several months on my main business, and didn't encounter any problem so far.


## How to raise postgresql's cube extension dimensions limit?

Even if you're not familiar with docker, reading the Dockerfile from this repos
should be easy enough to teach you how to do it yourself. Spoiler:

* sources are in the `contrib/cube/` directory from postgres sources
* limit is in `contrib/cube/cubedata.h`
* make and make install should be ran with the `USE_PGXS=true` env variable


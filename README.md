# This repo is deprecated
[Go here instead](https://github.com/UAlbertaALTLab/plains-cree-fsts)


## Quick start
To generate the `crk` FSTs, clone this project and then:

```
$ docker build -t langtech .
```

Access FSTs:

```
$ docker run -it langtech
root@7106943fcb53:/# ls -l /home/langtech/langs/crk/src/
total 1129752
-rw-r--r-- 1 root root   1724322 Sep 23 06:07 analyser-disamb-gt-desc.Cans.hfstol
-rw-r--r-- 1 root root   3926844 Sep 23 06:07 analyser-disamb-gt-desc.hfst
-rw-r--r-- 1 root root   4963374 Sep 23 06:07 analyser-disamb-gt-desc.hfstol
-rw-r--r-- 1 root root   2258374 Sep 23 06:07 analyser-disamb-gt-desc.macron.hfstol
-rw-r--r-- 1 root root   1607464 Sep 23 06:07 analyser-gt-desc.Cans.hfstol
-rw-r--r-- 1 root root 273124843 Sep 23 06:10 analyser-gt-desc.Cans-to-Cans.hfst
-rw-r--r-- 1 root root 229890192 Sep 23 06:11 analyser-gt-desc.Cans-to-Cans.hfstol
-rw-r--r-- 1 root root   3926958 Sep 23 06:07 analyser-gt-desc.hfst
-rw-r--r-- 1 root root   4960038 Sep 23 06:07 analyser-gt-desc.hfstol
-rw-r--r-- 1 root root   2227996 Sep 23 06:07 analyser-gt-desc.macron.hfstol
...etc
```

See here for [getting started with FSTs][2]

## Overview
This project provides a `Dockerfile` that will generate the `.hfst` files from
the [Giellatekno][1] project. Giellatekno is an open-source project that
provides tools for modelling language mofphologies. 


## Motivation
The [Giellatekno][1] project has been around for quite a while and consists
of a *ton* of different tools including keyboards and spell checkers (not sure
what state the projects are in) not to mention quite a few different language
morphologies. However, the project takes some technical patience to get set
up completely and is also **roughly 9GB at the time of writing**. This presents
a technical barrier for getting started with the project, thus the motivation
for this utility.

The `Dockerfile` contained in this repo checks out the minimum required code
from the Giellatekno project and installs the required dependencies, and then
builds out the FSTs for the `crk` language source. The resulting docker image
without FSTS is roughly 180MB, and with FSTs is roughly 1.9GB.

## Copy files to host

The FSTs and all generated files are now created _within_ the Docker container. But we want them on our host machine. Here's how to get them out.

*Adapting the steps in this StackOverflow post: https://stackoverflow.com/questions/22049212/copying-files-from-docker-container-to-host*

1. Have a Docker container process running for `langtech`. For example, run an interactive shell:

```sh
docker run -it langtech
```

2. In a new terminal, determine the container ID of the container running the `langtech` image (this will differ for you):

```sh
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
7579c69c801d        langtech            "/bin/bash"         3 minutes ago       Up 3 minutes                            cranky_benz
```

3. use `docker cp` to copy files over from that container ID (replace `7579c69c801d` with your container ID):

```sh
docker cp 7579c69c801d:/home/langtech/langs/crk/src/analyser-gt-desc.omnivorous.hfstol .
docker cp 7579c69c801d:/home/langtech/langs/crk/src/generator-gt-norm.hfstol .
```


## LICENSE
There are 3 software licenses to be aware of concerning this project:

- The Giellatekno project is [licensed under the GPLv3 license][3].
- Similarly, this work is licensed [similarly GPLv3][4]
- **The generated FST files' licensing is currently pending**, please be aware
that the license will likely be permissive for open-source projects, however
the data may not be used for commercial purposes, and currently all rights are
reserved by the respective owners. Please contact the [authors of the itwewina
project][5] if you have any questions or concerns about the data.

**TODO:**

 - [ ] licensing
 - [ ] linguistics primer doc
 - [ ] automated build
 - [ ] publish FSTs


[1]: http://giellatekno.uit.no/index.eng.html
[2]: https://github.com/UAlbertaALTLab/itwewina/blob/development/docs/using-the-fsts.md
[3]: https://victorio.uit.no/langtech/trunk/LICENSE.txt
[4]: /LICENSE
[5]: http://altlab.ualberta.ca/itwewina/about/

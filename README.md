## Quick start
Install dependencies and build FSTs:

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
the [Giellateckno[1] project. Giellatechno is an open-source project that
provides tools for modelling language mophologies. 


## Motivation
The [Giellateckno][1] project has been around for quite a while and consists
of a *ton* of different tools including keyboards and spell checkers (not sure
what state the projects are in) not to mention quite a few different language
morphologies. However, the project takes some technical patience to get set
up completely and is also **roughly 9GB at the time of writing**. This presents
a technical barrier for getting started with the project, thus the motivation
for this utility.

The `Dockerfile` contained in this repo checks out the minimum required code
from the Giellateckno project and installs the required dependencies, and then
builds out the FSTs for the `crk` language source. The resulting docker image
without FSTS is roughly 180MB, and with FSTs is roughly 1.9GB.

**TODO:**

 - [ ] linguistics primer doc
 - [ ] automated build
 - [ ] publish FSTs


[1]: http://giellatekno.uit.no/index.eng.html
[2]: https://github.com/UAlbertaALTLab/itwewina/blob/development/docs/using-the-fsts.md
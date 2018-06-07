[![Build Status](https://travis-ci.org/pkrll/Hazel.svg?branch=master)](https://travis-ci.org/pkrll/Hazel)
[![codecov](https://codecov.io/gh/pkrll/Hazel/branch/master/graph/badge.svg)](https://codecov.io/gh/pkrll/Hazel)
<img src=".assets/hazel.png" data-canonical-src=".assets/hazel.png" />

**Hazel** is a command line tool that helps you start a new project faster -- by setting up the structure and generating common files.

- [x] Support for C projects
- [ ] Support for even more languages
- [ ] Generate git repository

### Installation

Clone this repository, and run ``make install``:

```bash
$ git clone https://github.com/pkrll/Hazel
$ cd Hazel
$ make install
```

This will install **Hazel** in ``/usr/local/bin``, along with its templates files in ``~/.hazel``.

### Usage

Run **Hazel** inside the root folder for your project to generate the directory structure:

```bash
$ mkdir SomeProject
$ hazel --type c

Created bin
Created obj
Created src
Created tests
Created Makefile
Created .editorconfig
```

##### Command line options

```bash
Usage: hazel [options]
  -t, --type:
      Choose language for project: [c|c++|swift|java|erlang]
  --no-makefile:
      Do not generate Makefile
  --no-config:
      Do not generate .editorconfig
  -h, --help:
      Print help message and exit
  -v, --version:
      Print version information and exit
```

# Author

**Hazel** was created by Ardalan Samimi. The hazel nut icon was designed by [Flaticon](https://www.flaticon.com).

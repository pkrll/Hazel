# Hazel

**Hazel** is a command line tool with the goal of lessening the hassle of setting up a project structure.

### Installation

Clone this repository, and run ``make install``:

```bash
$ git clone https://github.com/pkrll/Hazel
$ cd Hazel
$ make install
```

This will install **Hazel** in ``/usr/local/bin``.

### Usage

Run **Hazel** inside the root folder for your project to generate the directory structure:

```bash
$ mkdir SomeProject
$ hazel --new c

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
  -n, --new:
      Creates an application skeleton: [c|c++|swift|java|erlang]
  --no-makefile:
      Do not generate Makefile
  --no-config:
      Do not generate .editorconfig
  -h, --help:
      Prints a help message and exit
  -v, --version:
      Prints version information and exit
```

##### Language support

**Hazel** currently only creates directory structures and Makefiles for ``C`` projects.

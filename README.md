[![Build Status](https://travis-ci.org/pkrll/Hazel.svg?branch=master)](https://travis-ci.org/pkrll/Hazel)
[![codecov](https://codecov.io/gh/pkrll/Hazel/branch/master/graph/badge.svg)](https://codecov.io/gh/pkrll/Hazel)
<img src=".assets/hazel.png" data-canonical-src=".assets/hazel.png" />

``Hazel`` is a **cross-platform project scaffolding tool** that makes it easier to start new projects. The CLI application **generates the directory structure and boilerplate code** for your projects, based on **predefined templates**, and can **easily** be **customized and extended**.

- [x] Generate project structure based on templates
- [x] Support for macOS
- [ ] Support for Linux

## Table of contents

* [Usage](#usage)
	* [Customization](#customization)
		* [Example](#example)
		* [Placeholders](#placeholders)
		* [Command-line options](#command-line-options)
* [Installation](#installation)
	* [Prerequisites](#prerequisites)
* [Acknowledgements](#acknowledgements)

## Usage

Run ``Hazel`` inside the root folder for your project with the ``init`` command, along with the ``--type``, or ``-t``, flag to generate the directory structure and the files:

```bash
$ mkdir SomeApp && cd SomeApp
$ hazel init --type c

Created obj
Created bin
Created tests
Created src
Created obj/.gitkeep
Created bin/.gitkeep
Created Makefile
Created tests/SomeApp_test.c
Created src/SomeApp.c
Created .editorconfig
```

<img src=".assets/hazel.gif">

### Customization

``Hazel`` generates new projects based on predefined templates, placed in ``~/.hazel/templates``. You can add your own templates by simply creating a desired directory structure, along with the files you want to be automatically generated, in a subdirectory to ``~/.hazel/templates``.

The name of the subdirectory will serve as the name of the project.

#### Example

Let's create a (**very**) simple template for Swift projects.

```bash
$ cd ~/.hazel/templates

$ mkdir Swift && cd Swift
$ touch README.md
$ mkdir src
$ touch src/__PROJECTNAME__.swift

# __PROJECTNAME__ is a placeholder that will be
# replaced by the project name when running hazel

$ tree
.
├── README.md
├── src
    └── __PROJECTNAME__.swift
```

To generate new projects based on the above template, we can now initiate a new project of type ``swift``:

```bash
$ mkdir AwesomeApp && cd AwesomeApp
$ hazel init --type swift

Created README.md
Created src
Created src/AwesomeApp.c
Created .editorconfig
```

#### Placeholders

When generating new projects, ``Hazel`` will replace all occurrences of placeholder variables in the template with appropriate values. This includes both file and directory names as well as the actual contents of the template files.

As of now, support exists for the following placeholders:

| Placeholder | Description |
| :------------- | :------------- |
| ``__PROJECTNAME__`` | All occurrences of this placeholder will be replaced with the name of the project.       |
| More to come | ... |

#### Commandline options

```bash
Usage: hazel [command] [argument]

Commands:
  init           Initiate a new project

Options:
  -h, --help     Print help message and exit
  -v, --version  Print version information and exit

```

## Installation

``Hazel`` has only been tested on macOS High Sierra (10.13), so far, and is only available for download through Github.

**Prerequisites**:

* Swift 4.0
* Git

Clone this repository, and run ``make install``:

```bash
$ git clone https://github.com/pkrll/Hazel
$ cd Hazel
$ make install
```

This will install ``Hazel`` in ``/usr/local/bin``, along with its templates files in ``~/.hazel``.

## Acknowledgements

``Hazel`` was created by [Ardalan Samimi](https://github.com/pkrll). This project is licensed under the terms of the MIT license. The hazel nut icon was designed by [Flaticon](https://www.flaticon.com).

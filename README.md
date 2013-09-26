# openstack-manuals-convert

## Introduction

The Publican DocBook XML publishing tool applies relatively strict standards to the content and structure of input XML files. As such it has difficulty building documentation projects which have not been written from the ground up with Publican in mind, at least without some initial alteration.

**openstack-manuals-convert** is a script for taking DocBook XML from one such project and converting or rebasing it such that it can be built using Publican. The project in question is **openstack-manuals** which contains the XML for the documentation which appears on the http://docs.openstack.org site. The source XML is available here:

    https://github.com/openstack/openstack-manuals

As **openstack-manuals-convert** is designed primarily for use with the guides contained in the **openstack-manuals** project it will not necessarily convert any and all guides to a format that is usable by Publican. **Publicanize** is however provided as a reference for some of the common issues you will face in performing such a conversion and possible solutions.

## Prerequisites

* Bash.
* Publican 3.2.1+.
* Saxon XSLT 2.0 processor.
* ~/.publican.cfg file containing firstname, surname, and email information, This
  is used to generate a revision history entry.

    firstname: Shadow
    surname: Man
    email: shadowman@example.com

## Building

To build **openstack-manuals-convert**:

    $ git clone https://github.com/redhat-openstack/openstack-manuals-convert.git
    $ cd ./openstack-manuals-convert
    $ ./autogen.sh
    $ make rpms

## Installing

Use **yum** to **install** or **reinstall** the built package.

## Running

To run **openstack-manuals-convert**:

    $ git clone https://github.com/openstack/openstack-manuals.git
    $ cd openstack-manuals/**GUIDE**
    $ openstack-manuals-convert **[OPTIONS]**

By default the Publican-friendly version of the guide will be output to **./target/publican/**.

## Options

Usage:

    openstack-manuals-convert [OPTIONS]

````
Available OPTIONS:

  [--abstract=ABSTRACT]            Override the abstract used in the book.
  [--blacklist=BLACKLIST]          Blacklist XML files that match the list of
                                   files in the BLACKLIST file. The file is of
                                   the format:
                                   <blacklist>
                                     <entry file='FILE.xml' />
                                   </blacklist>
                                   Inclusion of files matching the provided
                                   name, regardless of path, will be removed.
                                   Images may be blacklisted in the same way.
  [--brand=BRAND]                  Override publican brand, default is \"common\".
  [--config=CONFIG]                Provide a path to an alternative publican.cfg
                                   template.
  [--customxsl=CUSTOMXSL]          Provide a path to a custom XSL transformation
                                   to apply to each XML file processed.
  [--help]                         Display usage information.
  [--images=IMAGEDIR]              Override the images used in the book with
                                   those in IMAGEDIR. Directory structure and
                                   image file names must match.
  [--output=OUTPUT]                Provide a path to use for generated output.
  [--productname=PRODUCTNAME]      Override the product name used in the book.
  [--productnumber=PRODUCTNUMBER]  Override the product number used in the book.
  [--profile=PROFILE]              Set profiling directives, e.g.:
                                   "condition: user,os: rhel"
  [--revision=REVISION]            Override the revision of the book,
                                   default is of the form:

                                       PRODUCTNUMBER-YYYYMMDD.

  [--subtitle=SUBTITLE]            Override the subtitle of the book.
  [--title=TITLE]                  Override the title of the book.
````

Example:

````
$ openstack-manuals-convert --brand="publican-fedora" \
                            --productname="Fedora" \
                            --productnumber="20"
                            --title="OpenStack User Guide"
````

### Publican RFEs

These Publican RFEs have been raised, implementation of them will streamline the conversion and packaging process:

* [893199](https://bugzilla.redhat.com/893199) Add CSS to common-db5 for centering "author" tag (same styling as corpauthor in DocBook 4.5)
* [953675](https://bugzilla.redhat.com/953675) XSL for abstract and subtitle detection assumes info element is root node of XML file (not always the case when using info file directive).
* [1004955](https://bugzilla.redhat.com/1004955) Publican print unused incorrectly detects files from higher levels in the directory structure (but within the book) as unused.

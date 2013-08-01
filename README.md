# openstack-manuals-convert

## Introduction

The Publican DocBook XML publishing tool applies relatively strict standards to the content and structure of input XML files. As such it has difficulty building documentation projects which have not been written from the ground up with Publican in mind, at least without some initial alteration.

**openstack-manuals-convert** is a script for taking DocBook XML from one such project and converting or rebasing it such that it can be built using Publican. The project in question is **openstack-manuals** which contains the XML for the documentation which appears on the http://docs.openstack.org site. The source XML is available here:

    https://github.com/openstack/openstack-manuals

As **openstack-manuals-convert** is designed primarily for use with the guides contained in the **openstack-manuals** project it will not necessarily convert any and all guides to a format that is usable by Publican. **Publicanize** is however provided as a reference for some of the common issues you will face in performing such a conversion and possible solutions.

## Prerequisites

* Bash.
* Publican 3.2.
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

By default the Publican-friendly version of the guide will be output to a temporary directory.

### Publican RFEs

These Publican RFEs have been raised, implementation of them will streamline the conversion and packaging process:

* [893199](https://bugzilla.redhat.com/893199) Add CSS to common-db5 for centering "author" tag (same styling as corpauthor in DocBook 4.5)
* [953675](https://bugzilla.redhat.com/953675) XSL for abstract and subtitle detection assumes info element is root node of XML file (not always the case when using info file directive).
* [953618](https://bugzilla.redhat.com/953618) Non-ASCII characters in image file names get mangled in publish
* [919486](https://bugzilla.redhat.com/919486) RFE: Support all DocBook conditionals
* [953998](https://bugzilla.redhat.com/953998) RFE: publican.cfg directive for specifying/overriding 'extras' directory.
* [919481](https://bugzilla.redhat.com/919481) RFE: Support changing images sub-directory name.
* [957956](https://bugzilla.redhat.com/957956) get keywords always looks for a file named <type> Info.xml even when info file set.
* [919474](https://bugzilla.redhat.com/919474) RFE: Ability to use case-insensitive "language" attributes on programlistings for compatibility with other docbook projects.
* [958495](https://bugzilla.redhat.com/958495) Running publican package on a DB5 book results in SRPM that depends on non-existent "publican-common-db5" package.

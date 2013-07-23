# openstack-manuals-convert

## Introduction

The Publican DocBook XML publishing tool applies relatively strict standards to the content and structure of input XML files. As such it has difficulty building documentation projects which have not been written from the ground up with Publican in mind, at least without some initial alteration.

**openstack-manuals-convert** is a script for taking DocBook XML from one such project and converting or rebasing it such that it can be built using Publican. The project in question is **openstack-manuals** which contains the XML for the documentation which appears on the http://docs.openstack.org site. The source XML is available here:

    https://github.com/openstack/openstack-manuals

As **openstack-manuals-convert** is designed primarily for use with the guides contained in the **openstack-manuals** project it will not necessarily convert any and all guides to a format that is usable by Publican. **Publicanize** is however provided as a reference for some of the common issues you will face in performing such a conversion and possible solutions.

## Prerequisites

* Bash.
* Publican.
* Saxon XSLT 2.0 processor.
* ~/.publican.cfg file containing firstname, surname, and email information, This
  is used to generate a revision history entry.

    firstname: Shadow
    surname: Man
    email: shadowman@example.com

## Methodology

### Directory Structure

**Problem:**

Publican has rigid expectations of the directory structure. It expects these directories, relative to the **publican.cfg** file of the book:

* ./en-US/
* ./en-US/images
* ./en-US/extras
* ./pot/

The equivalent directories in the **openstack-manuals** project are:

* . or src/
* ./figures or ./src/figures
* ./samples or ./src/samples
* ./locale or ./src/locale

Whether the first or second case applies is determined using the **sourceDirectory** element in the **pom.xml** file for the guide. In an additional complication simply providing symbolic links to these locations does not facilitate a Publican build as the XmlClean operation used to prepare the XML for a build does not appear to follow symlinks.

**Solution:**

Directories and files are automatically re-arranged to meet Publican's requirements. Where applicable **href** and **fileref** attributes are updated using an XSL transform to point to the new location of files.

### Conditionals

**Problem:**

Publican currently only supports the **condition** and **arch** profiling conditions. The **openstack-manuals** project makes extensive use of the **os** conditional.

**Solution:**

An XSL transform is used to change all **os** conditionals to **condition** conditionals. The appropriate **condition** value is set from **publican.cfg**.

### Languages

**Problem:**

Publican uses **Kate.pm** to perform syntax highlighting of **programlisting** elements based on the **language** attribute. **Kate.pm** performs strict checking of the case of the **language** attribute and Publican returns a fatal error for those that go unrecognised.

Additionally the **openstack-manuals** project sets the **language** attribute to **JSON** in some instances which is currently not a recognised value.

**Solution:**

The **language** attribute of all **programlisting** elements is transformed to the correct case. Additional where the **language** attribute is set to **JSON** then it is replaced with **JavaScript**.

### Revision History

**Problem:**

Publican requires that all books have a revision history. The content of the revision history is used in particular for generating the RPM changelog when packaging documentation.

**Solution:**

Efforts are under way to add a revision history to each upstream book, though even these updated revision history sections do not contain all the details needed for the **publican package** command to succeed. For now the script either injects a revision history, or replaces the revision history if one is found, with a revision history containing a single entry that links to the commit of the openstack-manuals project that the book was branched from.

### Publican RFEs

These Publican RFEs have been raised, implementation of them will streamline the conversion process:

* [893199](https://bugzilla.redhat.com/893199) Add CSS to common-db5 for centering "author" tag (same styling as corpauthor in DocBook 4.5)
* [953675](https://bugzilla.redhat.com/953675) XSL for abstract and subtitle detection assumes info element is root node of XML file (not always the case when using info file directive).
* [953618](https://bugzilla.redhat.com/953618) Non-ASCII characters in image file names get mangled in publish
* [919486](https://bugzilla.redhat.com/919486) RFE: Support all DocBook conditionals
* [953998](https://bugzilla.redhat.com/953998) RFE: publican.cfg directive for specifying/overriding 'extras' directory.
* [919481](https://bugzilla.redhat.com/919481) RFE: Support changing images sub-directory name.
* [957956](https://bugzilla.redhat.com/957956) get keywords always looks for a file named <type> Info.xml even when info file set.
* [919474](https://bugzilla.redhat.com/919474) RFE: Ability to use case-insensitive "language" attributes on programlistings for compatibility with other docbook projects.
* [958495](https://bugzilla.redhat.com/958495) Running publican package on a DB5 book results in SRPM that depends on non-existent "publican-common-db5" package.

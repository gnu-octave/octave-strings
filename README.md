GNU Octave Strings Toolkit
=========================

This is the official repository for the strings package for GNU Octave.

Introduction
------------

The Strings Toolkit contains additional functions for manipulation and analysis of strings.

Requirements
------------

* Octave >= 3.8.0

* libpcre3

Installing
----------

To install, run the octave package manager:

1. If running Windows, the package may already be installed:
   type pkg list, to view the installed packages.

   `pkg list`

3. To install from Source Forge:

   `pkg install -forge strings`

4. To install from a local tarball.
   
   `pkg install strings-XXXXXXX.tar.gz`
   
   Where XXXXXXX is the version of the downloaded tarball.

Usage
-----

1. Load the package.
   
   `pkg load strings`
   
   (Required each time Octave is started)

3. Use the function calls from the package.

Documentation
-------------

See the function list for [strings](https://gnu-octave.github.io/octave-strings/) for function documentation.

Known limitations and bugs
--------------------------

Please report bugs on the [issue tracker](https://github.com/gnu-octave/octave-strings/issues)

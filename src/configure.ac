#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.
#
### Copyright (C) 2015-2018 Olaf Till <i7tiol@t-online.de>
### Copyright (C) 2019-2023 John Donoghue <john.donoghue@ieee.org>
###
### This program is free software; you can redistribute it and/or
### modify it under the terms of the GNU General Public License as
### published by the Free Software Foundation; either version 3 of the
### License, or (at your option) any later version.
###
### This program is distributed in the hope that it will be useful,
### but WITHOUT ANY WARRANTY; without even the implied warranty of
### MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
### General Public License for more details.
###
### You should have received a copy of the GNU General Public License
### along with this program; if not, see
### <http://www.gnu.org/licenses/>.

AC_PREREQ([2.67])
AC_INIT([strings], [1.3.1])
AC_CONFIG_SRCDIR([pcregexp.cc])
AC_CONFIG_HEADERS([config.h])

# Avoid warnings for redefining AH-generated preprocessor symbols of
# Octave.
AH_TOP([#include "undef-ah-octave.h"])

AC_CONFIG_MACRO_DIRS([m4])


AC_CANONICAL_HOST
AC_CANONICAL_TARGET

# Checks for programs.
AC_PROG_GREP
AC_PROG_SED

AC_CHECK_PROG(MKOCTFILE, mkoctfile, mkoctfile)
if test -z "$MKOCTFILE"; then
AC_MSG_ERROR([mkoctfile not found], 1);
fi
AC_CHECK_PROG(OCTAVE_CONFIG, octave-config, octave-config)
if test -z "$OCTAVE_CONFIG"; then
AC_MSG_ERROR([octave-config not found], 1);
fi

# try get around possible spaces in the path
if test "X${IGNORE_MINGW_PATH_MODIFICATION}" == "X"; then
case $host_os in
  mingw*)
    # try demangle spaces in escaped input strings
    MKOCTFILE=`echo $MKOCTFILE | $SED "s,\\\\\ ,?,g"`
    OCTAVE_CONFIG=`echo $OCTAVE_CONFIG | $SED "s,\\\\\ ,?,g"`
    ;;
  *)
    ;;
esac
fi

#AC_CHECK_TOOL(PKG_CONFIG, pkg-config, [])
#if test -z "$PKG_CONFIG"; then
#    AC_MSG_ERROR([pkg-config not found], 1);
#fi


# The same value of CXX as Octave was compiled with is supposed to be used.
CXX=${CXX:-`${MKOCTFILE} -p CXX`}

# The check for flags to enable C++11 is broken with a C++20 compiler (because
# the type of u8"" literals changed) in autoconf before version 2.73.
# Octave requires C++11 since version 4.2, so it is enabled by the CXX as
# returned by mkoctfile. Skip broken check which would demote to C++11.
ac_cv_prog_cxx_cxx11=""

AC_PROG_CXX
  
AC_PROG_CXXCPP


# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.
USE_PCRE2=no
PKG_CHECK_MODULES([PCRE2],[libpcre2-8],
 [USE_PCRE2=yes],
 [
  PKG_CHECK_MODULES([PCRE],[libpcre],
   [],
   [PCRE_CFLAGS=""])
 ]
)
if test x$USE_PCRE2 == xyes; then
PCRE_CFLAGS="$PCRE2_CFLAGS -DUSE_PCRE2"
PCRE_LIBS=$PCRE2_LIBS
fi

if test -z "$PKG_CONFIG"; then
  # fallback detection if no pkg-config
  if test -z "$PCRE_CFLAGS"; then
    AC_CHECK_HEADERS([pcre2.h],
      [AC_CHECK_LIB([pcre2-8], [pcre2_config_8], [PCRE_CFLAGS="-DUSE_PCRE2"; PCRE_LIBS=-lpcre2-8], [])], [], [[#define PCRE2_CODE_UNIT_WIDTH 8]])
    if test -z "$PCRE_CFLAGS"; then
      AC_CHECK_HEADERS([pcre.h],
        [AC_CHECK_LIB([pcre], [pcre_config], [PCRE_CFLAGS=""; PCRE_LIBS=-lpcre], [])], [])
    fi
  fi
fi

if test -z "$PCRE_CFLAGS$PCRE_LIBS"; then
  AC_MSG_ERROR([libpcre and libpre2 not found])
fi

# Start of checks for Octave features, preparations for checks.
OCTLIBDIR=${OCTLIBDIR:-`$OCTAVE_CONFIG -p OCTLIBDIR`}
## We need Octaves include path both with and without '/octave'
## appended. The path without '/octave' is needed to selectively test
## for Octave headers, like octave/....h. The path with '/octave' is
## needed since some Octave headers contain include directives for
## other Octave headers with <> instead of "".
OCTINCLUDEDIR="${OCTINCLUDEDIR:-`$MKOCTFILE -p OCTINCLUDEDIR`}/.."

if test "X${IGNORE_MINGW_PATH_MODIFICATION}" == "X"; then
  MSYSTEM="${MSYSTEM}"
else
  MSYSTEM="none"
fi

case X$MSYSTEM in
  XMINGW64*)
    OCTAVE_HOME=`${MKOCTFILE} -p OCTAVE_HOME | $SED 's,\\\\,/,g'`
    # change \ to / and replace octave home part with mingw part
    OCTINCLUDEDIR=`echo $OCTINCLUDEDIR | $SED -e 's,\\\\,/,g' -e "s,${OCTAVE_HOME},/mingw64,g"`
    OCTLIBDIR=`echo $OCTLIBDIR | $SED -e 's,\\\\,/,g' -e "s,${OCTAVE_HOME},/mingw64,g"`
    ;;
  XMINGW32*)
    OCTAVE_HOME=`${MKOCTFILE} -p OCTAVE_HOME | $SED 's,\\\\,/,g'`
    # change \ to / and replace octave home part with mingw part
    OCTINCLUDEDIR=`echo $OCTINCLUDEDIR | $SED -e 's,\\\\,/,g' -e "s,${OCTAVE_HOME},/mingw32,g"`
    OCTLIBDIR=`echo $OCTLIBDIR | $SED -e 's,\\\\,/,g -e "s,${OCTAVE_HOME},/mingw32,g"'`
    ;;
  *)
    ;;
esac

AC_LANG_PUSH([C++])
TCXXFLAGS=$CXXFLAGS
TLDFLAGS=$LDFLAGS
TLIBS=$LIBS
TCPPFLAGS=$CPPFLAGS
LDFLAGS="-L$OCTLIBDIR $LDFLAGS"
LIBS="-loctinterp $LIBS"
# CXXFLAGS=
CPPFLAGS="-I$OCTINCLUDEDIR $CPPFLAGS"

## Simple symbol alternatives of different Octave versions.
OF_OCTAVE_LIST_ALT_SYMS([
[dnl
  [gripe_wrong_type_arg],
  [err_wrong_type_arg],
  [[err_wrong_type_arg("test");]],
  [OCTAVE__WRONG_TYPE_ARG],
  [],
  []
],
[dnl
  [unwind_protect],
  [octave::unwind_protect],
  [[octave::unwind_protect frame;]],
  [OCTAVE__UNWIND_PROTECT],
  [],
  []
]
],
   [oct-alt-includes.h])

AC_MSG_CHECKING([for octave::unwind_action])
AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
   #include <octave/oct.h>
   #include <octave/unwind-prot.h>
   #ifdef HAVE_CONFIG_H
   #  include "config.h"
   #endif
   void test_f() {}
  ]],[
    octave::unwind_action u(test_f);
  ])],
 [octave_unwind_action=yes],
 [octave_unwind_action=no]
)
AC_MSG_RESULT([$octave_unwind_action])
if test $octave_unwind_action = yes; then
  AC_DEFINE([HAVE_OCTAVE_UNWIND_ACTION],[1],[unwind_action])
fi

LIBS=$TLIBS
LDFLAGS=$TLDFLAGS
CXXFLAGS=$TCXXFLAGS
CPPFLAGS=$TCPPFLAGS
AC_LANG_POP([C++])
# End of checks for Octave features.

AC_CONFIG_FILES([Makefile])
AC_OUTPUT

SHELL   = /bin/sh

## Copyright 2015 Oliver Heimlich
##
## Copying and distribution of this file, with or without modification,
## are permitted in any medium without royalty provided the copyright
## notice and this notice are preserved.  This file is offered as-is,
## without any warranty.

## This file helps the package maintainer to
##   1. run the development version
##   2. check that all tests pass
##   3. prepare the release 
##
## This Makefile is _not_ meant to be portable. In order to use it, you
## have to install certain dependencies. This file is not distributed in
## the release tarball, so its dependencies must be met by developers only.
##
## It is intended that users of the release tarball do not need to install
## the tools and generators used here!
##
## DEPENDENCIES
##   * You should use GNU make and a GNU operating system. So far, this
##     Makefile has been used with Debian GNU/Linux 8 only and is not
##     guaranteed to work on other systems.
##
##     For example, doctest will fail on Windows, because console output
##     uses singlebyte characters on Windows and multibyte characters
##     on better systems.
##
##   * Octave package: doctest
##
##     The Octave Forge package is used to find errors in the code of
##     @example blocks from the documentation (both function documentation
##     and user manual).
##
##   * Octave package: generate_html
##
##     The Octave Forge package is used to generate the HTML documentation
##     for publication of this package on Octave Forge.
##

PACKAGE = $(shell grep "^Name: " DESCRIPTION | cut -f2 -d" ")
VERSION = $(shell grep "^Version: " DESCRIPTION | cut -f2 -d" ")
CC_SOURCES = $(wildcard src/*.cc)
CC_WITH_TESTS = $(shell grep --files-with-matches '^%!' $(CC_SOURCES))
BUILD_DIR = build
RELEASE_DIR = $(BUILD_DIR)/$(PACKAGE)-$(VERSION)
RELEASE_TARBALL = $(RELEASE_DIR).tar
RELEASE_TARBALL_COMPRESSED = $(RELEASE_TARBALL).gz
HTML_DIR = $(BUILD_DIR)/$(PACKAGE)-html
HTML_TARBALL_COMPRESSED = $(HTML_DIR).tar.gz
INSTALLED_PACKAGE = ~/octave/$(PACKAGE)-$(VERSION)/packinfo/DESCRIPTION
EXTRACTED_CC_TESTS = $(patsubst src/%.cc,$(BUILD_DIR)/inst/test/%.cc-tst,$(CC_WITH_TESTS))
GENERATED_OBJ = $(EXTRACTED_CC_TESTS)
TAR_PATCHED = $(BUILD_DIR)/.tar
OCT_COMPILED = $(BUILD_DIR)/.oct


OCTAVE ?= octave
MKOCTFILE ?= mkoctfile -Wall

.PHONY: help dist release html run check test doctest install info clean md5

help:
	@echo
	@echo "Usage:"
	@echo "   make dist     Create $(PACKAGE)-$(VERSION).tar.gz for release"
	@echo "   make html     Create $(PACKAGE)-html.tar.gz for release"
	@echo "   make release  Create both of the above plus md5 sums"
	@echo
	@echo "   make install  Install the package in GNU Octave"
	@echo "   make check    Validate the package (w/o install)"
	@echo "   make run      Run the package in GNU Octave (w/o install)"
	@echo
	@echo "   make clean    Cleanup"
	@echo

check: doctest test
dist: $(RELEASE_TARBALL_COMPRESSED)
html: $(HTML_TARBALL_COMPRESSED)
md5:  $(RELEASE_TARBALL_COMPRESSED) $(HTML_TARBALL_COMPRESSED)
	@md5sum $^

release: $(RELEASE_TARBALL_COMPRESSED) $(HTML_TARBALL_COMPRESSED) md5
	@echo "Upload @ https://sourceforge.net/p/octave/package-releases/new/"
	@echo "Execute: hg tag \"release-$(VERSION)\""

install: $(INSTALLED_PACKAGE)

clean:
	rm -rf "$(BUILD_DIR)"
	rm -f src/*.oct src/*.o
	rm -f fntests.log

$(BUILD_DIR) $(GENERATED_IMAGE_DIR) $(BUILD_DIR)/inst/test:
	@mkdir -p "$@"

$(RELEASE_TARBALL): .hg/dirstate | $(BUILD_DIR)
	@echo "Creating package release ..."
	@hg archive --exclude ".hg*" --exclude "Makefile" "$@"
	@# build/.tar* files are used for incremental updates
	@# to the tarball and must be cleared
	@rm -f $(BUILD_DIR)/.tar*

$(RELEASE_TARBALL_COMPRESSED): $(RELEASE_TARBALL)
	@echo "Compressing release tarball ..."
	@(cd "$(BUILD_DIR)" && gzip --best -f -k "../$<")
	@touch "$@"

$(INSTALLED_PACKAGE): $(RELEASE_TARBALL_COMPRESSED)
	@echo "Installing package in GNU Octave ..."
	@$(OCTAVE) --silent --eval "pkg install $<"

## Patch generated stuff into the release tarball
$(RELEASE_TARBALL_COMPRESSED): $(TAR_PATCHED)
$(TAR_PATCHED): $(GENERATED_OBJ) | $(RELEASE_TARBALL)
	@echo "Patching generated files into release tarball ..."
	@# `tar --update --transform` fails to update the files
	@# The following line is a workaroung that removes duplicates
	@tar --delete --file "$|" $(patsubst $(BUILD_DIR)/%,$(PACKAGE)-$(VERSION)/%,$?) 2> /dev/null || true
	@tar --update --file "$|" --transform="s!^$(BUILD_DIR)/!$(PACKAGE)-$(VERSION)/!" $?
	@touch "$@"

## HTML Documentation for Octave Forge
$(HTML_TARBALL_COMPRESSED): $(INSTALLED_PACKAGE) | $(BUILD_DIR)
	@echo "Generating HTML documentation for the package. This may take a while ..."
	@# The html generation has problems when there are leftovers from
	@# a previous run, see bug #45111. Since anything is generated
	@# from scratch anyway, there is no point in keeping the
	@# deprecated files.
	@rm -rf "$(HTML_DIR)"
	@$(OCTAVE) --silent --eval \
		"pkg load generate_html; \
		 options = get_html_options ('octave-forge'); \
		 generate_package_html ('$(PACKAGE)', '$(HTML_DIR)', options)"
	@tar --create --auto-compress --transform="s!^$(BUILD_DIR)/!!" --file "$@" "$(HTML_DIR)"

src/Makefile: src/Makefile.in
	@(cd src; ./bootstrap; ./configure)

## If the src/Makefile changes, recompile all oct-files
$(CC_SOURCES): src/Makefile
	@touch --no-create "$@"

## Compilation of oct-files happens in a separate Makefile,
## which is bundled in the release and will be used during
## package installation by Octave.
$(OCT_COMPILED): $(CC_SOURCES) | $(BUILD_DIR)
	@echo "Compiling OCT-files ..."
	@(cd src; MKOCTFILE="$(MKOCTFILE)" make)
	@touch "$@"

## Extract tests for oct-files. These would be lost during pkg install.
$(EXTRACTED_CC_TESTS): $(BUILD_DIR)/inst/test/%.cc-tst: src/%.cc | $(BUILD_DIR)/inst/test
	@echo "Extracting tests from $< ..."
	@rm -f "$@-t" "$@"
	@(	echo "## DO NOT EDIT!  Generated automatically from $<"; \
		grep '^%!' "$<") > "$@_"
	@mv "$@_" "$@"

## Interactive shell with the package's functions in the path
run: $(OCT_COMPILED)
	@echo "Run GNU Octave with the development version of the package"
	@$(OCTAVE) --silent --path "inst/" --path "src/"
	@echo

## Validate unit tests
test: $(OCT_COMPILED) $(EXTRACTED_CC_TESTS)
	@echo "Testing package in GNU Octave ..."
	@$(OCTAVE) --silent --path "inst/" --path "src/" \
		--eval "__run_test_suite__ ({'.'}, {})"
	@! grep '!!!!! test failed' fntests.log
	@echo

## Validate code examples
doctest: $(OCT_COMPILED)
	@echo "Testing documentation strings ..."
	@$(OCTAVE) --silent --path "inst/" --path "src/" --eval \
		"pkg load doctest; \
		 targets = '$(shell (ls inst; ls src | grep \\.oct) | cut -f2 -d@ | cut -f1 -d.)'; \
		 targets = strsplit (targets, ' '); \
		 success = doctest (targets); \
		 exit (!success)"
	@echo

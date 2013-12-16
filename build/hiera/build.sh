#!/usr/bin/bash
#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License, Version 1.0 only
# (the "License").  You may not use this file except in compliance
# with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#
#
# Copyright 2011-2012 OmniTI Computer Consulting, Inc.  All rights reserved.
# Use is subject to license terms.
# Portions Copyright 2013 Ryan Blair
#
# Load support functions
. ../../lib/functions.sh
. ../../lib/gem-functions.sh

PROG=hiera     # App name
VER=1.3.0      # App version
VERHUMAN=$VER   # Human-readable version
#PVER=          # Branch (set in config.sh, override here if needed)
PKG=${PKGPUBLISHER}/system/management/hiera  # Package name (e.g. library/foo)
SUMMARY="Lightweight Pluggable Hierarchical Database"
DESC="$PROG - $SUMMARY"

DEPENDS_IPS="omniti/runtime/ruby-19 \
  $PKGPUBLISHER/library/ruby/json_pure"
BUILD_DEPENDS_IPS="omniti/runtime/ruby-19"

RUBY_VER=1.9.1

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:

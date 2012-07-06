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
#
# Load support functions
. ../../lib/functions.sh

PROG=node-pool
VER=1.0.12
PKG=omniti/runtime/nodejs/node-pool
SUMMARY="Generic resource pooling for node.js"
DESC="$SUMMARY"

REPOS=https://github.com/coopernurse/node-pool
GIT=/usr/bin/git

BUILDARCH=64

PATH=/opt/omni/bin:$PATH
export PATH

BUILD_DEPENDS_IPS="developer/versioning/git"
DEPENDS_IPS="omniti/runtime/nodejs"

download_git() {
    pushd $TMPDIR > /dev/null
    logmsg "Checking for source directory"
    if [ -d $BUILDDIR ]; then
        logmsg "--- removing previous source checkout"
        logcmd rm -rf $BUILDDIR
    fi
    logmsg "Checking code out from git repo"
    logcmd $GIT clone $REPOS.git $BUILDDIR
    cd $BUILDDIR
    logcmd $GIT checkout v$VER
    popd > /dev/null
}

# There is no configuration for this code, so just pretend we did it
configure64() {
    true
}

make_prog() {
    logcmd "--- Pure JS, no make"
}

make_install() {
    logmsg "--- make install"
    logcmd mkdir -p $DESTDIR/opt/omni/lib/node
    logcmd cp -R $TMPDIR/$BUILDDIR $DESTDIR/opt/omni/lib/node/
    logcmd mv $DESTDIR/opt/omni/lib/node/$PROG-$VER/lib $DESTDIR/opt/omni/lib/node/generic-pool
    logcmd rm -rf $DESTDIR/opt/omni/lib/node/$PROG-$VER
}

init
download_git
patch_source
prep_build
build
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:
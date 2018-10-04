#!/bin/sh
#
# Copyright (C) 2014-2018 ABINIT group (Yann Pouillon)
#
# This file is part of the Abinit Bindings software package. For license
# information, please see the COPYING file in the top-level directory of
# the source distribution.
#

#
# IMPORTANT NOTE:
#
#   For maintainer use only!
#
#   PLEASE DO NOT EDIT THIS FILE, AS IT COULD CAUSE A SERIOUS LOSS OF DATA.
#   *** YOU HAVE BEEN WARNED! ***
#

# Check that we are in the right directory
if test ! -s "./configure.ac" -o ! -s "config/specs/bindings.conf"; then
  echo "[bndclean]   Cowardly refusing to remove something from here!" >&2
  exit 1
fi
chmod -R u+w .

# Remove temporary directories and files
echo "[bndclean]   Removing temporary directories and files"
rm -rf tmp*
find . -depth -name 'tmp-*' -exec rm -rf {} \;

# Remove autotools files
echo "[bndclean]   Removing autotools files"
rm -f core config.log config.status stamp-h1 config.h config.h.in*
rm -rf aclocal.m4 autom4te.cache configure confstat*
(cd config/gnu && rm -f compile config.guess config.sub depcomp install-sh ltmain.sh missing)
(cd config/m4 && rm -f libtool.m4 ltoptions.m4 ltsugar.m4 ltversion.m4 lt~obsolete.m4 auto-*.m4)

# Remove Makefiles and machine-generated files
echo "[bndclean]   Removing files produced by the configure script"
rm -f libtool
find . -name Makefile -exec rm {} \;
find . -name Makefile.in -exec rm {} \;
find . -name Makefile.am -exec rm {} \;

# Remove machine-generated build-system files
rm -f config/m4/auto-*.m4

# Remove compiled files
echo "[bndclean]   Removing compiled files and auxilliary data"
for ext in a la lo o; do
  find . -name "*.${ext}" -exec rm {} \;
done
for tmpdir in .deps .libs; do
  find . -depth -name "${tmpdir}" -exec rm -r {} \;
done
rm -rf \
  abinit-bindings-[0-9]* \
  libpaw/libpaw-0.* libpaw/libpaw-1.* libpaw/libpaw-*.tar.gz \
  libpaw/bindings-ready

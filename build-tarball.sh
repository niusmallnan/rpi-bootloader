#!/bin/bash
set -e
set -x

VERSION=$(cat /version)

# Create target dir for build artefacts
WORKDIR=$PWD
BUILD_DEST=/builds/$VERSION
mkdir -p $BUILD_DEST

# Clone the upstream GH repo
rm -rf $FIRMWARE
BRANCH=stable
COMMIT=98997f363e3683ead4f50c37902169248628303a
git clone --single-branch --branch $BRANCH --depth 1 $FIRMWARE_REPO $FIRMWARE
cd $FIRMWARE
git checkout -q $COMMIT

# Create tar file
TARFILE=rpi-bootloader.tar.gz
FILELIST="
boot/LICENCE.*
boot/bootcode.bin
boot/fixup*.dat
boot/start*.elf
boot/COPYING.linux
"
tar -cvzf $WORKDIR/$TARFILE $FILELIST
cd $WORKDIR
sha256sum $TARFILE > $TARFILE.sha256

# Copy build artefacts
cp $TARFILE* $BUILD_DEST/

# List build artefacts
ls -al $BUILD_DEST/

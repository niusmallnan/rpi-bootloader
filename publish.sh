#!/bin/bash
set -ex

VERSION=$(cat ./version)

for file in $(ls builds/${VERSION}); do
    github-release upload  --user niusmallnan --repo rpi-bootloader --tag ${VERSION} --file ./builds/${VERSION}/${file} --name ${file}
done


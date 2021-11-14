#!/bin/sh

# Start from a Fedora Custom Operation system base from an Everything alternative image
# Have your user already, with sudo access and git installed

# Install prompt
echo 'The executed script will install applications on an Fedora based system.'
. "${INITDIR}/common/check.sh"

# Create the basic file system
. "${INITDIR}/common/folders.sh"

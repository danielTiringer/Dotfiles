#!/bin/bash

source ./helper.sh

DISTRO=$(check_distro)

cd init
./$DISTRO.sh

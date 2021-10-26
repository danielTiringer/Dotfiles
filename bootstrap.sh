#!/bin/bash

source ./init/helper.sh

DISTRO=$(check_distro)

cd init
./$DISTRO.sh

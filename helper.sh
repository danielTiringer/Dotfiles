#!/bin/bash
check_distro() {
	lsb_release -ar 2>/dev/null | grep ID | cut -s -f2
}

DISTRO=$(check_distro)

echo $DISTRO

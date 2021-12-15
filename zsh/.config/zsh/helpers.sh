#!/bin/sh

distro_name () {
  cat /etc/os-release | grep "^ID=" | cut -d "=" -f2 | tr -d '"'
}

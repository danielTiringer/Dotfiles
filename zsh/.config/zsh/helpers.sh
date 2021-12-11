#!/bin/sh

distro_name () {
  awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }'
}

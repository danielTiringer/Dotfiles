# This file is sourced on all invocations of the shell.
# If the -f flag is present or if the NO_RCS option is
# set within this file, all other initialization files
# are skipped.
#
# This file should contain commands to set the command
# search path, plus other important environment variables.
# This file should not contain commands that produce
# output or assume the shell is attached to a tty.
#
# Global Order: zshenv, zprofile, zshrc, zlogin

# Docker env
export COMPOSER_AUTH='{"http-basic":{"artifactory.mpi-internal.com": {"username": "srv.scmh.zsozsobot@adevinta.com", "password": "AKCp5dKYyMd2aHSLpQhPXKHoxT2NwQkZZ7bPtrV6WhRNv3DDxVVxAyELyTKj5q6s9iEPqdVoE"}}}'
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1
export ARTIFACTORY_COMPOSER_AUTH='{"http-basic":{"artifactory.mpi-internal.com": {"username": "srv.scmh.zsozsobot@adevinta.com", "password": "AKCp5dKYyMd2aHSLpQhPXKHoxT2NwQkZZ7bPtrV6WhRNv3DDxVVxAyELyTKj5q6s9iEPqdVoE"}}}'
ARTIFACTORY_USERNAME=daniel.tiringer@adevinta.com
ARTIFACTORY_PASSWORD=AKCp5ekcJLptBEZuDoKsVHU4VMipTUvaccSYpYQoRWQwkBQ9sF6ZyaQuV8pQaaU1avqkzvDCx
ARTIFACTORY_DOCKER_URL=containers.mpi-internal.com

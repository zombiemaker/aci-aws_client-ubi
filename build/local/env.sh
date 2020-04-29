#!/bin/bash
# Relative location of Dockerfile to the current directory where this script is being executed
export DOCKERFILE_RELATIVE_PATH=../../
export DOCKERFILE_NAME=Dockerfile

export IMAGE_SOURCECODE_GIT_REPO_URL=localhost
export IMAGE_SOURCECODE_GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
export IMAGE_SOURCECODE_GIT_COMMIT_HASH=$(git log -1 --pretty=%h)
export IMAGE_SOURCECODE_GIT_COMMIT_TAG=$(git show-ref --tags -d | grep ^${IMAGE_SOURCECODE_GIT_COMMIT_HASH} | sed -e 's,.* refs/tags/,,' -e 's/\^{}//')
export IMAGE_SOURCECODE_GIT_COMMITTER_NAME=$(git log -1 --pretty=%cn)
export IMAGE_SOURCECODE_GIT_COMMITTER_DATE=$(git log -1 --pretty=%ci)

export IMAGE_CLASS=aci
export IMAGE_OS_BRAND=ubi
export IMAGE_OS_VERSION=8.1

export APPPLT_BRAND=
export APPPLT_VERSION=

export APP_BRAND=aws_client
export APP_VERSION=2
export APP_SOURCECODE_GIT_REPO_URL=
export APP_SOURCECODE_GIT_BRANCH=
export APP_SOURCECODE_GIT_COMMIT_HASH=
export APP_SOURCECODE_GIT_COMMIT_TAG=
export APP_SOURCECODE_GIT_COMMITTER_NAME=
export APP_SOURCECODE_GIT_COMMITTER_DATE=

export IMAGE_REPO_HOSTNAME=localhost
export IMAGE_REPO_OWNERNAME=localbuilder

export IMAGE_BUILD_COUNTER_FILE=image-build-count
export IMAGE_INFOFILE_NAME=image-info
#!/bin/bash
# Relative location of Dockerfile to the current directory where this script is being executed
export DOCKERFILE_RELATIVE_PATH=../../
export DOCKERFILE_NAME=Dockerfile

export IMAGE_SOURCECODE_GIT_REPO_URL=localhost
export IMAGE_SOURCECODE_GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
export IMAGE_SOURCECODE_GIT_COMMIT_HASH=$(git log -1 --pretty=%H)
export IMAGE_SOURCECODE_GIT_COMMIT_SHORTHASH=$(git log -1 --pretty=%h)
export IMAGE_SOURCECODE_GIT_COMMIT_TAG=$(git show-ref --tags -d | grep ^${IMAGE_SOURCECODE_GIT_COMMIT_HASH} | sed -e 's,.* refs/tags/,,' -e 's/\^{}//')
export IMAGE_SOURCECODE_GIT_COMMITTER_NAME=$(git log -1 --pretty=%cn)
export IMAGE_SOURCECODE_GIT_COMMITTER_DATE=$(git log -1 --pretty=%ci)

# CONFIGME: Set the container image class, OS brand and version, application brand and version, application brand and version
#   osci = operating system container image
#   rci = runtime container image (is a container image with runtime dependencies that apps need to run - e.g., JRE, .NET runtime)
#   dci = development container image (is a container image with development time dependencies to develop apps - e.g., JDK, .NET SDK, etc.)
#   aci = application container image (is a container image with an application configured for execution)
export IMAGE_CLASS=aci
export IMAGE_OS_BRAND=ubi
export IMAGE_OS_VERSION=8.2

export APP_PLATFORM_BRAND=
export APP_PLATFORM_VERSION=

export APP_BRAND=aws_client
export APP_VERSION=2
export APP_SOURCECODE_GIT_REPO_URL=
export APP_SOURCECODE_GIT_BRANCH=
export APP_SOURCECODE_GIT_COMMIT_HASH=
export APP_SOURCECODE_GIT_COMMIT_TAG=
export APP_SOURCECODE_GIT_COMMITTER_NAME=
export APP_SOURCECODE_GIT_COMMITTER_DATE=

case ${IMAGE_CLASS} in
    aci)
        if [ "${APP_PLATFORM_BRAND}" != "" ]
        then
            export IMAGE_REPO_NAME=${IMAGE_CLASS}-${APP_BRAND}-${APP_PLATFORM_BRAND}-${IMAGE_OS_BRAND};
            export IMAGE_TAG_BASE=${APP_VERSION}-${APP_PLATFORM_VERSION}-${IMAGE_OS_VERSION};
        else
            export IMAGE_REPO_NAME=${IMAGE_CLASS}-${APP_BRAND}-${IMAGE_OS_BRAND};
            export IMAGE_TAG_BASE=${APP_VERSION}-${IMAGE_OS_VERSION};
        fi        
    ;;
    dci)
        export IMAGE_REPO_NAME=${IMAGE_CLASS}-${APP_PLATFORM_BRAND}-${IMAGE_OS_BRAND};
        export IMAGE_TAG_BASE=${APP_PLATFORM_VERSION}-${IMAGE_OS_VERSION};
    ;;
    rci)
        export IMAGE_REPO_NAME=${IMAGE_CLASS}-${APP_PLATFORM_BRAND}-${IMAGE_OS_BRAND};
        export IMAGE_TAG_BASE=${APP_PLATFORM_VERSION}-${IMAGE_OS_VERSION};
    ;;
    osci)
        export IMAGE_REPO_NAME=${IMAGE_CLASS}-${IMAGE_OS_BRAND};
        export IMAGE_TAG_BASE=${IMAGE_OS_VERSION};
    ;;
esac

export IMAGE_BUILD_COUNTER_FILE=image-build-count
export IMAGE_INFOFILE_NAME=image-info
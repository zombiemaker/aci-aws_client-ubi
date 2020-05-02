FROM docker.io/zmaker123/osci-ubi:8.1-latest

USER root
ARG USERNAME=awsuser
ARG USER_UID=1100
ARG USER_GID=${USER_UID}

# Keep every item on a separate lines to make version control code change review easier
RUN groupadd \
        --gid $USER_GID \
        $USERNAME \
    && useradd \
        -s /bin/bash \
        --uid $USER_UID \
        --gid $USER_GID \
        --system \
        --home /home/$USERNAME \
        -m \
        $USERNAME \
    && yum update -y \
    && yum upgrade -y \
    && yum install -y \
        git \
        unzip \
    && yum clean all

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip ./awscliv2.zip \
    && ./aws/install \
    && rm -R ./awscliv2.zip ./aws

# Install AWS eksctl
RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp \
    && mv /tmp/eksctl /usr/local/bin \
    && eksctl version 

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin \
    && kubectl version --client

RUN curl "http://nginx-contentserver.mynet/software-install-files/linux-os/terraform_0.12.24_linux_amd64.zip" -o "terraform.zip" \
    && unzip ./terraform.zip \
    && chmod +x terraform \
    && mv ./terraform /usr/local/bin \
    && rm terraform.zip \
    && terraform version
# Provide a volume mount point to store configuration

# Get values from docker build CLI args
ARG IMAGE_SOURCECODE_GIT_REPO_URL=
ARG IMAGE_SOURCECODE_GIT_BRANCH=
ARG IMAGE_SOURCECODE_GIT_COMMIT_HASH=
ARG IMAGE_SOURCECODE_GIT_COMMIT_TAG=
ARG IMAGE_SOURCECODE_GIT_COMMITTER_NAME=
ARG IMAGE_SOURCECODE_GIT_COMMITTER_DATE=
ARG IMAGE_OS_BRAND=ubi
ARG IMAGE_OS_VERSION=8.1
ARG APPPLT_BRAND=
ARG APPPLT_VERSION=
ARG APP_BRAND=
ARG APP_VERSION=
ARG APP_SOURCECODE_GIT_REPO_URL=
ARG APP_SOURCECODE_GIT_BRANCH=
ARG APP_SOURCECODE_GIT_COMMIT_HASH=
ARG APP_SOURCECODE_GIT_COMMIT_TAG=
ARG APP_SOURCECODE_GIT_COMMITTER_NAME=
ARG APP_SOURCECODE_GIT_COMMITTER_DATE=

LABEL \
    image.sourcecode.git.repo.url="$IMAGE_SOURCECODE_GIT_REPO_URL" \
    image.sourcecode.git.branch="$IMAGE_SOURCECODE_GIT_BRANCH" \
    image.sourcecode.git.commit.hash="$IMAGE_SOURCECODE_GIT_COMMIT_HASH" \
    image.sourcecode.git.committer.name="$IMAGE_SOURCECODE_GIT_COMMITTER_NAME" \
    image.sourcecode.git.committer.date="$IMAGE_SOURCECODE_GIT_COMMITTER_DATE" \
    image.os.brand="$IMAGE_OS_BRAND" \
    image.os.version="$IMAGE_OS_VERSION" \
    appplt.brand="$APPPLT_BRAND" \
    appplt.version="$APPPLT_VERSION" \
    app.brand="$APP_BRAND" \
    app.version="$APP_VERSION" \
    app.sourcecode.git.repo.url="$APP_SOURCECODE_GIT_REPO_URL" \
    app.sourcecode.git.branch="$APP_SOURCECODE_GIT_BRANCH" \
    app.sourcecode.git.APP_SOURCECODE_GIT_TAG="$APP_SOURCECODE_GIT_TAG" \
    app.sourcecode.git.commit.hash="$APP_SOURCECODE_GIT_COMMIT_HASH" \
    app.sourcecode.git.committer.name="$APP_SOURCECODE_GIT_COMMITTER_NAME" \
    app.sourcecode.git.committer.date="$APP_SOURCECODE_GIT_COMMITTER_DATE" 

# Drop to non-root user
USER ${USERNAME}
WORKDIR /
COPY README.md entrypoint.sh image-info ./

# Default startup program
ENTRYPOINT ["./entrypoint.sh"]
# Default parameters passed to entrypoint
CMD ["default"]

FROM docker.io/zmaker123/osci-ubi:8.2-latest

USER root
ARG USERNAME=me
ARG USER_UID=1000
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
    && microdnf install \
        sudo \
        vi \
        git \
        unzip \
        tar \
        curl \
        wget \
        python38 \
        python38-wheel \
        python38-pip \
        python38-pip-wheel \
    && microdnf clean all

RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN echo "[centos-8.1.1911-appstream]" > /etc/yum.repos.d/centos.repo \
    && echo "name=CentOS-8 - appStream" >> /etc/yum.repos.d/centos.repo \
    && echo "baseurl=http://mirror.centos.org/centos/8.1.1911/AppStream/x86_64/os/" >> /etc/yum.repos.d/centos.repo \
    && echo "enabled=1" >> /etc/yum.repos.d/centos.repo \
    && echo "gpgcheck=0" >> /etc/yum.repos.d/centos.repo \
    && microdnf install jq-1.5 \
    && microdnf clean all \
    && pip3 install yq \
    && pip3 install json2yaml

# Install AWS CLI
RUN curl --silent "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip ./awscliv2.zip \
    && ./aws/install \
    && rm -R ./awscliv2.zip ./aws

# Install AWS eksctl
RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp \
    && mv /tmp/eksctl /usr/local/bin \
    && eksctl version 

# Install AWS IAM Authenticator
RUN curl --silent --location "https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/aws-iam-authenticator" -o aws-iam-authenticator \
    && chmod +x ./aws-iam-authenticator \
    && mv ./aws-iam-authenticator /usr/local/bin \
    && aws-iam-authenticator version 

# Install kubectl
RUN curl --silent -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin \
    && kubectl version --client

# Install Terraform
RUN curl --silent "https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip" -o "terraform.zip" \
    && unzip ./terraform.zip \
    && chmod +x terraform \
    && mv ./terraform /usr/local/bin \
    && rm terraform.zip \
    && terraform version

# Install HashiCorp Packer
RUN curl --silent "https://releases.hashicorp.com/packer/1.5.6/packer_1.5.6_linux_amd64.zip" -o "packer.zip" \
    && unzip ./packer.zip \
    && chmod +x packer \
    && mv ./packer /usr/local/bin \
    && rm packer.zip \
    && packer version

# Install Kubernetes Operations
#RUN curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64 \
RUN curl --silent -LO https://github.com/kubernetes/kops/releases/download/v1.16.1/kops-linux-amd64 -o kops-linux-amd64 \
    && chmod +x kops-linux-amd64 \
    && mv ./kops-linux-amd64 /usr/local/bin/kops

# Provide a volume mount point to store configuration

# Get values from docker build CLI args
ARG IMAGE_SOURCECODE_GIT_REPO_URL=
ARG IMAGE_SOURCECODE_GIT_BRANCH=
ARG IMAGE_SOURCECODE_GIT_COMMIT_HASH=
ARG IMAGE_SOURCECODE_GIT_COMMIT_TAG=
ARG IMAGE_SOURCECODE_GIT_COMMITTER_NAME=
ARG IMAGE_SOURCECODE_GIT_COMMITTER_DATE=
ARG IMAGE_CLASS=
ARG IMAGE_OS_BRAND=ubi
ARG IMAGE_OS_VERSION=8.2
ARG APP_PLATFORM_BRAND=
ARG APP_PLATFORM_VERSION=
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
    image.sourcecode.git.tag="$IMAGE_SOURCECODE_GIT_TAG" \
    image.sourcecode.git.commit.hash="$IMAGE_SOURCECODE_GIT_COMMIT_HASH" \
    image.sourcecode.git.committer.name="$IMAGE_SOURCECODE_GIT_COMMITTER_NAME" \
    image.sourcecode.git.committer.date="$IMAGE_SOURCECODE_GIT_COMMITTER_DATE" \
    image.os.brand="$IMAGE_OS_BRAND" \
    image.os.version="$IMAGE_OS_VERSION" \
    app.plt.brand="$APP_PLATFORM_BRAND" \
    app.plt.version="$APP_PLATFORM_VERSION" \
    app.brand="$APP_BRAND" \
    app.version="$APP_VERSION" \
    app.sourcecode.git.repo.url="$APP_SOURCECODE_GIT_REPO_URL" \
    app.sourcecode.git.branch="$APP_SOURCECODE_GIT_BRANCH" \
    app.sourcecode.git.tag="$APP_SOURCECODE_GIT_TAG" \
    app.sourcecode.git.commit.hash="$APP_SOURCECODE_GIT_COMMIT_HASH" \
    app.sourcecode.git.committer.name="$APP_SOURCECODE_GIT_COMMITTER_NAME" \
    app.sourcecode.git.committer.date="$APP_SOURCECODE_GIT_COMMITTER_DATE" 

COPY README.* entrypoint.sh image-info "/"
#RUN mkdir -p /data && chmod 755 /data && chown ${USERNAME} /data

VOLUME ["/home/${USERNAME}"]
WORKDIR "/home/${USERNAME}"

# Drop to non-root user
USER ${USERNAME}

# Default startup program
ENTRYPOINT ["/entrypoint.sh"]
# Default parameters passed to entrypoint
CMD ["default"]

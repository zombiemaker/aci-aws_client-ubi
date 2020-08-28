# AWS Client Tools On UBI

This is a Linux container image that supplies a set of software tools that enables application developers and AWS system operators to interact with AWS without having to install the tools on their local workstation computers.

## Prerequisites

- Linux container runtime such as Docker CE

## Components Included

- [AWS CLI v2](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
- [AWS eksctl](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html)
- [AWS IAM Authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
- [Kubernetes kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux)
- [Terraform CLI](https://www.terraform.io/docs/cli-index.html)
- [Kubernetes Operations (kops)](https://github.com/kubernetes/kops)
- [Helm CLI](https://helm.sh/docs/intro/)
- Python38
- git
- jq
- yq
- curl
- wget
- tar
- unzip

## Process

- Change to a directory where you want to store your programs
- Start the container mounting the current directory to /home/me container directory

> docker run -it --rm -v ${PWD}:/home/me <image-repo>:<image-tag>  

By starting the container in this manner, all programs and data you create within the container will be stored in the current directory from where you created the container.

- Test the following programs:

> aws version
> eksctl version
> terraform version
> kubectl version
> kops version
> helm version

- Configure the AWS client

> aws configure

- Enter your AWS IAM credentials
- Enter your default region name (e.g., us-east-2)
- Enter default output format (e.g., json)

The following actions require that the AWS IAM user that you are using has suitable IAM authorizations to perform the actions.

- Check to see if you are able to connect to AWS

> aws iam get-user
> aws sts get-caller-identity

## Scenarios

One usage scenario is when a user simply runs the container using docker run or docker-compose.

Another usage scenario is when a user uses the image to create a remote development container within Visual Studio Code.

## Information Resources

- [AWS CLI](https://aws.amazon.com/cli/)
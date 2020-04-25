# AWS Client Tools On UBI
This is a container image that supplies a set of software tools that enables application developers and AWS system operators to interact with AWS without having to install the tools on their local workstation computers.

# Components included:
- Git
- [AWS CLI v2](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
- [AWS eksctl](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html)
- [Kubernetes kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux)

# Start Container
> docker run -it --name aws <image-repo>:<image-tag> bash
> aws version
> eksctl version
> kubectl version
> aws configure

Enter your AWS IAM credentials
Enter your default region name (e.g., us-east-2)
Enter default output format (e.g., json)

The following actions require that the AWS IAM user that you are using has suitable IAM authorizations to perform the actions.

Check to see if you are able to connect to AWS
> aws iam get-user
> aws sts get-caller-identity




# TODOs
- Build container image testing mechanisms
- Add Hashicorp Terraform

# Information Resources
- [AWS CLI](https://aws.amazon.com/cli/)
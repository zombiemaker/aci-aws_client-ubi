#!/bin/bash

# Enable bash completion for eksctl commands
# Enable bash completion for kubectl
cd ~
cp /.bashrc ~/.bashrc
echo -e "\n. /etc/profile.d/bash_completion.sh" >> ~/.bashrc


# if default
if [ "$1" = 'default' ]
then
    # Execute default actions
    echo "Running container with defaults"
    echo "Container TCP port 9000 published for kubectl proxy"
    echo "For help with AWS CLI:  aws help"
    echo "For help with eksctl CLI:  eksctl help"
    echo "For help with Kops CLI:  kops help"
    echo "For help with kubectl CLI:  kubectl help"
    echo "For help with Terraform CLI:  terraform help"
    echo "For help with Packer CLI:  packer help"
    echo "For help with Helm CLI:  helm help"
    echo "To get started with using AWS CLI, execute the following commands:"
    echo "    aws configure"
    bash
else
    # Execute user supplied args
    # Could be any of the following programs:
    #  awscli
    #  ekscli
    #..kubectl
    echo "Running container with user supplied args"
    "$@"
fi


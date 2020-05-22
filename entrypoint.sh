#!/bin/bash

# Need to enable bash completion even when ~/.bashrc is not available because the ~/ directory is mounted
# Enable bash completion for eksctl commands
# Enable bash completion for kubectl
# Enable bash completion for aws cli
cd ~
cp /.bashrc ~/.bashrc
echo -e "\n. /etc/profile.d/bash_completion.sh" >> ~/.bashrc
echo "complete -C '/usr/local/aws-cli/v2/current/bin/aws_completer' aws" >> ~/.bashrc
source ~/.bashrc

# To make this work in Visual Studio Code remote development container, be sure to configure the devcontainer.json file with the following
# // Use this to delete the .postCreateCommandMarker file
# "initializeCommand": "rm containerfs/.vscode-server/data/Machine/.postCreateCommandMarker",
# // THIS IS NOT EXECUTED IF ~/.vscode-server/data/Machine/.postCreateCommandMarker file exists
# // Use 'postCreateCommand' to run commands after the container is created.
# // This is needed to setup bash shell
# "postCreateCommand": ["/entrypoint.sh", "ls"],

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


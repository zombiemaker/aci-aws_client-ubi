#!/bin/bash

# if default
if [ "$1" = 'default' ]
then
    # Execute default actions
    echo "Running container with defaults"
    awscli
else
    # Execute user supplied args
    # Could be any of the following programs:
    #  awscli
    #  ekscli
    #..kubectl
    echo "Running container with user supplied args"
    "$@"
fi


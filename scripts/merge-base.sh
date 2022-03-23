#!/bin/bash

if ! git config remote.base.url > /dev/null; then
    git remote add base https://github.com/birc-ctib/base-project
fi
git fetch base
git merge base/main

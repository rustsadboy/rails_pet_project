#!/bin/bash

set -e

eval $(ssh-agent -s)
echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add - > /dev/null
mkdir -p ~/.ssh
chmod 700 ~/.ssh
echo "$SSH_PRIVATE_KEY" >> ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
touch ~/.ssh/known_hosts

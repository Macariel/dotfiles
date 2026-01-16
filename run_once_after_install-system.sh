#!/bin/bash -

# Setup .ssh folder if it is not there
mkdir -p ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/config
chmod 600 ~/.ssh/config
touch ~/.ssh/known_hosts
chmod 644 ~/.ssh/known_hosts

# Setup ssh-agent
systemctl --user enable ssh-agent
systemctl --user start ssh-agent

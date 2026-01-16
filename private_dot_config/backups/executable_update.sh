#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

guake --save-preferences guake.settings
chezmoi add --encrypt guake.settings

git-repos-manager export > repo.conf
chezmoi add --encrypt repo.conf
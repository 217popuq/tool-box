#!/bin/bash

OPTS=$(getopt -o "" -l gname:,gadd: -- "$@")
eval set -- "$OPTS"

while true; do
  case "$1" in
    --gname)  GIT_USER_NAME="$2"; shift 2 ;;
    --gadd)  GIT_USER_EMAIL="$2"; shift 2 ;;
    --) shift; break ;;
    *) echo "Usage: $0 --gname <name> --gadd <email>" ; exit 1 ;;
  esac
done

# git install
apt-get install git

# git config
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

echo "Git profile set:"
echo "  Name : $GIT_USER_NAME"
echo "  Email: $GIT_USER_EMAIL"

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

# apt-update
apt-get update

# git install
apt-get install git

# git config
cd ~/
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

echo "Git profile set:"
echo "  Name : $GIT_USER_NAME"
echo "  Email: $GIT_USER_EMAIL"

# azure cli
curl -sL https://aka.ms/InstallAzureCLIDeb | bash
apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
  gpg --dearmor | tee /etc/apt/keyrings/microsoft.gpg > /dev/null
chmod go+r /etc/apt/keyrings/microsoft.gpg

AZ_DIST=$(lsb_release -cs)
echo "Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: ${AZ_DIST}
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg" | tee /etc/apt/sources.list.d/azure-cli.sources

apt-get install azure-cli

# make directory

cd ~/
mkdir .kube

# completion
echo "### WSL initial setup completed ###"
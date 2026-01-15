#!/bin/bash
set -e

# version check
echo "### versions ###"
kubectl version --client
k9s version
tenv version
terraform version
helm version

echo "### 開発ツールのインストール完了 ###"

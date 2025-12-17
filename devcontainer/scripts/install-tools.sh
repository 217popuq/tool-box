#!/bin/bash
set -e

# terraform check
echo "### terraform versions ###"
tenv version
tenv tf install $TF_VERSION
terraform version

# kubernetes check
echo "### kubernetes version ###"
kubectl version

echo "### 開発ツールのインストール完了 ###"

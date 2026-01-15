FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# user config
ARG USERNAME="vscode"
ARG GROUPNAME="vscode"
ARG USER_UID="1000"
ARG USER_GID="1000"
ARG HOME_DIR="/home/vscode"

# extension versions
ARG K8S_VERSION="v1.34"
ARG K9S_VERSION="v0.32.4"
ARG TF_VERSION="1.14.2"
ARG HELM_VERSION="v4.0.4"

# 必要パッケージ
RUN set -e \
    && apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    git \
    gnupg \
    jq \
    unzip \
    bash-completion \
    && rm -rf /var/lib/apt/lists/*

# kubernetes ツールインストール
## kubectl インストール
RUN set -e \
    && curl -fsSL https://pkgs.k8s.io/core:/stable:/${K8S_VERSION}/deb/Release.key \
    | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/${K8S_VERSION}/deb/ /" \
    | tee /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update && apt-get install -y kubectl \
    && rm -rf /var/lib/apt/lists/* \
    && kubectl version --client
## kubectx/kubens インストール
RUN set -e \
    && curl -L https://github.com/ahmetb/kubectx/releases/latest/download/kubectx \
    -o /usr/local/bin/kubectx \
    && chmod +x /usr/local/bin/kubectx \
    && curl -L https://github.com/ahmetb/kubectx/releases/latest/download/kubens \
    -o /usr/local/bin/kubens \
    && chmod +x /usr/local/bin/kubens
## k9s インストール
RUN set -e \
    && curl -L https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz \
    | tar xz -C /usr/local/bin k9s

# terraform インストール
## tenv 最新版インストール
RUN set -e \
    && LATEST_VERSION=$(curl --silent https://api.github.com/repos/tofuutils/tenv/releases/latest | jq -r .tag_name) \
    && curl -L "https://github.com/tofuutils/tenv/releases/download/${LATEST_VERSION}/tenv_${LATEST_VERSION}_amd64.deb" -o /tmp/tenv.deb \
    && dpkg -i /tmp/tenv.deb || apt-get install -f -y \
    && rm /tmp/tenv.deb \
    && tenv --version
## terraform インストール
RUN set -e \
    && tenv tf install ${TF_VERSION} \
    && tenv tf use ${TF_VERSION} \
    && ln -sf ${HOME_DIR}/.tenv/versions/tf/${TF_VERSION}/terraform /usr/local/bin/terraform \
    && terraform -version

# helm インストール
RUN set -e \
    && curl -L "https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz" \
    | tar xz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && rm -rf linux-amd64 \
    && helm version


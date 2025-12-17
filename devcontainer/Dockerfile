FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

ENV K8S_VERSION="v1.34"
    TF_VERSION="1.14.2"

# 必要パッケージ
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    git \
    gnupg \
    jq \
    unzip \
    bash-completion \
    && rm -rf /var/lib/apt/lists/*

# kubectl インストール
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/${K8S_VERSION}/deb/Release.key \
    | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/${K8S_VERSION}/deb/ /" \
       | tee /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update && apt-get install -y kubectl \
    && rm -rf /var/lib/apt/lists/*

# tenv 最新版インストール
RUN LATEST_VERSION=$(curl --silent https://api.github.com/repos/tofuutils/tenv/releases/latest | jq -r .tag_name) \
    && curl -L "https://github.com/tofuutils/tenv/releases/download/${LATEST_VERSION}/tenv_${LATEST_VERSION}_amd64.deb" -o /tmp/tenv.deb \
    && dpkg -i /tmp/tenv.deb || apt-get install -f -y \
    && rm /tmp/tenv.deb

# 動作確認（ビルド時にバージョン表示）
RUN tenv --version

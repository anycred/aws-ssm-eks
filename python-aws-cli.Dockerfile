# Container image that runs your code
FROM python:3.10-slim-bullseye
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    unixodbc-dev \
    curl \
    gpg \
    unzip \
    jq \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install && aws --version

RUN pip install pytest requests
# Install Kubectl
RUN curl -LO "https://dl.k8s.io/release/v1.21.9/bin/linux/amd64/kubectl" && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install AWS session manager plugin
RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb" && dpkg -i session-manager-plugin.deb && session-manager-plugin

# Container image that runs your code
FROM amazon/aws-cli:2.7.29

RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm" -o "session-manager-plugin.rpm" && \
    curl -LO "https://dl.k8s.io/release/v1.21.9/bin/linux/amd64/kubectl" && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

RUN yum install -y jq session-manager-plugin.rpm

RUN yum install -y net-tools procps
RUN yum update -y
RUN yum groupinstall "Development Tools" -y
RUN yum install openssl-devel libffi-devel bzip2-devel -y
RUN gcc --version
RUN yum install wget -y
RUN wget https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz
RUN tar xvf Python-3.10.0.tgz
RUN ./Python-3.10.0/configure --enable-optimizations
RUN ./Python-3.10.0/make altinstall
RUN python3.10 --version
RUN pip3.10 --version
RUN pip3.10 install poetry
RUN poetry export -f requirements.txt --output requirements.txt --without-hashes --dev
RUN pip3.10 install --no-cache-dir -r requirements.txt
RUN pip3.10 install pytest
# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

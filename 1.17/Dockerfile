FROM golang:1.17-alpine

ENV SOPS_VERSION=3.7.3
ENV DEFAULT_BIN_DIR=/tools

ENV PATH="${DEFAULT_BIN_DIR}:${PATH}"

# build-base contains gcc
RUN mkdir -p /tools/tmp &&\
    apk --no-cache add \
    bash \
    curl \
    git \
    jq \
    yq \
    unzip

RUN go install github.com/jstemmer/go-junit-report@latest &&\
    go install golang.org/x/lint/golint@latest &&\
    go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway@latest &&\
    go install github.com/golang/protobuf/protoc-gen-go@latest &&\
    go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger@latest

RUN adduser -S -D -H -h /tools notroot &&\
    curl -s "https://github.com/mozilla/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux.amd64" > "${DEFAULT_BIN_DIR}/sops"  &&\
    curl -s https://bitbucket.org/bitbucketpipelines/bitbucket-pipes-toolkit-bash/raw/0.6.0/common.sh > "${DEFAULT_BIN_DIR}/common.sh"  &&\
    chmod +x /tools/* &&\
    chown -R notroot /tools &&\
    git config --global url."git@bitbucket.org:".insteadOf "https://bitbucket.org/"

WORKDIR /builder

USER notroot

CMD ["/bin/sh"]

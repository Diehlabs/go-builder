FROM golang:1.18-alpine

ENV GRUNTWORK_INSTALLER_VERSION=0.0.38
# ENV DEFAULT_MODULES_DOWNLOAD_DIR=
ENV DEFAULT_BIN_DIR=/tools
ENV PATH="/tools:${PATH}"

RUN mkdir -p /tools/tmp &&\
    apk --no-cache add \
    bash \
    curl \
    jq \
    yq \
    unzip

COPY ./scripts/ /tools/

RUN adduser -S -D -H -h /tools notroot &&\
    chmod +x /tools/*.sh &&\
    chown -R notroot /tools &&\
    curl -LsS https://raw.githubusercontent.com/gruntwork-io/gruntwork-installer/master/bootstrap-gruntwork-installer.sh | bash /dev/stdin --version "v${GRUNTWORK_INSTALLER_VERSION}" --no-sudo true

WORKDIR /tools

USER notroot

CMD ["/bin/sh"]

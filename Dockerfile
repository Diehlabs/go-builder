FROM golang:1.18-alpine

RUN apk --no-cache add \
    curl \
    jq \
    yq \
    unzip

RUN mkdir /scripts

COPY ./scripts/ /scripts/

RUN adduser -S -D -H -h /app notroot &&\
    chmod +x /scripts/*.sh &&\
    chown -R notroot /scripts

WORKDIR /scripts

USER notroot

CMD ["/bin/sh"]

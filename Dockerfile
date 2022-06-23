FROM golang:1.18-alpine

RUN mkdir /scripts

COPY ./scripts/ /scripts/

WORKDIR /scripts

RUN adduser -S -D -H -h /app notroot

USER notroot

CMD ["/bin/sh"]

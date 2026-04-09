FROM alpine:3.22 AS builder
LABEL org.opencontainers.image.source="https://github.com/stroeer/docker-images"

ARG TARGETARCH
ENV BUF_VERSION="1.52.1"

RUN set -eux; \
    apk add --no-cache curl; \
    mkdir -p /opt; \
    case "${TARGETARCH}" in  \
      "amd64") export ARCH="x86_64" ;; \
      "arm64") export ARCH="aarch64" ;; \
      *)       export ARCH="$TARGETARCH" ;; \
    esac; \
    curl -L -o /opt/buf.tar.gz "https://github.com/bufbuild/buf/releases/download/v${BUF_VERSION}/buf-Linux-${ARCH}.tar.gz";

RUN mkdir -p /opt/buf && tar -xzf /opt/buf.tar.gz -C /opt/buf --strip-components=1

# see https://hub.docker.com/_/eclipse-temurin/tags?name=21-jre-alpine
FROM eclipse-temurin:21-jre-alpine@sha256:6ad8ed080d9be96b61438ec3ce99388e294af216ed57356000c06070e85c5d5d

COPY --from=builder /opt/buf/bin/buf /usr/bin/buf

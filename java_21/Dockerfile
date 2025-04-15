FROM alpine:3.21 AS builder
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
FROM eclipse-temurin:21-jre-alpine@sha256:4e9ab608d97796571b1d5bbcd1c9f430a89a5f03fe5aa6c093888ceb6756c502

COPY --from=builder /opt/buf/bin/buf /usr/bin/buf

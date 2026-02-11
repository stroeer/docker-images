FROM alpine:3.22 AS builder
LABEL org.opencontainers.image.source="https://github.com/stroeer/docker-images"

ARG TARGETARCH
ENV BUF_VERSION="1.57.0"
ENV GRPC_HEALTH_PROBE_VERSION="0.4.40"

# Install both `buf` and `grpc_health_probe` CLI tools in this release. The idea is to switch to grpc_health_probe
# in the future, but to not have a breaking change vs the older images, install both.

RUN set -eux; \
    mkdir -p /opt; \
    case "${TARGETARCH}" in  \
      "amd64") export BUF_ARCH="x86_64" \
               export GRPC_ARCH="amd64" ;; \
      "arm64") export BUF_ARCH="aarch64" \
               export GRPC_ARCH="arm64" ;; \
      *)       export BUF_ARCH="$TARGETARCH" \
               export GRPC_ARCH="$TARGETARCH" ;; \
    esac; \
    wget -O /opt/buf.tar.gz "https://github.com/bufbuild/buf/releases/download/v${BUF_VERSION}/buf-Linux-${BUF_ARCH}.tar.gz"; \
    wget -O /opt/grpc_health_probe "https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/v${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-${GRPC_ARCH}";

RUN mkdir -p /opt/buf && tar -xzf /opt/buf.tar.gz -C /opt/buf --strip-components=1
RUN chmod +x /opt/grpc_health_probe

# see https://hub.docker.com/_/eclipse-temurin/tags?name=25.0.2_10-jre-alpine
FROM eclipse-temurin:25.0.2_10-jre-alpine@sha256:f10d6259d0798c1e12179b6bf3b63cea0d6843f7b09c9f9c9c422c50e44379ec

COPY --from=builder /opt/buf/bin/buf /usr/bin/buf
COPY --from=builder /opt/grpc_health_probe /usr/bin/grpc_health_probe

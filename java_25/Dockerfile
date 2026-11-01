FROM alpine:3.24 AS builder
LABEL org.opencontainers.image.source="https://github.com/stroeer/docker-images"

ARG TARGETARCH
ENV GRPC_HEALTH_PROBE_VERSION="0.4.56"

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
    wget -O /opt/grpc_health_probe "https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/v${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-${GRPC_ARCH}";

RUN chmod +x /opt/grpc_health_probe

# see https://hub.docker.com/_/eclipse-temurin/tags
FROM eclipse-temurin:27_35-jre-alpine@sha256:0faf24c1d1e778bbc0700fc71c53b081c9432f1e51e6e41c86c63840e8b89ac1

COPY --from=builder /opt/grpc_health_probe /usr/bin/grpc_health_probe

# brotli-libs < 1.2.1-r0 is vulnerable (CVE-2026-111497); drop once the base image ships the fix
RUN apk add --no-cache --upgrade "brotli-libs>=1.2.1-r0"

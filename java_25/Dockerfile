FROM alpine:3.24 AS builder
LABEL org.opencontainers.image.source="https://github.com/stroeer/docker-images"

ARG TARGETARCH
ENV GRPC_HEALTH_PROBE_VERSION="0.4.61"

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
FROM eclipse-temurin:25.0.5.1_2-jre-alpine@sha256:69c2a26e9894016e274c880fa542956d005b3755f84db765145185e87405bd89

COPY --from=builder /opt/grpc_health_probe /usr/bin/grpc_health_probe

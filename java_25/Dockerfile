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

# see https://hub.docker.com/_/eclipse-temurin/tags?name=25.0.4_7-jre-alpine
FROM eclipse-temurin:25.0.4_7-jre-alpin@sha256:3137541deb3cac6626b5d9a4a2187bc0d6a34312f858bd2c67dd01e732e6b682

COPY --from=builder /opt/grpc_health_probe /usr/bin/grpc_health_probe

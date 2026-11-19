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

# wiz-ti:mitigation CVE-2026-114938 until eclipse-temurin ships openjdk >= 25.0.6
# Temurin 25.0.5_8 is the newest published tag and still vulnerable; Alpine's openjdk25 25.0.5.1_p2-r0 carries the fix.
FROM alpine:3.24

RUN apk add --no-cache 'openjdk25-jre-headless>=25.0.5.1_p2-r0' \
    && mkdir -p /opt/java \
    && ln -s /usr/lib/jvm/java-25-openjdk /opt/java/openjdk

ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="/opt/java/openjdk/bin:${PATH}"

COPY --from=builder /opt/grpc_health_probe /usr/bin/grpc_health_probe

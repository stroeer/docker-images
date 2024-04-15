FROM alpine:3.15 as builder
LABEL org.opencontainers.image.source="https://github.com/stroeer/docker-images"

ARG TARGETARCH
ENV GRPCURL_VERSION="1.9.1"

RUN set -eux; \
    apk add --no-cache curl; \
    mkdir -p /opt; \
    case "${TARGETARCH}" in  \
      "amd64") export ARCH="x86_64" ;; \
      *)       export ARCH="$TARGETARCH" ;; \
    esac; \
    curl -L -o /opt/grpcurl.tar.gz "https://github.com/fullstorydev/grpcurl/releases/download/v${GRPCURL_VERSION}/grpcurl_${GRPCURL_VERSION}_linux_${ARCH}.tar.gz";

RUN tar xvf /opt/grpcurl.tar.gz -C /opt

FROM eclipse-temurin:21-jre-alpine@sha256:6f78a61a2aa1e6907dda2da3eb791d44ef3d18e36aee1d1bdaa3543bd44cff4b

COPY --from=builder /opt/grpcurl /usr/bin/grpcurl

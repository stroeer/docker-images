FROM alpine:3.21 as builder
LABEL org.opencontainers.image.source="https://github.com/stroeer/docker-images"

ARG TARGETARCH
ENV GRPCURL_VERSION="1.9.3"

RUN set -eux; \
    apk add --no-cache curl; \
    mkdir -p /opt; \
    case "${TARGETARCH}" in  \
      "amd64") export ARCH="x86_64" ;; \
      *)       export ARCH="$TARGETARCH" ;; \
    esac; \
    curl -L -o /opt/grpcurl.tar.gz "https://github.com/fullstorydev/grpcurl/releases/download/v${GRPCURL_VERSION}/grpcurl_${GRPCURL_VERSION}_linux_${ARCH}.tar.gz";

RUN tar xvf /opt/grpcurl.tar.gz -C /opt

FROM eclipse-temurin:21-jre-alpine@sha256:4e9ab608d97796571b1d5bbcd1c9f430a89a5f03fe5aa6c093888ceb6756c502

COPY --from=builder /opt/grpcurl /usr/bin/grpcurl

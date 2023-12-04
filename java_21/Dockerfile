FROM alpine:3.15 as builder

ARG TARGETARCH
ENV GRPCURL_VERSION="1.8.7"

RUN set -eux; \
    apk add --no-cache curl; \
    mkdir -p /opt; \
    case "${TARGETARCH}" in  \
      "amd64") export ARCH="x86_64" ;; \
      *)       export ARCH="$TARGETARCH" ;; \
    esac; \
    curl -L -o /opt/grpcurl.tar.gz "https://github.com/fullstorydev/grpcurl/releases/download/v${GRPCURL_VERSION}/grpcurl_${GRPCURL_VERSION}_linux_${ARCH}.tar.gz";

RUN tar xvf /opt/grpcurl.tar.gz -C /opt

FROM eclipse-temurin:21-jre-alpine@sha256:9a21ac97b76e52f4b58d5d6c7fdd459cd600cce8724a31fc0a2b4346b35bced2

COPY --from=builder /opt/grpcurl /usr/bin/grpcurl

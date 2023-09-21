FROM alpine:3.18 as builder

ARG TARGETARCH
ENV GRPCURL_VERSION="1.8.7"

RUN set -eux; \
    apk add --no-cache curl; \
    mkdir -p /opt; \
    case "${TARGETARCH}" in  \
      "amd64")  curl -L -o /opt/grpcurl.tar.gz "https://github.com/fullstorydev/grpcurl/releases/download/v${GRPCURL_VERSION}/grpcurl_${GRPCURL_VERSION}_linux_x86_64.tar.gz" ;; \
      *)        curl -L -o /opt/grpcurl.tar.gz "https://github.com/fullstorydev/grpcurl/releases/download/v${GRPCURL_VERSION}/grpcurl_${GRPCURL_VERSION}_linux_${TARGETARCH}.tar.gz" ;; \
    esac;

RUN tar xvf /opt/grpcurl.tar.gz -C /opt

FROM openjdk:21-jdk-slim

COPY --from=builder /opt/grpcurl /usr/bin/grpcurl

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

FROM eclipse-temurin:21-jre-alpine@sha256:e3687e5a67d0e58546c76edef4022dc34163bdc5fa2e6d493be9c9b7ce347a00

COPY --from=builder /opt/grpcurl /usr/bin/grpcurl

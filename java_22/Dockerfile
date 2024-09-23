FROM alpine:3.20 as builder
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

FROM eclipse-temurin:23-jre-alpine@sha256:fec55c7cb02d69d3b7626d0d926355390e13ce9ecf90cf37b42fd22c6f7e0af1

COPY --from=builder /opt/grpcurl /usr/bin/grpcurl

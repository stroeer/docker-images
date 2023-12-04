FROM alpine:3.18 as builder

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

FROM eclipse-temurin:21-jre-alpine@sha256:6b990458235e07c018abfc2d21f6f284789e3f97cf542402ad226b3724d8ea7b

COPY --from=builder /opt/grpcurl /usr/bin/grpcurl

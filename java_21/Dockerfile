FROM alpine:3.18 as builder

ARG TARGETARCH
ENV GRPCURL_VERSION="1.8.7"
RUN echo $SHELL
RUN ARCH=$(case "${TARGETARCH}" in "amd64") echo "x86_64" ;; *) echo "${TARGETARCH}" ;; esac) \
    && echo "$ARCH" \
    && echo "https://github.com/fullstorydev/grpcurl/releases/download/v${GRPCURL_VERSION}/grpcurl_${GRPCURL_VERSION}_linux_$ARCH.tar.gz"

RUN apk add --no-cache curl \
    && mkdir -p /opt \
    && ARCH=$(case "${TARGETARCH}" in "amd64") echo "x86_64" ;; *) echo "${TARGETARCH}" ;; esac) \
    && curl -L -o /opt/grpcurl.tar.gz "https://github.com/fullstorydev/grpcurl/releases/download/v${GRPCURL_VERSION}/grpcurl_${GRPCURL_VERSION}_linux_$ARCH.tar.gz"

RUN tar xvf /opt/grpcurl.tar.gz -C /opt

FROM openjdk:21-jdk-slim

COPY --from=builder /opt/grpcurl /usr/bin/grpcurl

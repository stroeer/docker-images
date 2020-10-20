FROM debian:10 as builder

ENV GRPCURL_VERSION="1.7.0"

RUN apt update && apt install -y curl \
    && mkdir -p /opt \
    && curl -L -o /opt/grpcurl.tar.gz https://github.com/fullstorydev/grpcurl/releases/download/v${GRPCURL_VERSION}/grpcurl_${GRPCURL_VERSION}_linux_x86_64.tar.gz

RUN tar xvf /opt/grpcurl.tar.gz -C /opt

# using full sha256 here to make build reproducable
FROM gcr.io/distroless/java@sha256:28ec552405a92ed1a3767b81aaece5c48bd1b89dfb5f3c144b0e4cea4dd5ffa4

COPY --from=builder /opt/grpcurl /usr/bin/grpcurl 
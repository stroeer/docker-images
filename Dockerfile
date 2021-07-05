FROM debian:10 as builder

ENV GRPCURL_VERSION="1.7.0"

RUN apt update && apt install -y curl \
    && mkdir -p /opt \
    && curl -L -o /opt/grpcurl.tar.gz https://github.com/fullstorydev/grpcurl/releases/download/v${GRPCURL_VERSION}/grpcurl_${GRPCURL_VERSION}_linux_x86_64.tar.gz

RUN tar xvf /opt/grpcurl.tar.gz -C /opt

# using full sha256 here to make build reproducable
FROM gcr.io/distroless/java@sha256:0e4857106b8bfad3f7d1b0efc2dcbbd82eee6b678b5b78663ee5447ae9c0b33d

COPY --from=builder /opt/grpcurl /usr/bin/grpcurl 

FROM debian:10 as builder

ENV GRPCURL_VERSION="1.6.0"

RUN apt update && apt install -y curl \
    && mkdir -p /opt \
    && curl -L -o /opt/grpcurl.tar.gz https://github.com/fullstorydev/grpcurl/releases/download/v${GRPCURL_VERSION}/grpcurl_${GRPCURL_VERSION}_linux_x86_64.tar.gz

RUN tar xvf /opt/grpcurl.tar.gz -C /opt

# using full sha256 here to make build reproducable
FROM gcr.io/distroless/java@sha256:9d4092ba5e1c9dc4d1490fdead1dd7ea5c64e635b729fee11a6af55f51b337f8

COPY --from=builder /opt/grpcurl /opt/grpcurl 
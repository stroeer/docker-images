FROM debian:10 as builder

ENV GRPCURL_VERSION="1.8.1"

RUN apt update && apt install -y curl \
    && mkdir -p /opt \
    && curl -L -o /opt/grpcurl.tar.gz https://github.com/fullstorydev/grpcurl/releases/download/v${GRPCURL_VERSION}/grpcurl_${GRPCURL_VERSION}_linux_x86_64.tar.gz

RUN tar xvf /opt/grpcurl.tar.gz -C /opt

# using full sha256 here to make build reproducable
FROM gcr.io/distroless/java@sha256:b25c7a4f771209c2899b6c8a24fda89612b5e55200ab14aa10428f60fd5ef1d1

COPY --from=builder /opt/grpcurl /usr/bin/grpcurl 

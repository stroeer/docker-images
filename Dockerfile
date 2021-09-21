FROM alpine:3.14 as builder

ENV GRPCURL_VERSION="1.8.2"

RUN apk add --no-cache curl \
    && mkdir -p /opt \
    && curl -L -o /opt/grpcurl.tar.gz https://github.com/fullstorydev/grpcurl/releases/download/v${GRPCURL_VERSION}/grpcurl_${GRPCURL_VERSION}_linux_x86_64.tar.gz

RUN tar xvf /opt/grpcurl.tar.gz -C /opt

# using full sha256 here to make build reproducable
FROM amazoncorretto:17-alpine

COPY --from=builder /opt/grpcurl /usr/bin/grpcurl 
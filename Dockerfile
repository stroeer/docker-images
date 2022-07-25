FROM alpine:3.15 as builder

ENV GRPCURL_VERSION="1.8.6"

RUN apk add --no-cache curl \
    && mkdir -p /opt \
    && curl -L -o /opt/grpcurl.tar.gz https://github.com/fullstorydev/grpcurl/releases/download/v${GRPCURL_VERSION}/grpcurl_${GRPCURL_VERSION}_linux_x86_64.tar.gz

RUN tar xvf /opt/grpcurl.tar.gz -C /opt

# using full sha256 here to make build reproducable
FROM eclipse-temurin:17-jre@sha256:ff7a89fe868ba504b09f93e3080ad30a75bd3d4e4e7b3e037e91705f8c6994b3

COPY --from=builder /opt/grpcurl /usr/bin/grpcurl 

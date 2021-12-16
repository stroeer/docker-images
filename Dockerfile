FROM alpine:3.15 as builder

ENV GRPCURL_VERSION="1.8.5"

RUN apk add --no-cache curl \
    && mkdir -p /opt \
    && curl -L -o /opt/grpcurl.tar.gz https://github.com/fullstorydev/grpcurl/releases/download/v${GRPCURL_VERSION}/grpcurl_${GRPCURL_VERSION}_linux_x86_64.tar.gz

RUN tar xvf /opt/grpcurl.tar.gz -C /opt

# using full sha256 here to make build reproducable
# eclipse-temurin:17.0.1_12-jdk-alpine 
# https://hub.docker.com/layers/eclipse-temurin/library/eclipse-temurin/17.0.1_12-jdk-alpine/images/sha256-b30fa3ce4323ce037cb95fd2729dd4662d86f0ee2986452527cc645eaf258a1d?context=explore
FROM eclipse-temurin:17-jdk-alpine@sha256:b30fa3ce4323ce037cb95fd2729dd4662d86f0ee2986452527cc645eaf258a1d

COPY --from=builder /opt/grpcurl /usr/bin/grpcurl 

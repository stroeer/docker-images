FROM alpine:3.15 as builder

ENV GRPCURL_VERSION="1.8.6"

RUN apk add --no-cache curl \
    && mkdir -p /opt \
    && curl -L -o /opt/grpcurl.tar.gz https://github.com/fullstorydev/grpcurl/releases/download/v${GRPCURL_VERSION}/grpcurl_${GRPCURL_VERSION}_linux_x86_64.tar.gz

RUN tar xvf /opt/grpcurl.tar.gz -C /opt

# using full sha256 here to make build reproducable
FROM eclipse-temurin:17-jre-focal@sha256:96e20be9405634200715c9a5793c3b01d04e61b48f05937e85ca2941d5e9e712

COPY --from=builder /opt/grpcurl /usr/bin/grpcurl 

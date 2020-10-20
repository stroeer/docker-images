FROM debian:10 as builder

ENV GRPCURL_VERSION="1.6.0"

RUN apt update && apt install -y curl \
    && mkdir -p /opt \
    && curl -L -o /opt/grpcurl.tar.gz https://github.com/fullstorydev/grpcurl/releases/download/v${GRPCURL_VERSION}/grpcurl_${GRPCURL_VERSION}_linux_x86_64.tar.gz

RUN tar xvf /opt/grpcurl.tar.gz -C /opt

# using full sha256 here to make build reproducable
FROM gcr.io/distroless/java@sha256:8dd4606ead0960f90b733d945ae050fc283c3d798bca95e5801de19d32913db0

COPY --from=builder /opt/grpcurl /usr/bin/grpcurl 

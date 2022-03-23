ARG UPSTREAM_VERSION=2.23.1
FROM amazon/aws-for-fluent-bit:${UPSTREAM_VERSION}

ADD conf/* /fluent-bit/conf/
ADD parsers/* /fluent-bit/parsers/
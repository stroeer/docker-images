ARG UPSTREAM_VERSION
FROM amazon/aws-for-fluent-bit:${UPSTREAM_VERSION}

ADD conf/* /fluent-bit/conf/
ADD parsers/* /fluent-bit/parsers/
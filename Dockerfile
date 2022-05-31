ARG UPSTREAM_VERSION
FROM amazon/aws-for-fluent-bit:${UPSTREAM_VERSION}

ADD config/* /fluent-bit/config/
ADD parsers/* /fluent-bit/parsers/
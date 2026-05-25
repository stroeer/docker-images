# https://hub.docker.com/layers/envoyproxy/envoy/v1.37.2/images/sha256-8e86fb9dd0f429e83895e63cf77986aa739ead10d6d698639bce852101b98d57
FROM envoyproxy/envoy:v1.38.0@sha256:8146b97ee61a42cd216514709e4e3198af75f014974e3d9f310aef9c901fcbdf

RUN \
  apt-get update \
  && apt-get -y install gettext-base \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY ca.pem /etc/ssl/certs/ca.pem
COPY envoy.template.yaml /etc/envoy/envoy.template.yaml
RUN chmod go+r /etc/envoy/envoy.template.yaml /etc/ssl/certs/ca.pem \
    && chmod go+w /etc/envoy/ \
    && rm /etc/envoy/envoy.yaml
COPY custom-entrypoint.sh /custom-entrypoint.sh

USER envoy
ENTRYPOINT ["/custom-entrypoint.sh"]
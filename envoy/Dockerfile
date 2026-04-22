# https://hub.docker.com/layers/envoyproxy/envoy/v1.37.2/images/sha256-8e86fb9dd0f429e83895e63cf77986aa739ead10d6d698639bce852101b98d57
FROM envoyproxy/envoy:v1.37.2@sha256:c5e8a68e52f4d4697a9adb280dbe415d77fedf1257e183dcb86205bd438f18bd

RUN \
  apt-get update \
  && apt-get -y install gettext-base \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY envoy.template.yaml /etc/envoy/envoy.template.yaml
RUN chmod go+r /etc/envoy/envoy.template.yaml \
    && chmod go+w /etc/envoy/ \
    && rm /etc/envoy/envoy.yaml
COPY custom-entrypoint.sh /custom-entrypoint.sh

USER envoy
ENTRYPOINT ["/custom-entrypoint.sh"]
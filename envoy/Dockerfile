# https://hub.docker.com/layers/envoyproxy/envoy/v1.38.3/images/sha256-5f3e2f88bbeabefcdbc871f976529334aba158a3ffb17be021904f9d4c81f1c8
FROM envoyproxy/envoy:v1.39.1@sha256:57e14a549d7bd43c8d3f6d03e8cfa653e037d4b38e133acd9b54f38c524401b4

# version pin required by security scanner, see https://ubuntu.pkgs.org/22.04/ubuntu-main-amd64/ for updates if needed
RUN \
  apt-get update \
  && apt-get -y install --no-install-recommends gettext-base=0.21-4ubuntu4 \
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
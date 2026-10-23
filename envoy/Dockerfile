# https://hub.docker.com/layers/envoyproxy/envoy/v1.40.1/images/sha256-7b088327f38b3d5d2dac1855b2722ab398dbfe32d38929b4a9599d740d746d8b?tab=layers
FROM envoyproxy/envoy:v1.40.1@sha256:713bb146f1a7c97ebc70e13d259f77ff36f2c5d00f3145677816af5af9bd1530

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
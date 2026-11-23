# https://hub.docker.com/r/envoyproxy/envoy/tags
FROM envoyproxy/envoy:v1.40.2@sha256:8de97e654644827d62afdbf7e1d3dc9fee01a8690d410dd1c63a30dc6b6cecbb

# version pin required by security scanner, see https://ubuntu.pkgs.org/22.04/ubuntu-main-amd64/ for updates if needed
# apt/libapt-pkg6.0 pinned for CVE-2026-109518 (envoy v1.40.2 base still ships 2.4.14);
# remove once the envoyproxy/envoy base image ships apt >= 2.4.15ubuntu0.1.
RUN \
  apt-get update \
  && apt-get -y install --no-install-recommends gettext-base=0.21-4ubuntu4 \
     apt=2.4.15ubuntu0.1 libapt-pkg6.0=2.4.15ubuntu0.1 \
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
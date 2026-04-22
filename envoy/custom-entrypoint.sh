#!/usr/bin/env bash

envsubst < /etc/envoy/envoy.template.yaml > /etc/envoy/envoy.yaml
chmod go+r /etc/envoy/envoy.yaml

# delegate start of envoy to the default entrypoint script
./docker-entrypoint.sh
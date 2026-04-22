#!/usr/bin/env bash

envsubst < /etc/envoy/envoy.template.yaml > /etc/envoy/envoy.yaml
chmod go+r /etc/envoy/envoy.yaml

envoy --config-path /etc/envoy/envoy.yaml
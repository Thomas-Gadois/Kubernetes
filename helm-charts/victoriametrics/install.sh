#!/bin/bash
helm repo add vm https://victoriametrics.github.io/helm-charts/
helm repo update

helm upgrade --install victoriametrics vm/victoria-metrics-single \
  --namespace monitoring \
  --values values.yaml
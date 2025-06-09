#!/bin/bash

echo "Suppression de la stack de monitoring..."

helm uninstall grafana -n monitoring
helm uninstall loki -n monitoring
helm uninstall victoriametrics -n monitoring
helm uninstall prometheus -n monitoring

kubectl delete namespace monitoring

echo "Nettoyage terminé!"
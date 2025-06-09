#!/bin/bash

echo "Déploiement de la stack de monitoring..."

# Création du namespace
kubectl apply -f namespaces/monitoring-namespace.yaml

# Création du stockage
echo "Configuration du stockage NFS..."
kubectl apply -f storage/nfs-storage-class.yaml
kubectl apply -f storage/prometheus-pvc.yaml
kubectl apply -f storage/victoriametrics-pvc.yaml
kubectl apply -f storage/loki-pvc.yaml
kubectl apply -f storage/grafana-pvc.yaml

# Attendre que les PVCs soient créés
sleep 10

chmod +x helm-charts/prometheus/install.sh
chmod +x helm-charts/victoriametrics/install.sh
chmod +x helm-charts/loki/install.sh
chmod +x helm-charts/grafana/install.sh

# Installation des composants
echo "Installation de Prometheus..."
cd helm-charts/prometheus && ./install.sh && cd ../..

echo "Installation de VictoriaMetrics..."
cd helm-charts/victoriametrics && ./install.sh && cd ../..

echo "Installation de Loki..."
cd helm-charts/loki && ./install.sh && cd ../..

echo "Installation de Grafana..."
cd helm-charts/grafana && ./install.sh && cd ../..

echo "Déploiement terminé!"
echo "Vérification des pods:"
kubectl get pods -n monitoring

#!/bin/sh
echo "=== -START APPLY- ==="
kubectl apply -f ../confs/ingress.yaml
kubectl apply -f ../confs/deployment-app1.yaml
kubectl apply -f ../confs/deployment-app2.yaml
kubectl apply -f ../confs/deployment-app3.yaml
echo "=== -END APPLY- ==="
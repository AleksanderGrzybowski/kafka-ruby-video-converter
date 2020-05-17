#! /bin/bash
set -e

eval $(minikube docker-env)
docker build -t converter . --no-cache

kubectl config use-context minikube
kubectl delete pod -l app=converter --force --grace-period=0
kubectl apply -f converter.yml

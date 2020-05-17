#! /bin/bash
set -e

# see popular GitHub issue
minikube ssh sudo ip link set docker0 promisc on

kubectl config use-context minikube
kubectl apply -f infra.yml

#! /bin/bash

kubectl get pod -l "app=$1" -o jsonpath='{.items[0].metadata.name}'
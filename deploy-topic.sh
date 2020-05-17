#! /bin/bash
set -e

kubectl exec -ti $(get-pod-by-label.sh kafka) -- \
  /opt/kafka/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 \
  --replication-factor 1 --partitions 100 --topic videos

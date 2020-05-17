#! /bin/bash
set -e

for i in `seq 1 10`; do
  echo "s3://input/input.mp4" | kubectl exec -ti  $(get-pod-by-label.sh kafka) -- \
    /opt/kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic videos
done



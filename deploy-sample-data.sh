#! /bin/bash
set -e

kubectl cp input.mp4 $(get-pod-by-label.sh uploader):/tmp/input.mp4

kubectl exec -ti $(get-pod-by-label.sh uploader) -- \
    s3cmd --config /s3cmd_config mb s3://input
    
kubectl exec -ti $(get-pod-by-label.sh uploader) -- \
    s3cmd --config /s3cmd_config mb s3://output
    
kubectl exec -ti $(get-pod-by-label.sh uploader) -- \
    s3cmd --config /s3cmd_config put /tmp/input.mp4 s3://input/input.mp4

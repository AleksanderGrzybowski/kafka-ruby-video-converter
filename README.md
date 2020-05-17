# Kafka + Minio (S3) video converter

This project is a simple video processing system with:
* Kafka for messaging
* MinIO (S3) for storage
* Ruby for broker connection and glue code
* FFMpeg for video conversion
* s3cmd for S3 operations

To try it out:

* `minikube start` - start Minikube machine
* `./deploy-infra.sh` - deploy Kafka, Zookeeper, MinIO
* `./deploy-topic.sh` - create Kafka topic for input messages
* `./deploy-app.sh` - deploy converter app
* `./deploy-sample-data.sh` - create S3 buckets and sample input file
* `./deploy-trigger.sh` - trigger some conversions
* `minikube service minio` - open graphical S3 browser (`minioaccesskey/miniosecretkey`) and watch the results in `output` bucket


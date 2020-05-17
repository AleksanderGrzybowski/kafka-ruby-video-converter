FROM ubuntu:18.04
RUN apt-get update && apt-get -y install s3cmd ffmpeg ruby
RUN gem install ruby-kafka

COPY converter/* /

CMD ["/docker-entrypoint.sh"]

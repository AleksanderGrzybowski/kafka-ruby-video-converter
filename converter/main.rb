require 'ruby-kafka'

# https://stackoverflow.com/questions/40590531/logging-to-stdout-in-a-ruby-program-not-working-in-docker
$stdout.sync = true

KAFKA_ADDRESS="kafka:9092"
KAFKA_GROUP_ID="app-group-id"
KAFKA_TOPIC="videos"
OUTPUT_BUCKET="s3://output"

puts "Connecting to Kafka at #{KAFKA_ADDRESS}..."
kafka = Kafka.new([KAFKA_ADDRESS])

puts "Subscribing to #{KAFKA_TOPIC}, group_id: #{KAFKA_GROUP_ID}..."
consumer = kafka.consumer(group_id: KAFKA_GROUP_ID)
consumer.subscribe(KAFKA_TOPIC)

trap("TERM") { consumer.stop }

puts "Listener started."

consumer.each_message(automatically_mark_as_processed: true) do |message|
  
  puts "Got message: #{message.value} at partition #{message.partition} offset #{message.offset}, processing..."
  input_s3 = message.value
  output_s3 = "#{OUTPUT_BUCKET}/output-#{rand(10000)}.mp4"
  
  `./convert.sh #{input_s3} #{output_s3}`
  
  consumer.mark_message_as_processed(message)
  consumer.commit_offsets
  puts "Message processed."
end

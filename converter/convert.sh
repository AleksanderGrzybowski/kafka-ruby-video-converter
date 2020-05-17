#! /bin/bash
set -e

echo "Starting main script..."

S3_INPUT_FILE="$1"
S3_OUTPUT_FILE="$2"
S3CMD_CONFIG="/s3cmd_config"
TEMP_FILE="/tmp/temp.mp4"
OUTPUT_FILE="/tmp/output.mp4"


echo "Removing old files..."
rm -rf ${TEMP_FILE} ${OUTPUT_FILE}

echo "Fetching source file ${S3_INPUT_FILE}..."
s3cmd --config ${S3CMD_CONFIG} get ${S3_INPUT_FILE} ${TEMP_FILE}

echo "Converting..."
ffmpeg -i ${TEMP_FILE} -vf hue=s=0 ${OUTPUT_FILE} > /dev/null 2> /dev/null
if [ $? -ne 0 ]; then
    echo "Error processing file!"
    exit 1
else
    echo "Conversion successful."
fi

echo "Pushing result to S3..."
s3cmd --config ${S3CMD_CONFIG} put ${OUTPUT_FILE} ${S3_OUTPUT_FILE}
echo "Result pushed."
  

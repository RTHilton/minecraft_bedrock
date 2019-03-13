#!/bin/bash

cd /data

# Check if we have never initialized this container
if [ ! -f /data/bedrock_server ]; then
	echo "Extracting server..."
	unzip /opt/bedrock_server.zip -d /data
else
  md5local=$(md5sum bedrock_server | cut -d' ' -f 1)
  md5zip=$(unzip -p /opt/bedrock_server.zip  bedrock_server | md5sum | cut -d' ' -f 1)

  # Check if the zip file in the image is different than our local volume
  if [ $md5local != $md5zip ]; then
    # Server was updated
    # Backup configurations
    echo "Backing up configurations"
    mv server.properties server.properties.bak
    mv whitelist.json whitelist.json.bak
    mv permissions.json permissions.json.bak

    echo "Extracting server..."
    unzip /opt/bedrock_server.zip -o -d /data

    echo "Restoring configurations"
    mv server.properties.bak server.properties
    mv whitelist.json.bak whitelist.json
    mv permissions.json.bak permissions.json
  fi
fi

echo "Starting Server..."
LD_LIBRARY_PATH=. ./bedrock_server

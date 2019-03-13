#!/bin/bash

# Container would never update with this
#if [ ! -f /data/bedrock_server ]; then
#	echo "Extracting server..."
#	unzip /opt/bedrock_server.zip -d /data
#fi

# We will always extract from the zip, it isn't that large
cd /data

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

echo "Starting Server..."
LD_LIBRARY_PATH=. ./bedrock_server

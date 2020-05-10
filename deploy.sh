#!/usr/bin/env bash

API_BASE_URI="https://app.vagrantup.com/api/v1"
VAGRANT_CLOUD_TOKEN=""
USERNAME="sivalabs"
BOX_NAME="ubuntu_bionic64_java"
BOX_VERSION="0.0.2"
PROVIDER="virtualbox"

# Create a new box
curl \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer $VAGRANT_CLOUD_TOKEN" \
  $API_BASE_URI/boxes \
  --data "{ \"box\": { \"username\": \"$USERNAME\", \"name\": \"$BOX_NAME\" } }"

# Create a new version
curl \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer $VAGRANT_CLOUD_TOKEN" \
  $API_BASE_URI/box/$USERNAME/$BOX_NAME/versions \
  --data "{ \"version\": { \"version\": \"$BOX_VERSION\" } }"

# Create a new provider
curl \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer $VAGRANT_CLOUD_TOKEN" \
  $API_BASE_URI/box/$USERNAME/$BOX_NAME/version/$BOX_VERSION/providers \
  --data "{ \"provider\": { \"name\": \"$PROVIDER\" } }"

# Prepare the provider for upload/get an upload URL
response=$(curl \
  --header "Authorization: Bearer $VAGRANT_CLOUD_TOKEN" \
  $API_BASE_URI/box/$USERNAME/$BOX_NAME/version/$BOX_VERSION/provider/virtualbox/upload)

# Extract the upload URL from the response (requires the jq command)
upload_path=$(echo "$response" | jq .upload_path)

# Perform the upload
curl $upload_path --request PUT --upload-file package.box

# Release the version
curl \
  --header "Authorization: Bearer $VAGRANT_CLOUD_TOKEN" \
  $API_BASE_URI/box/$USERNAME/$BOX_NAME/version/$BOX_VERSION/release \
  --request PUT

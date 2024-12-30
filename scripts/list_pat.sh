#!/bin/bash

raw_response_list_pat=$(curl --location --request GET "${DATABRICKS_URL}/api/2.0/token/list" \
    --header "Authorization: Bearer ${ACCESS_TOKEN}")

formatted_response=$(echo "$raw_response_list_pat" | jq '.')

echo "Response: $formatted_response"
echo "BUILD INFO: $BUILD_ID"
#!/bin/bash

# Set expiry in days and calculate seconds
expiry_in_seconds=$((EXPIRY * 24 * 60 * 60))

response_generate_pat=$(curl --location --request POST "${DATABRICKS_URL}/api/2.0/token/create" \
    --header "Authorization: Bearer ${ACCESS_TOKEN}" \
    --header "Content-Type: application/json" \
    --data-raw "{ \"lifetime_seconds\": \"${expiry_in_seconds}\", \"comment\": \"${DESCRIPTION}\" }")

echo "Response: $response_generate_pat"

# Extract token_value and token_id using jq
token_value=$(echo $response_generate_pat | jq -r '.token_value')
token_id=$(echo $response_generate_pat | jq -r '.token_info.token_id')
expiry_date_epoc=$(echo $response_generate_pat | jq -r '.token_info.expiry_time') # EPOC time

#Convert EPOC to ISO time
expiry_date_iso=$(date -u -d @$(($expiry_date_epoc / 1000)) +"%Y-%m-%dT%H:%M:%SZ")


# Print the values to verify
echo "*******************************"
echo "*        PAT Generated         *"
echo "*******************************"
echo ""
echo "Token Value:   $token_value" # remove this later for security reasons
echo "Token ID:      $token_id"
echo "Expiry Date:   $expiry_date_iso"
echo ""
echo "*******************************"

# Save the token_value and token_id as pipeline variables
echo "##vso[task.setvariable variable=token_value]$token_value"
echo "##vso[task.setvariable variable=expiry_date_iso]$expiry_date_iso"
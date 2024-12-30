#!/bin/bash

response_get_token=$(curl --location "https://login.microsoftonline.com/${AZ_TENANT_ID}/oauth2/v2.0/token" \
        --header 'Content-Type: application/x-www-form-urlencoded' \
        --data-urlencode 'grant_type=client_credentials' \
        --data-urlencode "client_id=${SP_APP_ID}" \
        --data-urlencode 'scope=2ff814a6-3304-4ab8-85cb-cd0e6f879c1d/.default' \
        --data-urlencode "client_secret=${CLIENT_SECRET}")

# Extract access_token using jq
access_token=$(echo $response_get_token | jq -r '.access_token')

# Save the access_token as a pipeline variable
echo "##vso[task.setvariable variable=access_token]$access_token"

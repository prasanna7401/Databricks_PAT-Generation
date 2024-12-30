#!/bin/bash

# Accept arguments
KVName=$1
SecretName=$2
token_value=$3
expiry_date_iso=$4

# Update the Key Vault secret
az keyvault secret set --vault-name "$KVName" \
                        --name "$SecretName" \
                        --value "$token_value" \
                        --description "$description" \
                        --expires "$expiry_date_iso"
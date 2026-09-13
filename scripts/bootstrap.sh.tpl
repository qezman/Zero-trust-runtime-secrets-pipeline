#!/bin/bash
set -euo pipefail
# set -e:  exit immediately if any command fails
# set -u:  treat unset variables as an error, catching typos in var names.
# set -o pipefail: a failure anywhere in a pipe

REGION="${region}"
SECRET_ARN="${secret_arn}"
LOG_FILE="/var/log/ztsp-bootstrap.log"

log() {
  echo "$(date -u +"%Y-%m-%dT%H:%M:%SZ") [ztsp-bootstrap] $1" | tee -a "$LOG_FILE"
}

log "Starting bootstrap"

# Network path: request goes to Secrets Manager over the VPC
# interface endpoint (PrivateLink)
SECRET_JSON=$(aws secretsmanager get-secret-value \
  --region "$REGION" \
  --secret-id "$SECRET_ARN" \
  --query 'SecretString' \
  --output text)

# Fail loudly and immediately if the fetch came back empty
if [ -z "$SECRET_JSON" ]; then
  log "ERROR: failed to retrieve secret value from Secrets Manager"
  exit 1
fi

# Parse the secret JSON to pull out username/password individually.
DB_USERNAME=$(printf '%s' "$SECRET_JSON" | python3 -c 'import sys,json; print(json.load(sys.stdin)["username"])')
DB_PASSWORD=$(printf '%s' "$SECRET_JSON" | python3 -c 'import sys,json; print(json.load(sys.stdin)["password"])')

# `export` puts these values into this script's own process environment
export DB_USERNAME
export DB_PASSWORD

# Clear the raw JSON blob from memory
unset SECRET_JSON

# log the username, but not the password
log "Credential fetched and exported to process environment (username: $DB_USERNAME, password redacted)"
log "Bootstrap complete"
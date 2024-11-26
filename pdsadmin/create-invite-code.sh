#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

echo -n "Password: "
read -s PDS_ADMIN_PASSWORD
echo

curl \
  --fail \
  --silent \
  --show-error \
  --request POST \
  --user "admin:$PDS_ADMIN_PASSWORD" \
  --header "Content-Type: application/json" \
  --data '{"useCount": 1}' \
  "https://${PDS_HOSTNAME}/xrpc/com.atproto.server.createInviteCode" | jq --raw-output '.code'

#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

echo -n "Password: "
read -s password
echo

curl \
  --fail \
  --silent \
  --show-error \
  --request POST \
  --user "admin:$password" \
  --header "Content-Type: application/json" \
  --data '{"useCount": 1}' \
  "https://${PDS_HOSTNAME}/xrpc/com.atproto.server.createInviteCode" | jq --raw-output '.code'

#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

Help() {
  cat <<HELP
pdsadmin help
--
pdsadmin <command> <pds_hostname> ...
account <pds_hostname>
  list
    List accounts
    e.g. pdsadmin account list
  create <EMAIL> <HANDLE>
    Create a new account
    e.g. pdsadmin account create alice@example.com alice.example.com
  delete <DID>
    Delete an account specified by DID.
    e.g. pdsadmin account delete did:plc:xyz123abc456
  takedown <DID>
    Takedown an account specified by DID.
    e.g. pdsadmin account takedown did:plc:xyz123abc456
  untakedown <DID>
    Remove a takedown from an account specified by DID.
    e.g. pdsadmin account untakedown did:plc:xyz123abc456
  reset-password <DID>
    Reset a password for an account specified by DID.
    e.g. pdsadmin account reset-password did:plc:xyz123abc456

request-crawl <pds_hostname> [<RELAY HOST>]
    Request a crawl from a relay host.
    e.g. pdsadmin request-crawl bsky.network

create-invite-code <pds_hostname>
  Create a new invite code.
    e.g. pdsadmin create-invite-code

help
    Display this help information.

HELP
  exit 0;
}

# Command to run.
COMMAND="${1:-help}"
shift || true

if [[ "$COMMAND" == "help" ]]; then
  Help
fi

PDS_HOSTNAME="${1:-}"
shift || true

if [[ "$PDS_HOSTNAME" == "" ]]; then
  Help
fi

SCRIPT_FILE="./pdsadmin/$COMMAND.sh"

PDS_HOSTNAME=$PDS_HOSTNAME bash -c "${SCRIPT_FILE} $@";

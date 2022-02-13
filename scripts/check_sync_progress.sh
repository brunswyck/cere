#!/usr/bin/env bash
# keep tabs on your validator's sync progress

# use with testnet|devnet|qanet|mainnet parameter
# eg:
# scripts/check_sync_progress.sh devnet

LOCAL_RPC="localhost:9933"
REGEX_CHAIN="((main|test|qa|dev)net)"
SED_TO_LOWER="s/./\L&/g"  # convert to lowercase
CURL_HEADER='Content-Type: application/json'
# shellcheck disable=SC2089
JSON_RPC_CHAIN='{ "jsonrpc":"2.0", "method":"system_chain", "id":1 }'
# shellcheck disable=SC2089
JSON_RPC_BLOCKNUMBER='{ "jsonrpc":"2.0", "method":"chain_getBlock", "id":1 }'

function print_error {
  # Print the first argument in red
  printf "\e[31m✘ %s" "${1}"

  # Reset colour back to normal
  reset_color=$(tput sgr0)
  echo "${reset_color}"
}

function set_rpc_fqdn {
  if [[ $1 == "devnet" ]]; then
    export RPC_FQDN="http://rpc.devnet.cere.network:9933"
  elif [[ $1 == "qanet" ]]; then
    export RPC_FQDN="http://rpc.qanet.cere.network:9933"
  elif [[ $1 == "testnet" ]]; then
    export RPC_FQDN="https://rpc.testnet.cere.network:9934"
  elif [[ $1 == "mainnet" ]]; then
    export RPC_FQDN="https://rpc.testnet.cere.network:9934"
  else
    print_error "Incorrect parameter, should be \"devnet\" or \"qanet\" or \"testnet\" or \"mainnet\""
    exit 1
  fi
}

function show_sync_progress {
  while true; do
    # get last block number for our validator (localhost)
    VALIDATOR_LAST_BLOCK=$(curl -sH "${CURL_HEADER}" --data "${JSON_RPC_BLOCKNUMBER}" ${LOCAL_RPC} | jq -r '.result |.block.header.number')

    # get last block number of network we're syncing with
    REMOTE_LAST_BLOCK=$(curl -sH "${CURL_HEADER}" --data "${JSON_RPC_BLOCKNUMBER}" ${RPC_FQDN} | jq -r '.result |.block.header.number')
    # while this condition keep looping else break out of this while loop
    [[ "${VALIDATOR_LAST_BLOCK}" != "${REMOTE_LAST_BLOCK}" ]] || break
    echo "synchronizing.. your node is at block: $(( "${VALIDATOR_LAST_BLOCK}" )) - ${NETWORK} chain is at block: $(( REMOTE_LAST_BLOCK ))"
    echo "disk space left: $(df -H $HOME | awk 'FNR == 2 {print $4}')"
    if [[ $BLOCK_ON_LAST_RUN == $VALIDATOR_LAST_BLOCK ]]; then
      echo "hmmm still same block, ran out of disk space?"
    else
      BLOCK_ON_LAST_RUN=$VALIDATOR_LAST_BLOCK
    fi
    sleep 20s
  done
  echo "congratulations, synchronization complete!"
}

# set remote rpc based on parameter given
set_rpc_fqdn "$1"

# get name of chain your validator (localhost)
curl -sH 'Content-Type: application/json' --data '{ "jsonrpc":"2.0", "method":"system_chain", "id":1 }' localhost:9933 | jq -r '.result' |  sed "s/./\L&/g"
LOCAL_CHAIN=$(curl -sH "${CURL_HEADER}" --data "${JSON_RPC_CHAIN}" "${LOCAL_RPC}" | jq -r '.result' | grep -ioP "${REGEX_CHAIN}" | sed "${SED_TO_LOWER}")
# get name of chain remote $NETWORK is running on

REMOTE_CHAIN=$(curl -sH "${CURL_HEADER}" --data "${JSON_RPC_CHAIN}" "${RPC_FQDN}" | jq -r '.result' | grep -ioP "${REGEX_CHAIN}" | sed "${SED_TO_LOWER}")

echo "local chain: ${LOCAL_CHAIN} <---> remote chain: ${REMOTE_CHAIN}"

# now compare both to be sure we'll compare block numbers of the same chains
if [[ "$LOCAL_CHAIN" != "$REMOTE_CHAIN" ]]; then
  echo "localhost: ${LOCAL_CHAIN} & remote: ${REMOTE_CHAIN} are different chains!"
  exit 1
fi

show_sync_progress

#!/bin/bash

export NETWORK="holesky"
VALIDATOR_PORT=3500
export WEB3SIGNER_API="http://web3signer.web3signer-${NETWORK}.dappnode:9000"
export WALLET_DIR="/root/.eth2validators"

# Copy auth-token in runtime to the prysm token dir
mkdir -p ${WALLET_DIR}
cp /auth-token ${WALLET_DIR}/auth-token

oLang=$LANG oLcAll=$LC_ALL
LANG=C LC_ALL=C
graffitiString=${GRAFFITI:0:32}
LANG=$oLang LC_ALL=$oLcAll

exec -c validator --holesky \
  --datadir="$WALLET_DIR" \
  --wallet-dir="$WALLET_DIR" \
  --monitoring-host 0.0.0.0 \
  --beacon-rpc-provider="$BEACON_RPC_PROVIDER" \
  --beacon-rpc-gateway-provider="$BEACON_RPC_GATEWAY_PROVIDER" \
  --validators-external-signer-url="$WEB3SIGNER_API" \
  --grpc-gateway-host=0.0.0.0 \
  --grpc-gateway-port="$VALIDATOR_PORT" \
  --grpc-gateway-corsdomain=http://0.0.0.0:"$VALIDATOR_PORT" \
  --graffiti="${graffitiString}" \
  --suggested-fee-recipient="${FEE_RECIPIENT_ADDRESS}" \
  --web \
  --accept-terms-of-use \
  --enable-doppelganger \
  ${EXTRA_OPTS}

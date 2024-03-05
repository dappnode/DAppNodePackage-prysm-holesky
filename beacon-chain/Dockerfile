ARG UPSTREAM_VERSION
FROM debian:bullseye-slim AS builder

# Use ldd to copy dependencies of grep
RUN mkdir /deps
RUN ldd /bin/grep | tr -s '[:space:]' '\n' | grep '^/' | xargs -I {} cp -v {} /deps || true

# Only mainnet genesis file is included by default
# Downloaded from: https://github.com/eth-clients/holesky/raw/main/custom_config_data/genesis.ssz
# genesis.ssz.zst size > 100MB, so it is split into 2 parts
COPY genesis.ssz.zst.part_00 genesis.ssz.zst.part_01 /tmp/

# Install zstd
RUN apt-get update && apt-get install -y zstd

RUN cat /tmp/genesis.ssz.zst.part_* > /genesis.ssz.zst && \
    zstd -d /genesis.ssz.zst -o /genesis.ssz

ARG UPSTREAM_VERSION
FROM gcr.io/prysmaticlabs/prysm/beacon-chain:${UPSTREAM_VERSION}

COPY jwtsecret.hex /jwtsecret
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

COPY --from=builder /genesis.ssz /genesis.ssz

COPY --from=builder /bin/sh /bin/sh
COPY --from=builder /bin/grep /bin/grep
COPY --from=builder /deps/* /lib/

ENV GENESIS_FILE_PATH=/genesis.ssz \
    JWT_PATH=/jwtsecret \
    VALIDATOR_PORT=3500

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
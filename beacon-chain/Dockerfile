FROM debian:12.2-slim as build

ARG TARGETARCH
ARG UPSTREAM_VERSION
ENV DOWNLOAD_URL https://github.com/prysmaticlabs/prysm/releases/download

RUN DEBIAN_FRONTEND=noninteractive \
    apt update && apt install -y wget ca-certificates && \
    echo ${DOWNLOAD_URL}/${UPSTREAM_VERSION}/beacon-chain-${UPSTREAM_VERSION}-linux-${TARGETARCH:-amd64} && \
    wget -q ${DOWNLOAD_URL}/${UPSTREAM_VERSION}/beacon-chain-${UPSTREAM_VERSION}-linux-${TARGETARCH:-amd64} -O /usr/local/bin/beacon-chain && \
    wget -q https://github.com/eth-clients/holesky/blob/main/custom_config_data/genesis.ssz -O /tmp/genesis.ssz && \
    chmod +x  /usr/local/bin/beacon-chain

FROM debian:12.2-slim as prod

#Copy binaries from build stage
COPY --from=build /usr/local/bin/beacon-chain /usr/local/bin/beacon-chain
COPY --from=build /tmp/genesis.ssz /genesis.ssz

COPY jwtsecret.hex /jwtsecret
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN apt update && \
    apt install -y ca-certificates && \
    chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
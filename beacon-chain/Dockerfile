FROM alpine:3.18.4 as build

ARG TARGETARCH
ARG UPSTREAM_VERSION
ENV DOWNLOAD_URL https://github.com/prysmaticlabs/prysm/releases/download

RUN DEBIAN_FRONTEND=noninteractive \
    apk update && apk add --no-cache curl wget ca-certificates && \
    echo ${DOWNLOAD_URL}/${UPSTREAM_VERSION}/beacon-chain-${UPSTREAM_VERSION}-linux-${TARGETARCH:-amd64} && \
    wget -q ${DOWNLOAD_URL}/${UPSTREAM_VERSION}/beacon-chain-${UPSTREAM_VERSION}-linux-${TARGETARCH:-amd64} -O /usr/local/bin/beacon-chain && \
    wget -q https://github.com/eth-clients/holesky/blob/main/custom_config_data/genesis.ssz -O /tmp/genesis.ssz && \
    chmod +x  /usr/local/bin/beacon-chain

FROM alpine:3.18.4 as prod

#Copy binaries from build stage
COPY --from=build /usr/local/bin/beacon-chain /usr/local/bin/beacon-chain
COPY --from=build /tmp/genesis.ssz /genesis.ssz

COPY jwtsecret.hex /jwtsecret
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN apk update && \
    apk add --no-cache ca-certificates bash file && \
    chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
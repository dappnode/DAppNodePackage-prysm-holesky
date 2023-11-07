ARG UPSTREAM_VERSION
FROM prysmaticlabs/prysm-beacon-chain:${UPSTREAM_VERSION}

COPY jwtsecret.hex /jwtsecret
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]


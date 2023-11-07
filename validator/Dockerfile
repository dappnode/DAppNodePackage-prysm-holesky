ARG UPSTREAM_VERSION
FROM prysmaticlabs/prysm-validator:${UPSTREAM_VERSION}

COPY auth-token /auth-token
COPY entrypoint.sh /usr/local/bin

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

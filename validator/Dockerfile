FROM debian:12.2-slim as build

ARG TARGETARCH
ARG UPSTREAM_VERSION
ENV DOWNLOAD_URL https://github.com/prysmaticlabs/prysm/releases/download

RUN DEBIAN_FRONTEND=noninteractive \
    apt update && apt install -y wget ca-certificates && \
    wget -q ${DOWNLOAD_URL}/${UPSTREAM_VERSION}/validator-${UPSTREAM_VERSION}-linux-${TARGETARCH:-amd64} -O /usr/local/bin/validator && \
    chmod +x  /usr/local/bin/validator

FROM debian:12.2-slim as prod

#Copy binaries from build stage
COPY --from=build /usr/local/bin/validator /usr/local/bin
COPY auth-token /auth-token
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN apt update && \
    apt install -y ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
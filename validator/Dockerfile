FROM alpine:3.18.4 as build

ARG TARGETARCH
ARG UPSTREAM_VERSION
ENV DOWNLOAD_URL https://github.com/prysmaticlabs/prysm/releases/download

RUN DEBIAN_FRONTEND=noninteractive \
    apk update && apk add --no-cache wget ca-certificates && \
    wget -q ${DOWNLOAD_URL}/${UPSTREAM_VERSION}/validator-${UPSTREAM_VERSION}-linux-${TARGETARCH:-amd64} -O /usr/local/bin/validator && \
    chmod +x  /usr/local/bin/validator

FROM alpine:3.18.4 as prod

#Copy binaries from build stage
COPY --from=build /usr/local/bin/validator /usr/local/bin
COPY auth-token /auth-token
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN apk update && \
    apk add --no-cache ca-certificates bash file && \
    rm -rf /var/lib/apt/lists/* && \
    chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
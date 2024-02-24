ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_ARM64

FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_ARM64}
EXPOSE 3000 5000
ARG IMAGE_STATS
ENV IMAGE_STATS=${IMAGE_STATS} FLOOD_AUTH="false" WEBUI_PORTS="3000/tcp,3000/udp,5000/tcp,5000/udp"

RUN apk add --no-cache xmlrpc-c-tools nginx openssl mediainfo && \
    ln -s "${CONFIG_DIR}/rpc2/basic_auth_credentials" "${APP_DIR}/basic_auth_credentials"

ARG RTORRENT_VERSION
RUN curl -fsSL "https://github.com/jesec/rtorrent/releases/download/v${RTORRENT_VERSION}/rtorrent-linux-arm64" > "${APP_DIR}/rtorrent" && \
    chmod 755 "${APP_DIR}/rtorrent"

ARG FLOOD_VERSION
RUN curl -fsSL "https://github.com/jesec/flood/releases/download/v${FLOOD_VERSION}/flood-linux-arm64" > "${APP_DIR}/flood" && \
    chmod 755 "${APP_DIR}/flood"

COPY root/ /

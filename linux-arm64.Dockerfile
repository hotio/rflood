FROM ghcr.io/hotio/base@sha256:b8ab6a6edfbf3bc4a85f2040672c021462d374e135bccfc6e9e56883e5a04cd9

ARG DEBIAN_FRONTEND="noninteractive"

ENV VPN_ENABLED="false" VPN_LAN_NETWORK="" VPN_CONF="wg0" VPN_ADDITIONAL_PORTS="" FLOOD_AUTH="false"

EXPOSE 3000

RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        mediainfo \
        ipcalc \
        iptables \
        iproute2 \
        openresolv \
        wireguard-tools && \
# clean up
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ARG RTORRENT_VERSION
RUN curl -fsSL "https://github.com/jesec/rtorrent/releases/download/v${RTORRENT_VERSION}/rtorrent-linux-arm64" > "${APP_DIR}/rtorrent" && \
    chmod 755 "${APP_DIR}/rtorrent"

ARG VERSION
RUN curl -fsSL "https://github.com/jesec/flood/releases/download/v${VERSION}/flood-linux-arm64" > "${APP_DIR}/flood" && \
    chmod 755 "${APP_DIR}/flood"

COPY root/ /

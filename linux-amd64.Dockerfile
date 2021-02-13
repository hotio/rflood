FROM ghcr.io/hotio/base@sha256:d1028a84da6b618f947ff7506b28763ce8e9238d7f47da8e59de8553f763004a

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
RUN curl -fsSL "https://github.com/jesec/rtorrent/releases/download/v${RTORRENT_VERSION}/rtorrent-linux-amd64" > "${APP_DIR}/rtorrent" && \
    chmod 755 "${APP_DIR}/rtorrent"

ARG VERSION
RUN curl -fsSL "https://github.com/jesec/flood/releases/download/v${VERSION}/flood-linux-x64" > "${APP_DIR}/flood" && \
    chmod 755 "${APP_DIR}/flood"

COPY root/ /

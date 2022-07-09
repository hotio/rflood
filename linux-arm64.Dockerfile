FROM cr.hotio.dev/hotio/base@sha256:d4367f0bb0eebf886d2f0ae3edb724de753b6e3f59fa543207c1c71dd465686d

ENV VPN_ENABLED="false" VPN_LAN_NETWORK="" VPN_CONF="wg0" VPN_ADDITIONAL_PORTS="" FLOOD_AUTH="false" WEBUI_PORTS="3000/tcp,3000/udp" PRIVOXY_ENABLED="false" S6_SERVICES_GRACETIME=180000 VPN_IP_CHECK_DELAY=5

EXPOSE 3000

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main privoxy iptables iproute2 openresolv wireguard-tools && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community ipcalc mediainfo && \
    apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing wireguard-go

ARG RTORRENT_VERSION
RUN curl -fsSL "https://github.com/jesec/rtorrent/releases/download/v${RTORRENT_VERSION}/rtorrent-linux-arm64" > "${APP_DIR}/rtorrent" && \
    chmod 755 "${APP_DIR}/rtorrent"

ARG FLOOD_VERSION
RUN curl -fsSL "https://github.com/jesec/flood/releases/download/v${FLOOD_VERSION}/flood-linux-arm64" > "${APP_DIR}/flood" && \
    chmod 755 "${APP_DIR}/flood"

COPY root/ /

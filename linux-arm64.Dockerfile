ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_ARM64

FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_ARM64}
EXPOSE 3000
ENV VPN_ENABLED="false" VPN_LAN_NETWORK="" VPN_CONF="wg0" VPN_ADDITIONAL_PORTS="" FLOOD_AUTH="false" WEBUI_PORTS="3000/tcp,3000/udp" PRIVOXY_ENABLED="false" S6_SERVICES_GRACETIME=180000 VPN_IP_CHECK_DELAY=5 VPN_IP_CHECK_EXIT="true"

VOLUME ["${CONFIG_DIR}"]

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main privoxy iptables iproute2 openresolv wireguard-tools bind-tools && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community ipcalc mediainfo && \
    apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing wireguard-go

ARG RTORRENT_VERSION
RUN curl -fsSL "https://github.com/jesec/rtorrent/releases/download/v${RTORRENT_VERSION}/rtorrent-linux-arm64" > "${APP_DIR}/rtorrent" && \
    chmod 755 "${APP_DIR}/rtorrent"

ARG FLOOD_VERSION
RUN curl -fsSL "https://github.com/jesec/flood/releases/download/v${FLOOD_VERSION}/flood-linux-arm64" > "${APP_DIR}/flood" && \
    chmod 755 "${APP_DIR}/flood"

COPY root/ /
RUN chmod -R +x /etc/cont-init.d/ /etc/services.d/ /etc/cont-finish.d/

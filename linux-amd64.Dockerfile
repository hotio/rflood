ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_AMD64

FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_AMD64}
EXPOSE 3000
ENV FLOOD_AUTH="false" WEBUI_PORTS="3000/tcp,3000/udp"

ARG RTORRENT_VERSION
RUN curl -fsSL "https://github.com/jesec/rtorrent/releases/download/v${RTORRENT_VERSION}/rtorrent-linux-amd64" > "${APP_DIR}/rtorrent" && \
    chmod 755 "${APP_DIR}/rtorrent"

ARG FLOOD_VERSION
RUN curl -fsSL "https://github.com/jesec/flood/releases/download/v${FLOOD_VERSION}/flood-linux-x64" > "${APP_DIR}/flood" && \
    chmod 755 "${APP_DIR}/flood"

COPY root/ /

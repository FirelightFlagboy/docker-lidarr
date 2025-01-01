# syntax=docker/dockerfile:1.4

FROM --platform=$BUILDPLATFORM alpine:3.21 as builder

COPY --link pkg-info.json /pkg-info.json

ARG PKG_VERSION
ARG TARGETARCH

COPY --link in-docker-build.sh /build.sh

RUN sh /build.sh

FROM alpine:3.21

ARG PKG_VERSION

LABEL org.opencontainers.image.source="https://github.com/Lidarr/Lidarr"
LABEL org.opencontainers.image.description="Lidarr is a music collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new tracks from your favorite artists and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available."
LABEL org.opencontainers.image.version=${PKG_VERSION}
LABEL org.opencontainers.image.title="Lidarr"

COPY --from=builder /opt/lidarr /opt/lidarr
RUN apk --no-cache add icu-libs sqlite-libs

USER 1234:1234

ENTRYPOINT [ "/opt/lidarr/Lidarr", "-nobrowser", "-data=/config" ]

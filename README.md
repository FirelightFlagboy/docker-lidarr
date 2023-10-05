# Docker Lidarr

Provide a simple docker image for [`lidarr`].

[`lidarr`]: https://github.com/Lidarr/Lidarr

The goal is to provide a simpler docker image that don't package a bootstrap script like [`linuxserver/lidarr`] to be used on `docker-compose` & `k8s`.

[`linuxserver/lidarr`]: https://github.com/linuxserver/docker-lidarr

The image is provided at <https://hub.docker.com/r/firelightflagbot/lidarr>

## Quick start

Here is a simple `docker-compose` file:

```yaml
services:
  lidarr:
    image: firelightflagbot/lidarr:1.3.5.3530
    user: 1234:1234 # This is the default uid/gid, you can change it.
    ports:
      - 8686:8686
    volumes:
      - type: bind
        source: /somewhere/lidarr-config # The folder need to be owned by the set'd user in `services.lidarr.user` (lidarr need to be able to write to it).
        target: /config
```

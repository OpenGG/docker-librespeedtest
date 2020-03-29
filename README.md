# docker-speedtest

[![](https://images.microbadger.com/badges/version/opengg/speedtest.svg)](https://microbadger.com/images/opengg/speedtest "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/opengg/speedtest.svg)](https://microbadger.com/images/opengg/speedtest "Get your own image badge on microbadger.com")

[![Docker Pulls](https://img.shields.io/docker/pulls/opengg/speedtest.svg)](https://hub.docker.com/r/opengg/speedtest/ "Docker Pulls")
[![Docker Stars](https://img.shields.io/docker/stars/opengg/speedtest.svg)](https://hub.docker.com/r/opengg/speedtest/ "Docker Stars")
[![Docker Automated](https://img.shields.io/docker/automated/opengg/speedtest.svg)](https://hub.docker.com/r/opengg/speedtest/ "Docker Automated")

Minimal docker image for speedtest (go implementation).

## Usage

0. Prepare config and db files with following commands.

    ```bash
    # Create config dir
    mkdir /storage/speedtest/

    touch /storage/speedtest/settings.toml
    touch /storage/speedtest/speedtest.db

    # Get uid and gid, see below
    id

    # Set proper permissions. Change 1001:1002 to your own uid:gid .
    chown -R 1001:1002 /storage/speedtest/
    chown -R 1001:1002 /storage/speedtest/*
    chmod 755 /storage/speedtest/
    chmod 644 /storage/speedtest/*
    ```

0. Run following command to start speedtest instance

    ```bash
    # Change 1001:1002 to your own uid:gid .
    docker run \
      -d \
      --name speedtest \
      -u=1001:1002 \
      -v /storage/speedtest/settings.toml:/settings.toml \
      -v /storage/speedtest/speedtest.db:/speedtest.db \
      -p 8989:8989 \
      opengg/speedtest
    ```

Note:
* Make sure the speedtest folder is writable by the given uid/gid.
* `settings.toml` will be filled with default contents, and can be later customized.
* Learn more about tuning `settings.toml`: [speedtest](https://github.com/librespeed/speedtest/tree/go)

## Parameters

The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side.
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
`http://192.168.x.x:8080` would show you what's running INSIDE the container on port 80.


* `-p 8989:8989` - the port(s)
* `-v /storage/speedtest/settings.toml:/settings.toml` - where speedtest should store config
* `-v /storage/speedtest/speedtest.db:/speedtest.db` - local path for telemetry
* `-u 1001` for UserID - see below for explanation
* `-u 1001:1002` for GroupID - see below for explanation

It is based on alpine linux, for shell access whilst the container is running do `docker exec -it opengg/speedtest /bin/sh`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `-u 1001:1002`. To find yours use `id user` as below:

```bash
  $ id dockeruser
    uid=1001(dockeruser) gid=1002(dockergroup) groups=1002(dockergroup)
```

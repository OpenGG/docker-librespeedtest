# docker-librespeedtest

[![](https://images.microbadger.com/badges/version/opengg/librespeedtest.svg)](https://microbadger.com/images/opengg/librespeedtest "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/opengg/librespeedtest.svg)](https://microbadger.com/images/opengg/librespeedtest "Get your own image badge on microbadger.com")

[![Docker Pulls](https://img.shields.io/docker/pulls/opengg/librespeedtest.svg)](https://hub.docker.com/r/opengg/librespeedtest/ "Docker Pulls")
[![Docker Stars](https://img.shields.io/docker/stars/opengg/librespeedtest.svg)](https://hub.docker.com/r/opengg/librespeedtest/ "Docker Stars")
[![Docker Automated](https://img.shields.io/docker/automated/opengg/librespeedtest.svg)](https://hub.docker.com/r/opengg/librespeedtest/ "Docker Automated")

## Usage

0. Prepare config and db files with following commands.

    ```bash
    # Create config dir
    mkdir /storage/librespeedtest/

    touch /storage/librespeedtest/settings.toml
    touch /storage/librespeedtest/speedtest.db

    # Get uid and gid, see below
    id

    # Set proper permissions. Change 1001:1002 to your own uid:gid .
    chown -R 1001:1002 /storage/librespeedtest/
    chown -R 1001:1002 /storage/librespeedtest/*
    chmod 755 /storage/librespeedtest/
    chmod 644 /storage/librespeedtest/*
    ```

0. Run following command to start librespeedtest instance

    ```bash
    # Change 1001:1002 to your own uid:gid .
    docker run \
      -d \
      --name librespeedtest \
      -u=1001:1002 \
      -v /storage/librespeedtest/settings.toml:/settings.toml \
      -v /storage/librespeedtest/speedtest.db:/speedtest.db \
      -p 8989:8989 \
      opengg/librespeedtest
    ```

Note:
* Make sure the librespeedtest folder is writable by the given uid/gid.
* `settings.toml` will be filled with default contents, and can be later customized.
* Learn more about tuning `settings.toml`: [librespeedtest](https://github.com/librespeed/speedtest/tree/go)

## Parameters

The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side.
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
`http://192.168.x.x:8080` would show you what's running INSIDE the container on port 80.


* `-p 8989:8989` - the port(s)
* `-v /storage/librespeedtest/settings.toml:/settings.toml` - where librespeedtest should store config
* `-v /storage/librespeedtest/speedtest.db:/speedtest.db` - local path for telemetry
* `-u 1001` for UserID - see below for explanation
* `-u 1001:1002` for GroupID - see below for explanation

It is based on alpine linux, for shell access whilst the container is running do `docker exec -it opengg/librespeedtest /bin/sh`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `-u 1001:1002`. To find yours use `id user` as below:

```bash
  $ id dockeruser
    uid=1001(dockeruser) gid=1002(dockergroup) groups=1002(dockergroup)
```

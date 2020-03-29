FROM alpine:latest

LABEL maintainer="OpenGG <liy099@gmail.com>"

RUN set -xe \
    && echo "Installing deps" \
    && apk add --no-cache go libarchive-tools curl \
    && echo "Creating deps" \
    && mkdir /work \
    && cd /work \
    && echo "Downloading source" \
    && curl -O -L 'https://github.com/librespeed/speedtest/archive/go.zip' \
    && echo "Unzipping" \
    && bsdtar --strip-components=1 -xvf go.zip \
    && rm go.zip \
    && echo "Source files:" \
    && ls -lah \
    && echo "Creating index.html" \
    && cp assets/example-singleServer-full.html assets/index.html \
    && echo "Building" \
    && go build -ldflags "-linkmode external -extldflags -static" -a main.go

# base image
FROM alpine:latest

# config and init script
COPY root/ /

# main executable
COPY --from=0 /work/main /main

# html assets
COPY --from=0 /work/assets /assets

# port
EXPOSE 8989

ENTRYPOINT ["sh", "/init.sh"]

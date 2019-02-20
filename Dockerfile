FROM alpine:3.7

WORKDIR /workdir
ENV FIRMWARE=/workdir/raspberry-firmware \
    FIRMWARE_REPO=https://www.github.com/raspberrypi/firmware

# Install build dependencies
RUN apk add --no-cache bash git

COPY *.sh version /
CMD ["/build-tarball.sh"]

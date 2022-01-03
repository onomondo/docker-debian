# About this image

***This image should only be used for local testing!***

The `onomondo/debian` is based off of `debian:11.2-slim` with tools added to help test, setup and debug network related tasks.

It will attempt to disable checksum offloading for all container interfaces upon start up. To do this, the container needs to run with the `NET_ADMIN` capability enabled, and the application has to either run as root, or the user should be able to run ethtool with `sudo` (`sudo` is included in the base image).

To let a user run ethtool add a file like this to `/etc/sudoers.d/`. Replace `<USERNAME>` with the actual username
```
<USERNAME> ALL=(ALL) NOPASSWD: /sbin/ethtool --offload
```
## How to build multi-arch images
With Mac switching to ARM CPUs, the need to support multiple CPU architectures have increased.
By default Docker will only build the contianer for the architecture it is curently running on, and if you push your local image, it will override the image for other architectures.

In order to build multi-arch images, run the following
```
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker buildx create --name multiarch --driver docker-container --use
docker buildx inspect --bootstrap
docker buildx build --push --platform linux/arm64/v8,linux/amd64 --tag onomondo/debian:11.2 .
```

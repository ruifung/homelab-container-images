FROM ubuntu:24.10 as golang-build
WORKDIR /build
RUN apt-get update && apt-get install -y git make golang

FROM golang-build as btrfs-progs-ng-builder
RUN git clone git://git.lukeshu.com/btrfs-progs-ng
WORKDIR /build/btrfs-progs-ng
RUN make

FROM golang-build as btrfscue-builder
RUN git clone --recurse-submodules https://github.com/cblichmann/btrfscue.git
WORKDIR /build/btrfscue
RUN make

FROM ubuntu:24.10
RUN apt-get update
COPY  --from=btrfs-progs-ng-builder /build/btrfs-progs-ng/bin/btrfs-rec /usr/bin/btrfs-rec
COPY  --from=btrfscue-builder /build/btrfscue/bin/btrfscue /usr/bin/btrfscue
RUN apt-get install -y gddrescue btrfs-progs dislocker coreutils testdisk foremost scalpel extundelete parted
WORKDIR /root
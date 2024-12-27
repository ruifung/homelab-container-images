FROM ubuntu:latest AS builder
WORKDIR /app
RUN apt-get update && apt-get install -y pkg-config automake autoconf autoconf-archive gcc libtool make libsgutils2-dev libudev-dev libpci-dev check
ADD https://github.com/intel/ledmon/archive/refs/tags/v1.0.0.tar.gz ledmon-1.0.0.tar.gz
RUN tar xvzf ledmon-1.0.0.tar.gz
WORKDIR /app/ledmon-1.0.0
RUN ./autogen.sh && ./configure --disable-doc && make

FROM ubuntu:latest
WORKDIR /app
RUN apt-get update && apt-get install -y libsgutils2-1.46-2 libudev1 libpci3 && rm -rf /var/lib/apt/lists/*
COPY --from=builder /app/ledmon-1.0.0/src/ledmon/ledmon /usr/sbin/ledmon
COPY --from=builder /app/ledmon-1.0.0/src/ledctl/ledctl /usr/sbin/ledctl
ENTRYPOINT ["/usr/sbin/ledmon", "--foreground"]
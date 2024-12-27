FROM ubuntu:latest
WORKDIR /root/
COPY debs/ /root/debs/
RUN /usr/bin/dpkg -i -R /root/debs/
RUN apt-get update && apt-get install -y && rm -rf /var/lib/apt/lists/*
CMD [ "/usr/bin/bash", "-c", "sleep infinity" ]
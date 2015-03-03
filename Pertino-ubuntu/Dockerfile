FROM ubuntu:14.04
MAINTAINER Pertino Inc. "developer@pertino.com"

# Install Pertino Dependencies ------
RUN apt-get update 
RUN apt-get install -y libpcap0.8-dev expect net-tools inetutils-ping wget isc-dhcp-client python --no-install-recommends 
RUN rm -rf /var/lib/apt/lists/*

# Install Pertino -----
RUN apt-key adv --keyserver pgp.mit.edu --recv-keys F7E3CA0F7A008E65A1C5C0A7DD2CF55E326BD77B
RUN echo 'deb http://reposerver.pertino.com/debs precise multiverse' > /etc/apt/sources.list.d/pertino.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y -q pertino-client || true

# Set runtime commands
COPY docker-entrypoint.sh /entrypoint.sh
COPY pertino-entrypoint.sh /pertino-entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]


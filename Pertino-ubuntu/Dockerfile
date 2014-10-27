FROM ubuntu:14.04
MAINTAINER Pertino Inc. "developer@pertino.com"

# Install Pertino Dependencies ------
RUN apt-get update && apt-get install -y libpcap0.8-dev expect net-tools inetutils-ping wget isc-dhcp-client --no-install-recommends && rm -rf /var/lib/apt/lists/*
# end Pertino Dependencies ----------

# Install the Pertino Client --------
RUN wget -O - http://reposerver.pertino.com/Pertino-GPG-Key.pub | apt-key add -
RUN echo 'deb http://reposerver.pertino.com/debs precise multiverse' > /etc/apt/sources.list.d/pertino.list
RUN apt-get update
RUN apt-get install -d pertino-client
# Note: there is also a need to have items in a start-up script.
# end Pertino Client Install --------

COPY docker-entrypoint.sh /entrypoint.sh
COPY pertino-entrypoint.sh /pertino-entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]


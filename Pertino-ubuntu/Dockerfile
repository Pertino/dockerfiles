FROM ubuntu:14.04
MAINTAINER Pertino Inc. "developer@pertino.com"

# Install Pertino Dependencies ------
RUN apt-key adv --keyserver pgp.mit.edu --recv-keys F7E3CA0F7A008E65A1C5C0A7DD2CF55E326BD77B
RUN echo 'deb http://reposerver.pertino.com/debs precise multiverse' > /etc/apt/sources.list.d/pertino.list
RUN apt-get update && apt-get install -y libpcap0.8-dev expect net-tools inetutils-ping wget isc-dhcp-client pertino-client --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*
# end Pertino Dependencies ----------

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD /opt/pertino/pgateway/pGateway


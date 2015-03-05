#!/bin/bash -e

# Configure Pertino -------------------------------------------------------
echo "Setting up Pertino Client..."

# touch these so the client doesn't complain
touch /etc/sudoers
touch /etc/resolvconf/interface-order

if [ ! -z $PERTINO_APIKEY ]; then
    /opt/pertino/pgateway/.pauth -a ${PERTINO_APIKEY}
elif [ ! -z $PERTINO_USERNAME ] && [ ! -z $PERTINO_PASSWORD ]; then
    /opt/pertino/pgateway/.pauth -u ${PERTINO_USERNAME} -p ${PERTINO_PASSWORD}
fi

echo -n 'Starting Tunnel...'; sleep 1;

# Start the pertino client
/opt/pertino/pgateway/pGateway >/dev/null 2>&1 &

while STATE=$(/opt/pertino/pgateway/pertino --status | grep -c TUNNEL_RUNNING); test "$STATE" != "1"; do
    echo -n '.'; sleep 1;
done; echo


# If a specific network as been defined, switch to the desirend network
if ! [ "${PERTINO_NETWORK}" == "" ]; then
    /opt/pertino/pgateway/pertino --select-network ${PERTINO_NETWORK}
fi

# Print out some details about the network configuration and status
/opt/pertino/pgateway/pertino --status
echo
ifconfig
# end configure Pertino ---------------------------------------------------

# Drop into a bash shell for convenience if executed with -i
cd ~
/bin/bash


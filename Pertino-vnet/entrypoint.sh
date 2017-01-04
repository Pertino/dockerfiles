#!/bin/bash -e

# Configure Pertino -------------------------------------------------------
echo "Setting up Pertino Client..."

# touch these so the client doesn't complain
touch /etc/sudoers
touch /etc/resolvconf/interface-order

PERTINO_PATH="/opt/pertino/pgateway"
PERTINO_AUTHENTICATION_CMD="${PERTINO_PATH}/.pauth"
PERTINO_CMD="${PERTINO_PATH}/pertino"
PERTINO_DAEMON="${PERTINO_PATH}/pGateway"

if [ ! -z $PERTINO_APIKEY ]; then
    $PERTINO_AUTHENTICATION_CMD -d ${PERTINO_APIKEY}
elif [ ! -z $PERTINO_USERNAME ] && [ ! -z $PERTINO_PASSWORD ]; then
    $PERTINO_AUTHENTICATION_CMD -u ${PERTINO_USERNAME} -p ${PERTINO_PASSWORD}
fi

echo -n 'Starting Tunnel...'; sleep 1;

# Start the pertino client
$PERTINO_DAEMON >/dev/null 2>&1 &

while STATE=$($PERTINO_CMD --status | grep -c ACTIVE); test "$STATE" != "2"; do
    echo -n '.'; sleep 1;
done; echo


# If a specific network as been defined, switch to the desirend network
if ! [ "${PERTINO_NETWORK}" == "" ]; then
    $PERTINO_CMD --select-network ${PERTINO_NETWORK}
fi

# Print out some details about the network configuration and status
$PERTINO_CMD --status
echo
ifconfig
# end configure Pertino ---------------------------------------------------

# Drop into a bash shell for convenience if executed with -i
cd ~
/bin/bash


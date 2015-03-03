#!/bin/bash -e

# Configure Pertino -------------------------------------------------------
echo "Setting up Pertino Client..."

# touch these so the client doesn't complain
touch /etc/sudoers
mkdir -p /etc/resolvconf
touch /etc/resolvconf/interface-order

# Known issue with AppArmor
# See https://github.com/docker/docker/issues/5490
mv /sbin/dhclient /usr/sbin/dhclient

cd /opt/pertino/pgateway
if [ ! -z $PERTINO_USERNAME ] && [ ! -z $PERTINO_PASSWORD ]; then
    ./.pauth -u ${PERTINO_USERNAME} -p ${PERTINO_PASSWORD}
fi

PERTINO_DAEMON="pGateway"
if [ -f $PERTINO_DAEMON ];
then
   echo -n 'Starting Tunnel...'; sleep 1;
   ./$PERTINO_DAEMON >/dev/null 2>&1 &
else
   echo "File $PERTINO_DAEMON does not exist."
fi

while STATE=$(/opt/pertino/pgateway/pertino --status | grep -c TUNNEL_RUNNING); test "$STATE" != "1"; do
    echo -n '.'; sleep 1;
done; echo

if ! [ "${PERTINO_NETWORK}" == "" ]; then
    /opt/pertino/pgateway/pertino --select-network ${PERTINO_NETWORK}
fi

# print out some details out the network configuration and status
/opt/pertino/pgateway/pertino --status
echo
ifconfig
# end configure Pertino ---------------------------------------------------


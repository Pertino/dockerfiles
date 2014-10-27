#!/bin/bash -e


# Configure Pertino -------------------------------------------------------
echo "Setting up Pertino Client..."

# touch these so the client doesn't complain
touch /etc/sudoers
mkdir -p /etc/resolvconf
touch /etc/resolvconf/interface-order
mv /sbin/dhclient /usr/sbin/dhclient
export DEBIAN_FRONTEND=readline
(
    cat <<EOF
#!/usr/bin/expect -f

set timeout 60
spawn apt-get install -y pertino-client
expect "Username:"
send "\$env(PERTINO_USERNAME)\r"
expect "Password:"
send "\$env(PERTINO_PASSWORD)\r"
interact

EOF
) > /tmp/setup-pertino.exp
chmod +x /tmp/setup-pertino.exp

if [[ $(dpkg -l pertino-client) ]]; then
    :
else
    /tmp/setup-pertino.exp
    echo -n 'Starting Tunnel...'; sleep 1;
    while STATE=$(/opt/pertino/pgateway/pertino --status | grep -c TUNNEL_RUNNING); test "$STATE" != "1"; do
        echo -n '.'; sleep 1;
    done; echo
fi

if ! [ "${PERTINO_NETWORK}" == "" ]; then
    /opt/pertino/pgateway/pertino --select-network ${PERTINO_NETWORK}
fi

# print out some details out the network configuration and status
/opt/pertino/pgateway/pertino --status
echo
ifconfig
# end configure Pertino ---------------------------------------------------


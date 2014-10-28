#!/bin/bash -e
cd /opt/pertino/pgateway
if [ ! -z $PERTINO_USERNAME ] && [ ! -z $PERTINO_PASSWORD ]; then
  ./.pauth -u ${PERTINO_USERNAME} -p ${PERTINO_PASSWORD}
fi
exec "$@"

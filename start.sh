#!/bin/sh
exec 2>&1
GUNICORN=/usr/bin/gunicorn
ROOT=/calico_containers
PID=/var/run/gunicorn.pid
APP=libnetwork_plugin.driver_plugin:app

if [ -f $PID ]; then rm $PID; fi

exec $GUNICORN --chdir $ROOT --pid=$PID \
-b unix:///run/docker/plugins/calico.sock $APP \
--timeout 5 \
--log-level=info \
--workers 1 \
--worker-class gevent
--access-logfile -

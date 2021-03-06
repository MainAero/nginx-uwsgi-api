#!/usr/bin/env bash

# Default values
DEFAULT_UWSGI_HOST_IP=0.0.0.0
DEFAULT_UWSGI_STATS_HOST_IP=0.0.0.0
DEFAULT_UWSGI_PROCESSES=4
DEFAULT_UWSGI_THREADS=2
DEFAULT_UWSGI_PORT=3031
DEFAULT_UWSGI_STATS_PORT=9091
DEFAULT_UWSGI_FILE=wsgi.py
DEFAULT_UWSGI_USER=uwsgiuser

# Check if env variables are set, otherwise set default values
: ${UWSGI_PROCESSES:=$DEFAULT_UWSGI_PROCESSES}
: ${UWSGI_THREADS:=$DEFAULT_UWSGI_THREADS}
: ${UWSGI_PORT:=$DEFAULT_UWSGI_PORT}
: ${UWSGI_STATS_PORT:=$DEFAULT_UWSGI_STATS_PORT}
: ${UWSGI_STATS_PORT:=$DEFAULT_UWSGI_STATS_PORT}
: ${UWSGI_HOST_IP:=$DEFAULT_UWSGI_HOST_IP}
: ${UWSGI_STATS_HOST_IP:=$DEFAULT_UWSGI_STATS_HOST_IP}
: ${UWSGI_FILE:=$DEFAULT_UWSGI_FILE}
: ${UWSGI_USER:=$DEFAULT_UWSGI_USER}

echo    "Starting uwsgi with file $UWSGI_FILE, user $UWSGI_USER on socket $UWSGI_HOST_IP:$UWSGI_PORT" \
        "with processes $UWSGI_PROCESSES," \
        "threads $UWSGI_THREADS and stats on $UWSGI_STATS_HOST_IP:$UWSGI_STATS_PORT"

uwsgi --uid $UWSGI_USER --socket $UWSGI_HOST_IP:$UWSGI_PORT --wsgi-file wsgi.py --master \
--processes $UWSGI_PROCESSES --threads $UWSGI_THREADS --stats $UWSGI_STATS_HOST_IP:$UWSGI_STATS_PORT

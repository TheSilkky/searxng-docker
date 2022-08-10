#!/usr/bin/env sh

export DEFAULT_SEARXNG_SETTINGS_PATH="/searxng/settings.yml"
export SEARXNG_SETTINGS_PATH="${SEARXNG_SETTINGS_PATH:-${DEFAULT_SEARXNG_SETTINGS_PATH}}"

export DEFAULT_BIND_ADDRESS="0.0.0.0:8080"
export BIND_ADDRESS="${BIND_ADDRESS:-${DEFAULT_BIND_ADDRESS}}"

/searxng/config.py "${SEARXNG_SETTINGS_PATH}"

exec uwsgi --master --http-socket "${BIND_ADDRESS}" /searxng/uwsgi.ini
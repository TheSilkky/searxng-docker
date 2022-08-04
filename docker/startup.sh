#!/usr/bin/env bash

patch_searxng_settings() {
  CONF="$1"

  sed -i -e "s|SECRET_KEY|$(openssl rand -hex 32)|g" "${CONF}"

  # Server Settings
  if [[ -v BASE_URL ]]; then
    sed -i -e "s|base_url: false|base_url: \"${BASE_URL}\"|g" "${CONF}"
  fi
  if [[ -v LIMITER ]] && [[ "${LIMITER}" == "true" ]]; then
    sed -i -e "s|limiter: false|limiter: true|g" "${CONF}"
  fi
  if [[ -v IMAGE_PROXY ]] && [[ "${IMAGE_PROXY}" == "true" ]]; then
    sed -i -e "s|image_proxy: false|image_proxy: true|g" "${CONF}"
  fi

  # General Settings
  if [[ -v DEBUG ]] && [[ "${DEBUG}" == "true" ]]; then
    sed -i -e "s|debug: false|debug: true|g" "${CONF}"
  fi
  if [[ -v INSTANCE_NAME ]]; then
    sed -i -e "s|instance_name: \"SearXNG\"|instance_name: \"${INSTANCE_NAME}\"|g" "${CONF}"
  fi
  if [[ -v PRIVACY_POLICY_URL ]]; then
    sed -i -e "s|privacypolicy_url: false|privacypolicy_url: \"${PRIVACY_POLICY_URL}\"|g" "${CONF}"
  fi
  if [[ -v DONATION_URL ]]; then
    sed -i -e "s|donation_url: false|donation_url: \"${DONATION_URL}\"|g" "${CONF}"
  fi

  if [[ -v CUSTOM_BRAND ]] && [[ "${CUSTOM_BRAND}" == "true" ]]; then
    DEFAULT_ISSUE_URL="https://github.com/searxng/searxng/issues"
    ISSUE_URL="${ISSUE_URL:-${DEFAULT_ISSUE_URL}}"
    DEFAULT_DOCS_URL="https://docs.searxng.org"
    DOCS_URL="${DOCS_URL:-${DEFAULT_DOCS_URL}}"
    DEFAULT_PUBLIC_INSTANCES_URL="https://searx.space"
    PUBLIC_INSTANCES_URL="${PUBLIC_INSTANCES_URL:-${DEFAULT_PUBLIC_INSTANCES_URL}}"
    DEFAULT_WIKI_URL="https://github.com/searxng/searxng/wiki"
    WIKI_URL="${WIKI_URL:-${DEFAULT_WIKI_URL}}"

    cat >> "${CONF}" <<EOF

brand:
  issue_url: "${ISSUE_URL}"
  docs_url: "${DOCS_URL}"
  public_instances: ${PUBLIC_INSTANCES_URL}"
  wiki_url: "${WIKI_URL}"
EOF
  fi

  # Redis Settings
  if [[ -v REDIS_URL ]]; then
    cat >> "${CONF}" <<EOF

redis:
  url: "${REDIS_URL}"
EOF
  fi

  # Outgoing Settings
  if [[ -v CUSTOM_OUTGOING ]] && [[ "${CUSTOM_OUTGOING}" == "true" ]]; then
    DEFAULT_REQUEST_TIMEOUT="3.0"
    REQUEST_TIMEOUT="${REQUEST_TIMEOUT:-${DEFAULT_REQUEST_TIMEOUT}}"
    DEFAULT_USERAGENT_SUFFIX=""
    USERAGENT_SUFFIX="${USERAGENT_SUFFIX:-${DEFAULT_USERAGENT_SUFFIX}}"
    DEFAULT_POOL_CONNECTIONS="100"
    POOL_CONNECTIONS="${POOL_CONNECTIONS:-${DEFAULT_POOL_CONNECTIONS}}"
    DEFAULT_POOL_MAXSIZE="20"
    POOL_MAXSIZE="${POOL_MAXSIZE:-${DEFAULT_POOL_MAXSIZE}}"
    DEFAULT_ENABLE_HTTP2="true"
    ENABLE_HTTP2="${ENABLE_HTTP2:-${DEFAULT_ENABLE_HTTP2}}"

    cat >> "${CONF}" << EOF

outgoing:
  request_timeout: ${REQUEST_TIMEOUT}
  useragent_suffix: "${DEFAULT_USERAGENT_SUFFIX}"
  pool_connections: ${POOL_CONNECTIONS}
  pool_maxsize: ${POOL_MAXSIZE}
  enable_http2: ${ENABLE_HTTP2}
EOF

    if [[ -v OUTGOING_PROXIES ]]; then
      cat >> "${CONF}" << EOF
  proxies:
    all://:
EOF
      for i in $(echo "${OUTGOING_PROXIES}" | sed "s|,| |g")
      do
        cat >> "${CONF}" << EOF
      - "$i"
EOF
      done
    fi
  fi
}

export DEFAULT_SEARXNG_SETTINGS_PATH="/searxng/settings.yml"
export SEARXNG_SETTINGS_PATH="${SEARXNG_SETTINGS_PATH:-${DEFAULT_SEARXNG_SETTINGS_PATH}}"

export DEFAULT_BIND_ADDRESS="0.0.0.0:8080"
export BIND_ADDRESS="${BIND_ADDRESS:-${DEFAULT_BIND_ADDRESS}}"

patch_searxng_settings "${SEARXNG_SETTINGS_PATH}"

SEARXNG_VERSION="$(<VERSION)"
export SEARXNG_VERSION
echo "SearXNG version ${SEARXNG_VERSION}"

exec uwsgi --master --http-socket "${BIND_ADDRESS}" /searxng/uwsgi.ini
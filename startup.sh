#!/usr/bin/env sh

export DEFAULT_SEARXNG_SETTINGS_PATH="/searxng/settings.yml"
export SEARXNG_SETTINGS_PATH="${SEARXNG_SETTINGS_PATH:-${DEFAULT_SEARXNG_SETTINGS_PATH}}"

export DEFAULT_BIND_ADDRESS="0.0.0.0:8080"
export BIND_ADDRESS="${BIND_ADDRESS:-${DEFAULT_BIND_ADDRESS}}"

SEARXNG_VERSION="$(cat /searxng/VERSION)"
export SEARXNG_VERSION
echo "SearXNG version ${SEARXNG_VERSION}"

patch_searxng_settings() {
  CONF="$1"

  sed -i -e "s|SECRET_KEY|$(openssl rand -hex 32)|g" "${CONF}"

  # Server settings
  if [ -n "${BASE_URL}" ]; then
    sed -i -e "s|base_url: false|base_url: \"${BASE_URL}\"|g" "${CONF}"
  fi
  if [ -n "${LIMITER}" ] && [ "${LIMITER}" = "true" ]; then
    sed -i -e "s|limiter: false|limiter: true|g" "${CONF}"
  fi
  if [ -n "${IMAGE_PROXY}" ] && [ "${IMAGE_PROXY}" = "true" ]; then
    sed -i -e "s|image_proxy: false|image_proxy: true|g" "${CONF}"
  fi

  # General settings
  if [ -n "${DEBUG}" ] && [ "${DEBUG}" = "true" ]; then
    sed -i -e "s|debug: false|debug: true|g" "${CONF}"
  fi
  if [ -n "${INSTANCE_NAME}" ]; then
    sed -i -e "s|instance_name: \"SearXNG\"|instance_name: \"${INSTANCE_NAME}\"|g" "${CONF}"
  fi
  if [ -n "${PRIVACY_POLICY_URL}" ]; then
    sed -i -e "s|privacypolicy_url: false|privacypolicy_url: \"${PRIVACY_POLICY_URL}\"|g" "${CONF}"
  fi
  if [ -n "${DONATION_URL}" ]; then
    sed -i -e "s|donation_url: false|donation_url: \"${DONATION_URL}\"|g" "${CONF}"
  fi

  # UI settings
  if [ -n "${CUSTOM_UI}" ] && [ "${CUSTOM_UI}" = "true" ]; then
    DEFAULT_STATIC_PATH=""
    STATIC_PATH="${STATIC_PATH:-${DEFAULT_STATIC_PATH}}"
    DEFAULT_STATIC_USE_HASH="false"
    STATIC_USE_HASH="${STATIC_USE_HASH:-${DEFAULT_STATIC_USE_HASH}}"
    DEFAULT_TEMPLATES_PATH=""
    TEMPLATES_PATH="${TEMPLATES_PATH:-${DEFAULT_TEMPLATES_PATH}}"
    DEFAULT_QUERY_IN_TITLE="false"
    QUERY_IN_TITLE="${QUERY_IN_TITLE:-${DEFAULT_QUERY_IN_TITLE}}"
    DEFAULT_INFINITE_SCROLL="false"
    INFINITE_SCROLL=${INFINITE_SCROLL:-${DEFAULT_INFINITE_SCROLL}}
    DEFAULT_DEFAULT_THEME="simple"
    DEFAULT_THEME="${DEFAULT_THEME:-${DEFAULT_DEFAULT_THEME}}"
    DEFAULT_CENTER_ALIGNMENT="false"
    CENTER_ALIGNMENT="${CENTER_ALIGNMENT:-${DEFAULT_CENTER_ALIGNMENT}}"
    DEFAULT_DEFAULT_LOCALE=""
    DEFAULT_LOCALE="${DEFAULT_LOCALE:-${DEFAULT_DEFAULT_LOCALE}}"
    DEFAULT_RESULTS_ON_NEW_TAB="false"
    RESULTS_ON_NEW_TAB="${RESULTS_ON_NEW_TAB:-${DEFAULT_RESULTS_ON_NEW_TAB}}"
    DEFAULT_SIMPLE_STYLE="auto"
    SIMPLE_STYLE="${SIMPLE_STYLE:-${DEFAULT_SIMPLE_STYLE}}"

    cat >> "${CONF}" << EOF

ui:
  static_path: "${STATIC_PATH}"
  static_use_hash: ${STATIC_USE_HASH}
  templates_path: "${TEMPLATES_PATH}"
  query_in_title: ${QUERY_IN_TITLE}
  infinite_scroll: ${INFINITE_SCROLL}
  default_theme: "${DEFAULT_THEME}"
  center_alignment: ${CENTER_ALIGNMENT}
  default_locale: "${DEFAULT_LOCALE}"
  results_on_new_tab: ${RESULTS_ON_NEW_TAB}
  theme_args:
    simple_style: "${SIMPLE_STYLE}"
EOF
  fi

  # Search settings
  if [ -n "${CUSTOM_SEARCH}" ] && [ "${CUSTOM_SEARCH}" = "true" ]; then
    DEFAULT_SAFE_SEARCH="0"
    SAFE_SEARCH="${SAFE_SEARCH:-${DEFAULT_SAFE_SEARCH}}"
    DEFAULT_AUTOCOMPLETE=""
    AUTOCOMPLETE="${AUTOCOMPLETE:-${DEFAULT_AUTOCOMPLETE}}"
    DEFAULT_AUTOCOMPLETE_MIN="4"
    AUTOCOMPLETE_MIN="${AUTOCOMPLETE_MIN:-${DEFAULT_AUTOCOMPLETE_MIN}}"
    DEFAULT_DEFAULT_LANG=""
    DEFAULT_LANG="${DEFAULT_LANG:-${DEFAULT_DEFAULT_LANG}}"
    DEFAULT_BAN_TIME_ON_FAIL="5"
    BAN_TIME_ON_FAIL="${BAN_TIME_ON_FAIL:-${DEFAULT_BAN_TIME_ON_FAIL}}"
    DEFAULT_MAX_BAN_TIME_ON_FAIL="120"
    MAX_BAN_TIME_ON_FAIL="${MAX_BAN_TIME_ON_FAIL:-${DEFAULT_MAX_BAN_TIME_ON_FAIL}}"

    cat >> "${CONF}" << EOF

search:
  safe_search: ${SAFE_SEARCH}
  autocomplete: "${AUTOCOMPLETE}"
  autocomplete_min: ${AUTOCOMPLETE_MIN}
  default_lang: "${DEFAULT_LANG}"
  ban_time_on_fail: ${BAN_TIME_ON_FAIL}
  max_ban_time_on_fail: ${MAX_BAN_TIME_ON_FAIL}
  formats:
    - html
EOF

    # Available languages
    if [ -n "${AVAILABLE_LANGUAGES}" ]; then
      cat >> "${CONF}" << EOF
  languages:
EOF
      for i in $(echo "${AVAILABLE_LANGUAGES}" | sed "s|,| |g")
      do
        cat >> "${CONF}" << EOF
    - "$i"
EOF
      done
    fi
  fi

  # Brand settings
  if [ -n "${CUSTOM_BRAND}" ] && [ "${CUSTOM_BRAND}" = "true" ]; then
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

  # Outgoing settings
  if [ -n "${CUSTOM_OUTGOING}" ] && [ "${CUSTOM_OUTGOING}" = "true" ]; then
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
  useragent_suffix: "${USERAGENT_SUFFIX}"
  pool_connections: ${POOL_CONNECTIONS}
  pool_maxsize: ${POOL_MAXSIZE}
  enable_http2: ${ENABLE_HTTP2}
EOF

    # Outgoing proxies
    if [ -n "${OUTGOING_PROXIES}" ]; then
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

  # Redis Settings
  if [ -n "${REDIS_URL}" ]; then
    cat >> "${CONF}" <<EOF

redis:
  url: "${REDIS_URL}"
EOF
  fi
}

patch_searxng_settings "${SEARXNG_SETTINGS_PATH}"

exec uwsgi --master --http-socket "${BIND_ADDRESS}" /searxng/uwsgi.ini
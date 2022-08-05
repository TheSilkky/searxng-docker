![SearXNG](https://raw.githubusercontent.com/TheSilkky/searxng-docker/main/assets/searxng.svg)

## Environment Variables

### Server settings
| Variable       | Description |
|----------------|-------------|
| `BIND_ADDRESS` |             |
| `BASE_URL`     |             |
| `LIMITER`      |             |
| `IMAGE_PROXY`  |             |

### General settings
| Variable             | Description |
|----------------------|-------------|
| `DEBUG`              |             |
| `INSTANCE_NAME`      |             |
| `PRIVACY_POLICY_URL` |             |
| `DONATION_URL`       |             |
| `ENABLE_METRICS`     |             |

### UI settings
- To customize UI settings set `UI_SETTINGS=true`

| Variable             | Description |
|----------------------|-------------|
| `STATIC_PATH`        |             |
| `STATIC_USE_HASH`    |             |
| `TEMPLATES_PATH`     |             |
| `QUERY_IN_TITLE`     |             |
| `INFINTE_SCROLL`     |             |
| `DEFAULT_THEME`      |             |
| `CENTER_ALIGNMENT`   |             |
| `DEFAULT_LOCALE`     |             |
| `RESULTS_ON_NEW_TAB` |             |
| `SIMPLE_STYLE`       |             |

### Search settings
- To customize search settings set `SEARCH_SETTINGS=true`

| Variable               | Description |
|------------------------|-------------|
| `SAFE_SEARCH`          |             |
| `AUTOCOMPLETE`         |             |
| `AUTOCOMPLETE_MIN`     |             |
| `DEFAULT_LANG`         |             |
| `BAN_TIME_ON_FAIL`     |             |
| `MAX_BAN_TIME_ON_FAIL` |             |
| `AVAILABLE_LANGUAGES`  |             |

### Brand settings
- To customize brand settings set `BRAND_SETTINGS=true`

| Variable               | Description |
|------------------------|-------------|
| `ISSUE_URL`            |             |
| `DOCS_URL`             |             |
| `PUBLIC_INSTANCES_URL` |             |
| `WIKI_URL`             |             |

### Outgoing settings
- To customize outgoing settings set `OUTGOING_SETTINGS=true`

| Variable           | Description |
|--------------------|-------------|
| `REQUEST_TIMEOUT`  |             |
| `USERAGENT_SUFFIX` |             |
| `POOL_CONNECTIONS` |             |
| `POOL_MAXSIZE`     |             |
| `ENABLE_HTTP2`     |             |
| `OUTGOING_PROXIES` |             |

### Redis settings
| Variable    | Description |
|-------------|-------------|
| `REDIS_URL` |             |

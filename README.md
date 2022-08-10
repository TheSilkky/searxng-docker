***

[![SearXNG](https://raw.githubusercontent.com/TheSilkky/searxng-docker/main/assets/searxng.svg)](https://docs.searxng.org/)

***

[SearXNG](https://docs.searxng.org/) is a free internet metasearch engine which aggregates results from various search services and databases. Users are neither tracked nor profiled.

## Environment Variables

### General
| Variable                     | Description                                                                                                 |
|------------------------------|-------------------------------------------------------------------------------------------------------------|
| `GENERAL_DEBUG`              | Allow a more detailed log. Displays detailed error messages in browser too, must be disabled in production. |
| `GENERAL_INSTANCE_NAME`      | Name of the instance.                                                                                       |
| `GENERAL_PRIVACY_POLICY_URL` | Link to privacy policy.                                                                                     |
| `GENERAL_DONATION_URL`       | Link to a donation page, default points to the [SeaXNG project](https://docs.searxng.org/donate.html).      |
| `GENERAL_CONTACT_URL`        | Contact `mailto:` address or link to a contact page.                                                        |
| `GENERAL_ENABLE_METRICS`     | Record various anonymous metrics available at `/stats`, `/stats/errors` and `/preferences`.                 |

### Brand
| Variable                 | Description                                                             |
|--------------------------|-------------------------------------------------------------------------|
| `BRAND_NEW_ISSUE_URL`    |                                                                         |
| `BRAND_DOCS_URL`         | If you host your documentation change this URL.                         |
| `BRAND_PUBLIC_INSTANCES` | If you host your own [searx.space](https://searx.space) change the URL. |
| `BRAND_WIKI_URL`         | Link to your own wiki. (or `false` for none)                            |
| `BRAND_ISSUE_URL`        | If you host your own issue tracker change this URL.                     |

### Search
| Variable                      | Description                                                                          |
|-------------------------------|--------------------------------------------------------------------------------------|
| `SEARCH_SAFE_SEARCH`          | Filter results. `0`: None, `1`: Moderate, `2`: Strict                                |
| `SEARCH_AUTOCOMPLETE`         | Existing autocomplete backends. eg. `AUTOCOMPLETE=duckduckgo`                        |
| `SEARCH_AUTOCOMPLETE_MIN`     | Minimum search length for autocomplete.                                              |
| `SEARCH_DEFAULT_LANG`         | Default search language.                                                             |
| `SEARCH_LANGUAGES`            | List of available languages, leave unset to use all. eg. `AVAILABLE_LANGUAGES=en,de` |
| `SEARCH_BAN_TIME_ON_FAIL`     | Ban time in seconds after engine errors.                                             |
| `SEARCH_MAX_BAN_TIME_ON_FAIL` | Max ban time in seconds after engine errors.                                         |
| `SEARCH_FORMATS`              |                                                                                      |

### Server
| Variable                       | Description                                                                                                     |
|--------------------------------|-----------------------------------------------------------------------------------------------------------------|
| `SERVER_BIND_ADDRESS`          | Address and port to listen on. eg. `BIND_ADDRESS=0.0.0.0:8080`                                                  |
| `SERVER_BASE_URL`              | The base URL where SearXNG is deployed.                                                                         |
| `SERVER_LIMITER`               | Rate limit the number requests on the instance and block bots. **Requires Redis, see [Redis Settings](#redis)** |
| `SERVER_IMAGE_PROXY`           | Allow SearXNG to proxy images.                                                                                  |
| `SERVER_HTTP_PROTOCOL_VERSION` |                                                                                                                 |
| `SERVER_METHOD`                |                                                                                                                 |

### Redis
A Redis database can be connected by a URL, this is currently primarily used for the limiter plugin.

| Variable    | Description                                                                                                                                            |
|-------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| `REDIS_URL` | URL to connect to Redis database, see [SearXNG docs](https://docs.searxng.org/admin/engines/settings.html#redis). eg. `REDIS_URL=redis://redis:6379/0` |

### UI
| Variable                | Description                                                                                                  |
|-------------------------|--------------------------------------------------------------------------------------------------------------|
| `UI_QUERY_IN_TITLE`     | Display the query in the result page's title.                                                                |
| `UI_INFINTE_SCROLL`     | Automatically load the next page when scrolling.                                                             |
| `UI_CENTER_ALIGNMENT`   | Center results instead of being in the left side of the screen. Only affects the desktop layout.             |
| `UI_DEFAULT_LOCALE`     | Interface language. By default the locale is detected by using the browser language. eg. `DEFAULT_LOCALE=en` |
| `UI_RESULTS_ON_NEW_TAB` | Open result links in a new tab by default.                                                                   |
| `UI_SIMPLE_STYLE`       | Style of simple theme: `auto`, `light` or `dark`.                                                            |

### Outgoing
Communication with search engines.

| Variable                       | Description                                                                                                                                                                         |
|--------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `OUTGOING_REQUEST_TIMEOUT`     | Global timeout of the requests made to other engines in seconds.                                                                                                                    |
| `OUTGOING_USERAGENT_SUFFIX`    | Suffix to the user-agent SearXNG uses to send requests to others engines.                                                                                                           |
| `OUTGOING_POOL_CONNECTIONS`    | Maximum number of allowable connections, set to `null` for no limits.                                                                                                               |
| `OUTGOING_POOL_MAXSIZE`        | Number of allowable keep-alive connections, set to `null` for no limits.                                                                                                            |
| `OUTGOING_ENABLE_HTTP2`        | Enabled by default. Set to `false` to disable HTTP/2.                                                                                                                               |
| `OUTGOING_PROXIES`             | Define one of more proxies you wish to use, see [httpx proxies](https://www.python-httpx.org/advanced/#http-proxying). eg. `OUTGOING_PROXIES=http://proxy1:8080,http://proxy2:8080` |
| `OUTGOING_USING_TOR_PROXY`     |                                                                                                                                                                                     |
| `OUTGOING_EXTRA_PROXY_TIMEOUT` |                                                                                                                                                                                     |
| `OUTGOING_SOURCE_IPS`          |                                                                                                                                                                                     |

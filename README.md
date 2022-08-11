***

[![SearXNG](https://raw.githubusercontent.com/TheSilkky/searxng-docker/main/assets/searxng.svg)](https://docs.searxng.org/)

***

[SearXNG](https://docs.searxng.org/) is a free internet metasearch engine which aggregates results from various search services and databases. Users are neither tracked nor profiled.

[![Docker Hub](https://img.shields.io/badge/searxng--docker-docker%20hub-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://hub.docker.com/r/thesilkky/searxng)
[![GitHub Package](https://img.shields.io/badge/searxng--docker-github%20package-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)](https://github.com/TheSilkky/searxng-docker/pkgs/container/searxng)

## Environment Variables

### General
| Variable                     | Example                      | Description                                                                                                |
|------------------------------|------------------------------|------------------------------------------------------------------------------------------------------------|
| `GENERAL_DEBUG`              | `true`                       | Allow a more detailed log. Displays detailed error messages in browser too, must be disabled in production |
| `GENERAL_INSTANCE_NAME`      | `My SearXNG`                 | Name of the instance                                                                                       |
| `GENERAL_PRIVACY_POLICY_URL` | `https://my-website/privacy` | Link to privacy policy                                                                                     |
| `GENERAL_DONATION_URL`       | `https://my-website/donate`  | Link to a donation page, default points to the [SeaXNG project](https://docs.searxng.org/donate.html)      |
| `GENERAL_CONTACT_URL`        | `https://my-website/contact` | Contact `mailto:` address or link to a contact page                                                        |
| `GENERAL_ENABLE_METRICS`     | `false`                      | Record various anonymous metrics available at `/stats`, `/stats/errors` and `/preferences`                 |

### Brand
| Variable                 | Example                                                   | Description                                                            |
|--------------------------|-----------------------------------------------------------|------------------------------------------------------------------------|
| `BRAND_NEW_ISSUE_URL`    | `=https://github.com/TheSilkky/searxng-docker/issues/new` |                                                                        |
| `BRAND_DOCS_URL`         | `https://my-website/docs`                                 | If you host your documentation change this URL                         |
| `BRAND_PUBLIC_INSTANCES` | `https://my-website/instances`                            | If you host your own [searx.space](https://searx.space) change the URL |
| `BRAND_WIKI_URL`         | `https://my-website/wiki`                                 | Link to your own wiki (or `false` for none)                            |
| `BRAND_ISSUE_URL`        | `https://github.com/TheSilkky/searxng-docker/issues`      | If you host your own issue tracker change this URL                     |

### Search
| Variable                      | Example         | Description                                           |
|-------------------------------|-----------------|-------------------------------------------------------|
| `SEARCH_SAFE_SEARCH`          | `1`             | Filter results. `0`: None, `1`: Moderate, `2`: Strict |
| `SEARCH_AUTOCOMPLETE`         | `google`        | Existing autocomplete backends                        |
| `SEARCH_AUTOCOMPLETE_MIN`     | `4`             | Minimum search length for autocomplete                |
| `SEARCH_DEFAULT_LANG`         | `en`            | Default search language                               |
| `SEARCH_LANGUAGES`            | `en,fr,de`      | List of available languages, leave unset to use all   |
| `SEARCH_BAN_TIME_ON_FAIL`     | `5`             | Ban time in seconds after engine errors               |
| `SEARCH_MAX_BAN_TIME_ON_FAIL` | `10`            | Max ban time in seconds after engine errors           |
| `SEARCH_FORMATS`              | `html,csv,json` |                                                       |

### Server
| Variable                       | Example                | Description                                                                                                     |
|--------------------------------|------------------------|-----------------------------------------------------------------------------------------------------------------|
| `SERVER_BIND_ADDRESS`          | `0.0.0.0:8080`         | Address and port to listen on                                                                                   |
| `SERVER_BASE_URL`              | `https://my-instance/` | The base URL where SearXNG is deployed                                                                          |
| `SERVER_LIMITER`               | `true`                 | Rate limit the number requests on the instance and block bots. **Requires Redis, see [Redis Settings](#redis)** |
| `SERVER_IMAGE_PROXY`           | `true`                 | Allow SearXNG to proxy images                                                                                   |
| `SERVER_HTTP_PROTOCOL_VERSION` | `1.0`                  |                                                                                                                 |
| `SERVER_METHOD`                | `POST`                 |                                                                                                                 |

### Redis
A Redis database can be connected by a URL, this is currently primarily used for the limiter plugin.

| Variable    | Example                | Description                                                                                                      |
|-------------|------------------------|------------------------------------------------------------------------------------------------------------------|
| `REDIS_URL` | `redis://redis:6379/0` | URL to connect to Redis database, see [SearXNG docs](https://docs.searxng.org/admin/engines/settings.html#redis) |

### UI
| Variable                | Example | Description                                                                                     |
|-------------------------|---------|-------------------------------------------------------------------------------------------------|
| `UI_QUERY_IN_TITLE`     | `true`  | Display the query in the result page's title                                                    |
| `UI_INFINTE_SCROLL`     | `true`  | Automatically load the next page when scrolling                                                 |
| `UI_CENTER_ALIGNMENT`   | `true`  | Center results instead of being in the left side of the screen. Only affects the desktop layout |
| `UI_DEFAULT_LOCALE`     | `en`    | Interface language. By default the locale is detected by using the browser language             |
| `UI_RESULTS_ON_NEW_TAB` | `true`  | Open result links in a new tab by default                                                       |
| `UI_SIMPLE_STYLE`       | `dark`  | Style of simple theme: `auto`, `light` or `dark`                                                |

### Outgoing
Communication with search engines.

| Variable                       | Example                                 | Description                                                                                                           |
|--------------------------------|-----------------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| `OUTGOING_REQUEST_TIMEOUT`     | `3.0`                                   | Global timeout of the requests made to other engines in seconds                                                       |
| `OUTGOING_USERAGENT_SUFFIX`    | `contact@example.com`                   | Suffix to the user-agent SearXNG uses to send requests to others engines                                              |
| `OUTGOING_POOL_CONNECTIONS`    | `100`                                   | Maximum number of allowable connections, set to `null` for no limits                                                  |
| `OUTGOING_POOL_MAXSIZE`        | `20`                                    | Number of allowable keep-alive connections, set to `null` for no limits                                               |
| `OUTGOING_ENABLE_HTTP2`        | `false`                                 | Enabled by default. Set to `false` to disable HTTP/2                                                                  |
| `OUTGOING_PROXIES`             | `http://proxy1:8080,http://proxy2:8080` | Define one of more proxies you wish to use, see [httpx proxies](https://www.python-httpx.org/advanced/#http-proxying) |
| `OUTGOING_USING_TOR_PROXY`     | `true`                                  |                                                                                                                       |
| `OUTGOING_EXTRA_PROXY_TIMEOUT` | `10.0`                                  |                                                                                                                       |
| `OUTGOING_SOURCE_IPS`          | `1.1.1.1,1.1.1.2`                       |                                                                                                                       |

### Custom
Useful for adding more advanced configuration, such as customizing engine settings.

| Variable         | Example                                               | Description                                                                                                              |
|------------------|-------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| `CUSTOM_CONFIGS` | `/searxng/custom-engines.yml,/searxng/cool-stuff.yml` | Path to one or multiple custom SearXNG config files. The options specified will be merged over the generated config file |

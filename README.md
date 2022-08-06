[![SearXNG](https://raw.githubusercontent.com/TheSilkky/searxng-docker/main/assets/searxng.svg)](https://docs.searxng.org/)

---

[SearXNG](https://docs.searxng.org/) is a free internet metasearch engine which aggregates results from various search services and databases. Users are neither tracked nor profiled.



## Environment Variables

### Server
| Variable       | Description                                                                                                     |
|----------------|-----------------------------------------------------------------------------------------------------------------|
| `BIND_ADDRESS` | Address and port to listen on. eg. `BIND_ADDRESS=0.0.0.0:8080`                                                  |
| `BASE_URL`     | The base URL where SearXNG is deployed.                                                                         |
| `LIMITER`      | Rate limit the number requests on the instance and block bots. **Requires Redis, see [Redis Settings](#redis)** |
| `IMAGE_PROXY`  | Allow SearXNG to proxy images.                                                                                  |

### General
| Variable             | Description                                                                                                 |
|----------------------|-------------------------------------------------------------------------------------------------------------|
| `DEBUG`              | Allow a more detailed log. Displays detailed error messages in browser too, must be disabled in production. |
| `INSTANCE_NAME`      | Name of the instance.                                                                                       |
| `PRIVACY_POLICY_URL` | Link to privacy policy.                                                                                     |
| `DONATION_URL`       | Link to a donation page, default points to the [SeaXNG project](https://docs.searxng.org/donate.html).      |
| `CONTACT_URL`        | Contact `mailto:` address or link to a contact page.                                                        |
| `ENABLE_METRICS`     | Record various anonymous metrics available at `/stats`, `/stats/errors` and `/preferences`.                 |

### UI
To customize UI settings set `UI_SETTINGS=true`

| Variable             | Description                                                                                                                                                |
|----------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `STATIC_PATH`        | Custom static path.                                                                                                                                        |
| `STATIC_USE_HASH`    | Enables [cache busting](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cache-Control#caching_static_assets_with_cache_busting) of static files. |
| `TEMPLATES_PATH`     | Custom templates path.                                                                                                                                     |
| `QUERY_IN_TITLE`     | Display the query in the result page's title.                                                                                                              |
| `INFINTE_SCROLL`     | Automatically load the next page when scrolling.                                                                                                           |
| `DEFAULT_THEME`      | Name of the theme you want to use by default. Only the `simple` theme is installed.                                                                        |
| `CENTER_ALIGNMENT`   | Center results instead of being in the left side of the screen. Only affects the desktop layout.                                                           |
| `DEFAULT_LOCALE`     | Interface language. By default the locale is detected by using the browser language. eg. `DEFAULT_LOCALE=en`                                               |
| `RESULTS_ON_NEW_TAB` | Open result links in a new tab by default.                                                                                                                 |
| `SIMPLE_STYLE`       | Style of simple theme: `auto`, `light` or `dark`.                                                                                                          |

### Search
To customize search settings set `SEARCH_SETTINGS=true`

| Variable               | Description                                                                          |
|------------------------|--------------------------------------------------------------------------------------|
| `SAFE_SEARCH`          | Filter results. `0`: None, `1`: Moderate, `2`: Strict                                |
| `AUTOCOMPLETE`         | Existing autocomplete backends. eg. `AUTOCOMPLETE=duckduckgo`                        |
| `AUTOCOMPLETE_MIN`     | Minimum search length for autocomplete.                                              |
| `DEFAULT_LANG`         | Default search language.                                                             |
| `BAN_TIME_ON_FAIL`     | Ban time in seconds after engine errors.                                             |
| `MAX_BAN_TIME_ON_FAIL` | Max ban time in seconds after engine errors.                                         |
| `AVAILABLE_LANGUAGES`  | List of available languages, leave unset to use all. eg. `AVAILABLE_LANGUAGES=en,de` |

### Brand
To customize brand settings set `BRAND_SETTINGS=true`

| Variable               | Description                                                             |
|------------------------|-------------------------------------------------------------------------|
| `ISSUE_URL`            | If you host your own issue tracker change this URL.                     |
| `DOCS_URL`             | If you host your documentation change this URL.                         |
| `PUBLIC_INSTANCES_URL` | If you host your own [searx.space](https://searx.space) change the URL. |
| `WIKI_URL`             | Link to your own wiki. (or `false` for none)                            |

### Outgoing
Communication with search engines.

To customize outgoing settings set `OUTGOING_SETTINGS=true`

| Variable           | Description                                                                                                                                                                         |
|--------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `REQUEST_TIMEOUT`  | Global timeout of the requests made to other engines in seconds.                                                                                                                    |
| `USERAGENT_SUFFIX` | Suffix to the user-agent SearXNG uses to send requests to others engines.                                                                                                           |
| `POOL_CONNECTIONS` | Maximum number of allowable connections, set to `null` for no limits.                                                                                                               |
| `POOL_MAXSIZE`     | Number of allowable keep-alive connections, set to `null` for no limits.                                                                                                            |
| `ENABLE_HTTP2`     | Enabled by default. Set to `false` to disable HTTP/2.                                                                                                                               |
| `OUTGOING_PROXIES` | Define one of more proxies you wish to use, see [httpx proxies](https://www.python-httpx.org/advanced/#http-proxying). eg. `OUTGOING_PROXIES=http://proxy1:8080,http://proxy2:8080` |

### Redis
A Redis database can be connected by a URL, this is currently primarily used for the limiter plugin. 

| Variable    | Description                                                                                                                                            |
|-------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| `REDIS_URL` | URL to connect to Redis database, see [SearXNG docs](https://docs.searxng.org/admin/engines/settings.html#redis). eg. `REDIS_URL=redis://redis:6379/0` |

### Custom
Useful for adding more advanced configuration, such as customizing engine settings.

| Variable          | Description                                                                                                                  |
|-------------------|------------------------------------------------------------------------------------------------------------------------------|
| `CUSTOM_SETTINGS` | Path to custom SearXNG config files, the contents of these files will be appended to the end of the generated `settings.yml` |
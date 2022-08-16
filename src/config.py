#!/usr/bin/env python3

# Very silly script
# 0/10

import os
import secrets
import sys
from collections.abc import Mapping

import yaml
from searx.settings_loader import update_dict


def gen_general_conf():
    general_conf = {}

    DEBUG = os.getenv('GENERAL_DEBUG')
    INSTANCE_NAME = os.getenv('GENERAL_INSTANCE_NAME')
    PRIVACY_POLICY_URL = os.getenv('GENERAL_PRIVACY_POLICY_URL')
    DONATION_URL = os.getenv('GENERAL_DONATION_URL')
    CONTACT_URL = os.getenv('GENERAL_CONTACT_URL')
    ENABLE_METRICS = os.getenv('GENERAL_ENABLE_METRICS')

    if DEBUG is not None:
        general_conf['debug'] = bool(DEBUG)
    if INSTANCE_NAME is not None:
        general_conf['instance_name'] = INSTANCE_NAME
    if PRIVACY_POLICY_URL is not None:
        general_conf['privacypolicy_url'] = PRIVACY_POLICY_URL
    if DONATION_URL is not None:
        general_conf['donation_url'] = DONATION_URL
    if CONTACT_URL is not None:
        general_conf['contact_url'] = CONTACT_URL
    if ENABLE_METRICS is not None:
        general_conf['enable_metrics'] = bool(ENABLE_METRICS)

    return general_conf if general_conf else None


def gen_brand_conf():
    brand_conf = {}

    NEW_ISSUE_URL = os.getenv('BRAND_NEW_ISSUE_URL')
    DOCS_URL = os.getenv('BRAND_DOCS_URL')
    PUBLIC_INSTANCES = os.getenv('BRAND_PUBLIC_INSTANCES')
    WIKI_URL = os.getenv('BRAND_WIKI_URL')
    ISSUE_URL = os.getenv('BRAND_ISSUE_URL')

    if NEW_ISSUE_URL is not None:
        brand_conf['new_issue_url'] = NEW_ISSUE_URL
    if DOCS_URL is not None:
        brand_conf['docs_url'] = DOCS_URL
    if PUBLIC_INSTANCES is not None:
        brand_conf['public_instances'] = PUBLIC_INSTANCES
    if WIKI_URL is not None:
        brand_conf['wiki_url'] = WIKI_URL
    if ISSUE_URL is not None:
        brand_conf['issue_url'] = ISSUE_URL

    return brand_conf if brand_conf else None


def gen_search_conf():
    search_conf = {}

    SAFE_SEARCH = os.getenv('SEARCH_SAFE_SEARCH')
    AUTOCOMPLETE = os.getenv('SEARCH_AUTOCOMPLETE')
    AUTOCOMPLETE_MIN = os.getenv('SEARCH_AUTOCOMPLETE_MIN')
    DEFAULT_LANG = os.getenv('SEARCH_DEFAULT_LANG')
    LANGUAGES = os.getenv('SEARCH_LANGUAGES')
    BAN_TIME_ON_FAIL = os.getenv('SEARCH_BAN_TIME_ON_FAIL')
    MAX_BAN_TIME_ON_FAIL = os.getenv('SEARCH_MAX_BAN_TIME_ON_FAIL')
    FORMATS = os.getenv('SEARCH_FORMATS')

    if SAFE_SEARCH is not None:
        search_conf['safe_search'] = int(SAFE_SEARCH)
    if AUTOCOMPLETE is not None:
        search_conf['autocomplete'] = AUTOCOMPLETE
    if AUTOCOMPLETE_MIN is not None:
        search_conf['autocomplete_min'] = int(AUTOCOMPLETE_MIN)
    if DEFAULT_LANG is not None:
        search_conf['default_lang'] = DEFAULT_LANG
    if LANGUAGES is not None:
        languages_arr = LANGUAGES.split(",")
        search_conf['languages'] = languages_arr
    if BAN_TIME_ON_FAIL is not None:
        search_conf['ban_time_on_fail'] = int(BAN_TIME_ON_FAIL)
    if MAX_BAN_TIME_ON_FAIL is not None:
        search_conf['max_ban_time_on_fail'] = int(MAX_BAN_TIME_ON_FAIL)
    if FORMATS is not None:
        formats_arr = FORMATS.split(",")
        search_conf['formats'] = formats_arr

    return search_conf if search_conf else None


def gen_server_conf():
    server_conf = {'secret_key': secrets.token_hex(32)}

    BASE_URL = os.getenv('SERVER_BASE_URL')
    LIMITER = os.getenv('SERVER_LIMITER')
    IMAGE_PROXY = os.getenv('SERVER_IMAGE_PROXY')
    HTTP_PROTOCOL_VERSION = os.getenv('SERVER_HTTP_PROTOCOL_VERSION')
    METHOD = os.getenv('SERVER_METHOD')

    if BASE_URL is not None:
        server_conf['base_url'] = BASE_URL
    if LIMITER is not None:
        server_conf['limiter'] = bool(LIMITER)
    if IMAGE_PROXY is not None:
        server_conf['image_proxy'] = bool(IMAGE_PROXY)
    if HTTP_PROTOCOL_VERSION is not None:
        server_conf['http_protocol_version'] = HTTP_PROTOCOL_VERSION
    if METHOD is not None:
        server_conf['method'] = METHOD

    return server_conf


def gen_redis_conf():
    redis_conf = {}

    URL = os.getenv('REDIS_URL')

    if URL is not None:
        redis_conf['url'] = URL

    return redis_conf if redis_conf else None


def gen_ui_conf():
    ui_conf = {}

    QUERY_IN_TITLE = os.getenv('UI_QUERY_IN_TITLE')
    INFINITE_SCROLL = os.getenv('UI_INFINITE_SCROLL')
    CENTER_ALIGNMENT = os.getenv('UI_CENTER_ALIGNMENT')
    DEFAULT_LOCALE = os.getenv('UI_DEFAULT_LOCALE')
    RESULTS_ON_NEW_TAB = os.getenv('UI_RESULTS_ON_NEW_TAB')
    SIMPLE_STYLE = os.getenv('UI_SIMPLE_STYLE')

    if QUERY_IN_TITLE is not None:
        ui_conf['query_in_title'] = bool(QUERY_IN_TITLE)
    if INFINITE_SCROLL is not None:
        ui_conf['infinite_scroll'] = bool(INFINITE_SCROLL)
    if CENTER_ALIGNMENT is not None:
        ui_conf['center_alignment'] = bool(CENTER_ALIGNMENT)
    if DEFAULT_LOCALE is not None:
        ui_conf['default_locale'] = DEFAULT_LOCALE
    if RESULTS_ON_NEW_TAB is not None:
        ui_conf['results_on_new_tab'] = bool(RESULTS_ON_NEW_TAB)
    if SIMPLE_STYLE is not None:
        ui_conf['theme_args'] = {}
        ui_conf['theme_args']['simple_style'] = SIMPLE_STYLE

    return ui_conf if ui_conf else None


def gen_outgoing_conf():
    outgoing_conf = {}

    REQUEST_TIMEOUT = os.getenv('OUTGOING_REQUEST_TIMEOUT')
    USERAGENT_SUFFIX = os.getenv('OUTGOING_USERAGENT_SUFFIX')
    POOL_CONNECTIONS = os.getenv('OUTGOING_POOL_CONNECTIONS')
    POOL_MAXSIZE = os.getenv('OUTGOING_POOL_MAXSIZE')
    ENABLE_HTTP2 = os.getenv('OUTGOING_ENABLE_HTTP2')
    PROXIES = os.getenv('OUTGOING_PROXIES')
    USING_TOR_PROXY = os.getenv('OUTGOING_USING_TOR_PROXY')
    EXTRA_PROXY_TIMEOUT = os.getenv('OUTGOING_EXTRA_PROXY_TIMEOUT')
    SOURCE_IPS = os.getenv('OUTGOING_SOURCE_IPS')

    if REQUEST_TIMEOUT is not None:
        outgoing_conf['request_timeout'] = float(REQUEST_TIMEOUT)
    if USERAGENT_SUFFIX is not None:
        outgoing_conf['useragent_suffix'] = USERAGENT_SUFFIX
    if POOL_CONNECTIONS is not None:
        outgoing_conf['pool_connections'] = int(POOL_CONNECTIONS)
    if POOL_MAXSIZE is not None:
        outgoing_conf['pool_maxsize'] = int(POOL_MAXSIZE)
    if ENABLE_HTTP2 is not None:
        outgoing_conf['enable_http2'] = bool(ENABLE_HTTP2)
    if PROXIES is not None:
        proxies_arr = PROXIES.split(",")
        outgoing_conf['proxies'] = {}
        outgoing_conf['proxies']['all://'] = proxies_arr
    if USING_TOR_PROXY is not None:
        outgoing_conf['using_tor_proxy'] = bool(USING_TOR_PROXY)
    if EXTRA_PROXY_TIMEOUT is not None:
        outgoing_conf['extra_proxy_timeout'] = float(EXTRA_PROXY_TIMEOUT)
    if SOURCE_IPS is not None:
        source_ips_arr = SOURCE_IPS.split(",")
        outgoing_conf['source_ips'] = source_ips_arr

    return outgoing_conf if outgoing_conf else None


def generate_config():
    config_in = {'use_default_settings': True}

    general_conf = gen_general_conf()
    brand_conf = gen_brand_conf()
    search_conf = gen_search_conf()
    server_conf = gen_server_conf()
    redis_conf = gen_redis_conf()
    ui_conf = gen_ui_conf()
    outgoing_conf = gen_outgoing_conf()

    if general_conf is not None:
        config_in['general'] = general_conf
    if brand_conf is not None:
        config_in['brand'] = brand_conf
    if search_conf is not None:
        config_in['search'] = search_conf
    if server_conf is not None:
        config_in['server'] = server_conf
    if redis_conf is not None:
        config_in['redis'] = redis_conf
    if ui_conf is not None:
        config_in['ui'] = ui_conf
    if outgoing_conf is not None:
        config_in['outgoing'] = outgoing_conf

    CUSTOM_CONFIGS = os.getenv('CUSTOM_CONFIGS')
    if CUSTOM_CONFIGS is not None:
        custom_configs_arr = CUSTOM_CONFIGS.split(',')
        for custom_config in custom_configs_arr:
            with open(custom_config, 'r') as custom_config_file:
                custom_config = yaml.safe_load(custom_config_file)
                for k, v in custom_config.items():
                    if k in config_in and isinstance(v, Mapping):
                        update_dict(config_in[k], v)
                    else:
                        config_in[k] = v

    config_out = yaml.dump(config_in)

    return config_out


if __name__ == '__main__':
    settings_path = sys.argv[1]
    config = generate_config()
    with open(settings_path, 'w') as searxng_settings:
        searxng_settings.write(config)

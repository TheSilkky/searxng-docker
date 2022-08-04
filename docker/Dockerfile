####################################################################################################
## Builder image
####################################################################################################
FROM python:3.10.6-alpine3.16 AS builder

RUN apk add --no-cache \
    ca-certificates \
    build-base \
    libffi-dev \
    libxslt-dev \
    libxml2-dev \
    openssl-dev \
    libxml2 \
    libxslt \
    openssl \
    brotli \
    git

ADD https://api.github.com/repos/searxng/searxng/git/refs/head /cachebreak
RUN git clone https://github.com/searxng/searxng.git /searxng

WORKDIR /searxng

# Create dependency wheels & install
RUN pip install --upgrade pip wheel setuptools \
    && pip wheel --wheel-dir=/searxng/wheels -r requirements.txt \
    && pip install --no-index --find-links=/searxng/wheels -r requirements.txt

# Compress static files
RUN find /searxng/searx/static -a \( -name '*.html' -o -name '*.css' -o -name '*.js' \
    -o -name '*.svg' -o -name '*.ttf' -o -name '*.eot' \) \
    -type f -exec gzip -9 -k {} \+ -exec brotli --best {} \+

# Lock SearXNG version
RUN python3 -c "import six; import searx.version; six.print_(searx.version.VERSION_STRING)" > VERSION \
    && python3 -m searx.version freeze

####################################################################################################
## Final image
####################################################################################################
FROM python:3.10.6-alpine3.16

RUN apk add --no-cache \
    ca-certificates \
    libxml2 \
    libxslt \
    openssl \
    uwsgi \
    uwsgi-python3 \
    tini

WORKDIR /searxng

COPY --from=builder /searxng/searx /searxng/searx
COPY --from=builder /searxng/wheels /searxng/wheels
COPY --from=builder /searxng/requirements.txt /searxng/requirements.txt
COPY --from=builder /searxng/VERSION /searxng/VERSION

COPY /docker/uwsgi.ini /searxng/uwsgi.ini
COPY /docker/settings.yml /searxng/settings.yml
COPY /docker/startup.sh /searxng/startup.sh

RUN pip install --upgrade pip

# Add an unprivileged user and set directory permissions
RUN adduser --disabled-password --gecos "" searxng \
    && chown -R searxng:searxng /searxng \
    && chmod +x /searxng/startup.sh

USER searxng

# Install dependencies
RUN pip install --user --no-index --find-links=/searxng/wheels -r requirements.txt

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/searxng/startup.sh"]

EXPOSE 8080

STOPSIGNAL SIGTERM

# Image metadata
LABEL org.opencontainers.image.title="SearXNG"
LABEL org.opencontainers.image.description="SearXNG is a free internet metasearch engine which aggregates results from various search services and databases. Users are neither tracked nor profiled."
LABEL org.opencontainers.image.url="https://docs.searxng.org/"
LABEL org.opencontainers.image.licenses="AGPL-3.0-or-later"
LABEL org.opencontainers.image.source="https://github.com/TheSilkky/searxng-docker"
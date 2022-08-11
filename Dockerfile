ARG PYTHON_VERSION=3.10.6
ARG ALPINE_VERSION=3.16

####################################################################################################
## Builder image
####################################################################################################
FROM python:${PYTHON_VERSION}-alpine${ALPINE_VERSION} AS builder

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
    git \
    && pip install --no-cache-dir --upgrade pip wheel setuptools

# TODO: ADD --keep-git-dir=true https://github.com/searxng/searxng.git /searxng
ADD https://api.github.com/repos/searxng/searxng/git/refs/head /cachebreak
RUN git clone https://github.com/searxng/searxng.git /searxng

WORKDIR /searxng

RUN \
    # Create & install dependency wheels
    pip wheel --no-cache-dir --wheel-dir=/searxng/wheels -r requirements.txt \
    && pip install --no-cache-dir --no-index --find-links=/searxng/wheels -r requirements.txt \
    # Freeze SearXNG version
    && python3 -m searx.version freeze \
    # Compile Python modules
    && python3 -m compileall searx \
    # Compress static files
    && find /searxng/searx/static -a \( -name '*.html' -o -name '*.css' -o -name '*.js' \
    -o -name '*.svg' -o -name '*.ttf' -o -name '*.eot' \) \
    -type f -exec gzip -9 -k {} \+ -exec brotli --best {} \+

####################################################################################################
## Final image
####################################################################################################
FROM python:${PYTHON_VERSION}-alpine${ALPINE_VERSION}

RUN apk add --no-cache \
    ca-certificates \
    libxml2 \
    libxslt \
    openssl \
    uwsgi \
    uwsgi-python3 \
    tini \
    && pip install --no-cache-dir --upgrade pip setuptools

WORKDIR /searxng

COPY /src/ /searxng

# Add an unprivileged user and set directory permissions
RUN adduser --disabled-password --gecos "" --home /searxng searxng \
    && chown -R searxng:searxng /searxng \
    && chmod +x /searxng/config.py \
    && chmod +x /searxng/startup.sh

USER searxng

# Copy dependency wheels from builder stage
COPY --from=builder /searxng/requirements.txt /searxng/requirements.txt
COPY --from=builder /searxng/wheels/ /searxng/wheels
# Install dependencies
RUN pip install --no-cache-dir --user --no-index --find-links=/searxng/wheels -r requirements.txt

COPY --from=builder /searxng/searx/ /searxng/searx

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/searxng/startup.sh"]

EXPOSE 8080

STOPSIGNAL SIGTERM

LABEL org.opencontainers.image.title="SearXNG" \
      org.opencontainers.image.description="SearXNG is a free internet metasearch engine which aggregates results from various search services and databases. Users are neither tracked nor profiled." \
      org.opencontainers.image.url="https://docs.searxng.org/" \
      org.opencontainers.image.licenses="AGPL-3.0-or-later" \
      org.opencontainers.image.source="https://github.com/TheSilkky/searxng-docker"
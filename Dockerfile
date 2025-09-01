ARG WEBLATE_VERSION="latest"

FROM weblate/weblate:${WEBLATE_VERSION}

USER root
RUN chmod 1777 /tmp \
    && sed -i 's|\([0-9][0-9]*\)/\(healthz\)|\1\${WEBLATE_URL_PREFIX}/\2|' /app/bin/health_check
USER weblate

ARG WEBLATE_VERSION="latest"

FROM weblate/weblate:${WEBLATE_VERSION}

USER root
RUN mkdir -p /run && chown -R weblate:weblate /run
USER weblate

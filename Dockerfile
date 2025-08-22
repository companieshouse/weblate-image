ARG WEBLATE_VERSION="latest"

FROM weblate/weblate:${WEBLATE_VERSION}

USER root
RUN mkdir -p /run/supervisor.conf.d && chmod -R 1777 /run
USER weblate

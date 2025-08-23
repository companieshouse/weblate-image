ARG WEBLATE_VERSION="latest"

FROM weblate/weblate:${WEBLATE_VERSION}

USER root
RUN mkdir -p /tmp/run/supervisor.conf.d \
    && chmod -R 1777 /tmp/run \
    && ln -s /tmp/run /run
USER weblate

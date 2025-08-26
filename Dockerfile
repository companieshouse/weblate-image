ARG WEBLATE_VERSION="latest"

FROM weblate/weblate:${WEBLATE_VERSION}

USER root
RUN chmod 1777 /tmp
USER weblate

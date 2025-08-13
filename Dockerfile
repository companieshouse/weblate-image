ARG WEBLATE_VERSION="latest"

FROM weblate/weblate:${WEBLATE_VERSION}

ENV ENTRYPOINT_PATH=/usr/local/bin/docker-entrypoint.sh

USER root
COPY docker-entrypoint.sh $ENTRYPOINT_PATH
RUN chmod +x $ENTRYPOINT_PATH
USER weblate

ENTRYPOINT ["sh", "-c", "$ENTRYPOINT_PATH"]
CMD []

ARG WEBLATE_VERSION="latest"

FROM weblate/weblate:${WEBLATE_VERSION}

USER root
RUN chmod 1777 /tmp \
    && rm -f /etc/nginx/conf.d/default.conf

# Add our custom nginx config
COPY nginx-weblate.conf /etc/nginx/conf.d/weblate.conf

USER weblate

ARG WEBLATE_VERSION="latest"

FROM weblate/weblate:${WEBLATE_VERSION}

USER root
RUN chmod 1777 /tmp \
    && sed -zi 's|}\s*$|include /etc/nginx/conf.d/extra-locations.weblate;}|' /etc/nginx/sites-enabled/default

# Add our custom nginx config
COPY extra-locations.weblate /etc/nginx/conf.d/extra-locations.weblate

USER weblate

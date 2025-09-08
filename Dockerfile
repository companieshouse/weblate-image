ARG WEBLATE_VERSION="latest"

FROM weblate/weblate:${WEBLATE_VERSION}

USER root
# single quotes wanted in sed cmd
# hadolint ignore=SC2016
# Install pip into Weblate's venv if missing, then django-storages (to allow S3 support)
RUN chmod 1777 /tmp \
    && sed -i 's|\([0-9][0-9]*\)/\(healthz\)|\1${WEBLATE_URL_PREFIX}/\2|' /app/bin/health_check \
    && /app/venv/bin/python3 -m ensurepip \
    && /app/venv/bin/pip install --no-cache-dir --upgrade pip setuptools wheel \
    && /app/venv/bin/pip install --no-cache-dir django-storages[boto3]
USER weblate

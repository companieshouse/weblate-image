ARG WEBLATE_VERSION="latest"

FROM weblate/weblate:${WEBLATE_VERSION}

USER root
# Install pip into Weblate's venv, then django-storages (to allow S3 support)
# single quotes wanted in sed cmd
# hadolint ignore=SC2016
RUN chmod 1777 /tmp \
    && sed -i 's|\([0-9][0-9]*\)/\(healthz\)|\1${WEBLATE_URL_PREFIX}/\2|' /app/bin/health_check \
    && merged_path="$(bash -c 'su - weblate -c "echo \$PATH"':${PATH} | tr ':' '\n' | awk '!seen[$0]++' | paste -sd: -)" \
    && echo "export PATH=$merged_path" >> /etc/profile.d/custom_path.sh \
    && curl -sS -o get-pip.py https://bootstrap.pypa.io/get-pip.py \
    && /app/venv/bin/python3 get-pip.py \
    && /app/venv/bin/pip install --no-cache-dir --upgrade setuptools wheel  \
    && /app/venv/bin/pip install --no-cache-dir "django-storages[boto3]" \
    && mkdir -p /home/weblate/.ssh \
    && chmod 700 /home/weblate/.ssh \
    && ssh-keyscan github.com >> /home/weblate/.ssh/known_hosts \
    && chmod 644 /home/weblate/.ssh/known_hosts \
    && chown -R weblate:weblate /home/weblate/.ssh \
    && rm -rf /var/lib/apt/lists/*
USER weblate

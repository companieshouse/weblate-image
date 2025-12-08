#!/bin/bash

# 1st - run database init
# [run it only from the 1st weblate container ("celery-beat") and also protect
#  from running it more than once: the sql script is already idempotent
#  but this is a further protection]
if [[ ! -f /tmp/resource_initialised && $WEBLATE_SERVICE == "celery-beat" ]]; then
    /entrypoint/init_resources.sh
    touch /tmp/resource_initialised
fi

# 2nd - run any passed CMD (default or ECS override)
exec "$@"       # preserves PID 1 for real weblate-app ("/app/bin/start runserver") - for signal handling & shutdown

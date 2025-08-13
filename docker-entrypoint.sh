#!/bin/sh
set -e

case "$NODE_TYPE" in
  ""|"web")
    echo "Starting Weblate web server..."
    exec "$WEBSERVER_BIN" --host "$ALLOWED_HOSTS" --port "$PORT" "$@"
    ;;
  "worker"|"beat")
    echo "Starting Celery $NODE_TYPE..."
    exec celery -A weblate "$NODE_TYPE" -l info "$@"
    ;;
  *)
    echo "Unknown NODE_TYPE: $NODE_TYPE"
    echo "Valid values: web, worker, beat (or unset for web)"
    exit 1
    ;;
esac

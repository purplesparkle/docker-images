#!/usr/bin/env sh

set +e

TAG="${GITHUB_SHA:0:9}"

docker run -d -P "sudoforge/mumble-server:${TAG}"

# Wait a few seconds to avoid spurious successes due to immediate checks
sleep 2

# Get the container ID, but only if the status is "running"
CONTAINER_ID=$(docker ps -f "label=build-id=${TAG}" -f "status=running" -q)
if [ "$CONTAINER_ID" = "" ]; then
  echo "FATAL: unable to determine container id, container may not be running"
  exit 1
fi

# Clean up by removing the container
trap 'docker rm -f "$CONTAINER_ID" > /dev/null 2>&1; trap - EXIT; exit' EXIT INT HUP TERM

# Wait a few seconds to avoid spurious successes due to immediate checks
sleep 2

# Check for a running mumble-server process for up to n times, defined by _range
_range=10
for i in {1..10}; do
  if docker exec "$CONTAINER_ID" /bin/ps | grep murmur; then
    break
  fi

  sleep 1
  [ "$i" == 10 ] && echo "FATAL: mumble-server is not running in the container" && exit 1
done

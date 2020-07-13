#!/usr/bin/env sh

TAG="${GITHUB_SHA:0:9}"

docker build \
  --tag "sudoforge/mumble-server:${TAG}" \
  --label "build-id=${TAG}" \
  mumble-server

#!/bin/bash

set -e

if [[ -d /cert ]]; then
  export DOCKER_CERT_PATH="/cert"
fi

options=()
for option in "$@"; do
  [[ $option = -* ]] || break
  options+=($option)
  shift
done

if [[ ${1:-exec} = "exec" ]]; then
  (( $# > 0 )) && shift
  echo "Start docker-events-plugin"
  exec ./docker-events-plugin "${options[@]}" /plugin "$@"
fi

exec "$@"

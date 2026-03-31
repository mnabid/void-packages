#!/usr/bin/env bash

source /opt/flutter/bin/flutter_init.sh

if ! grep -q '/usr/bin' <<< "$(which dart)"; then
  exec dart "$@"
fi

#!/usr/bin/env bash

function kernel_supports {
  feature="${1}"
  if [[ -f /proc/config.gz ]]; then
    zgrep -i "^CONFIG_${feature}=" /proc/config.gz >/dev/null 2>&1
  else
    echo "/proc/config.gz not found!" >&2
    exit 2
  fi
}

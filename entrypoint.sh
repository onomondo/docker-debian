#!/usr/bin/env bash

set -euo pipefail
shopt -s nullglob globstar

for file in /etc/profile.d/*.sh; do
  if [ -r "${file}" ]; then
    # shellcheck source=/dev/null
    source "${file}"
  fi
done
unset file

for interface in $(get_all_interfaces); do
  sudo ethtool --offload "${interface}" rx off tx off >/dev/null 2>&1 || echo "Can't turn off checksum offloading for ${interface}"
done
unset interface

exec ${@}

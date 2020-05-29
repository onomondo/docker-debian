#!/usr/bin/env bash
set -o pipefail -o errexit -o errtrace -o nounset
shopt -s nullglob globstar
IFS=$'\n\t'

trap 'echo "Docker Entrypoint FAILED!" >&2' ERR

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

exec "${@}"

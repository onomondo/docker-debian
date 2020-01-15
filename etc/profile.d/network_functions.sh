#!/usr/bin/env bash

function get_interface_from_ip {
  interface=$(ip a | grep -B2 "${1}" | head -1 | awk '{print $2}' | sed 's/@.*$//g')
  echo "$interface"
}

function get_mac_from_ip {
  mac=$(ip a | grep -B1 "${1}" | head -1 | awk '{print $2}')
  echo "$mac"
}

function get_all_interfaces {
  interfaces=$(ip link | grep -v 'LOOPBACK' | grep -v '^\s' | awk '{ print $2 }' | sed 's/[@:].*$//g')
  echo "${interfaces}"
}

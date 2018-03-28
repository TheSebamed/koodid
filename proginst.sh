#!/bin/bash
set -x

apt-get update
programs=(bc nmap coreutils xmlstarlet)

for program in "${programs[@]}"; do
    if ! command -v "$program" > /dev/null 2>&1; then
        apt-get install "$program" -y
    fi
done

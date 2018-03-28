#!/bin/bash
# Andmed masina kohta
set -x

# Machine name
host=$(hostname -A)

# Private IP address
hostname=$(hostname -I| cut -d" " -f1)

# Public IP address
Pub_IP=$(dig +short myip.opendns.com @resolver1.opendns.com 2>/dev/null || curl ipinfo.io/ip 2>/dev/null )

#Debian Version
Deb_Version=$(cat /etc/debian_version)

# Tuumasid systeemis
core=$(cat /proc/cpuinfo | grep -c "processor")

# Memory
memory=$(
  LC_ALL=C free -h | awk '
    /^Mem/ {
      suffix = $2
      sub(/[0-9.]*/, "", suffix)
      printf "%.0f%sB\n", $2, suffix
    }'
)

#Disk Type
var=$(cat /sys/block/vda/queue/rotational 2>/dev/null || cat /sys/block/sda/queue/rotational 2>/dev/null)
dtype='nil'
if [ $var = 0 ]; then
        dtype=' SSD '
elif [ $var = 1 ]; then
        dtype=' HDD '
fi


# Hard disk space
space=$(df -hT /home | awk 'FNR == 2 {print $3 "B"}')

#Open ports
ports=$(cat /etc/firewall.conf | grep -e dport | awk -F "--dport" '{print $2}' | cut -d" " -f2 | sort -u | sort -n | tr '\n' ' ' 2>/dev/null)
openports=$(nmap localhost | grep "open " | cut -d "/" -f1 | tr '\n' ' ' || nmap "$host" | grep "open " | cut -d "/" -f1 | tr '\n' ' ' )


printf '| %s | %s | %s | %s | %s | %s | %s | %s | %s | %s |\n' "$host" "$hostname" "$Pub_IP" "$Deb_Version" " $core" "$memory" "$dtype" "$space"  "$ports" "$openports"> /tmp/vm_machines.txt
# exit



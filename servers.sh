#!/bin/bash
# Andmed masina kohta
set -x

# Machine name
host=$(hostname -A|cut -d" " -f1)

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

var=$(cat /sys/block/vda/queue/rotational 2>/dev/null || cat /sys/block/sda/queue/rotational 2>/dev/null)
dtype='nil'
if [ $var = 0 ]; then
        dtype=' SSD '
elif [ $var = 1 ]; then
        dtype=' HDD '
fi

#virtulization
var1=$(lsmod | grep kvm | awk 'NR==1{print $3}'  2>/dev/null)
vtype='nil'
if [ $var1 -gt 0 ]; then
        vtype='yes' 
else
    vtype='no'
fi



# Hard disk space
space=$(df -hT /home | awk 'FNR == 2 {print $3 "B"}')

#Full Space
#fullspace=$(cat /sys/block/sda/subsystem/sda*/size | paste -sd+ -| bc | awk '{ s=$1/(1024^2)  ;} END { printf "%dGB\n",s}')
fullspace=$(cat /proc/partitions  | awk '/sd[a-z]$/{printf "%s %8.2f GB\n", $NF, $(NF-1) / 1024 / 1024}' | cut -d " " -f4 | awk '{printf("%d\n",$1 + 0.5)}' | paste -sd+ | bc)

printf '| %s | %s | %s | %s | %s | %s | %s | %s | %s | %s |\n' "$host" "$hostname" "$Pub_IP" "$vtype" "$Deb_Version" " $core" "$memory" "$dtype" "$space" "$fullspace"  > /tmp/phy_machines.txt

# exit



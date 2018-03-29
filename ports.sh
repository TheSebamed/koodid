#!/bin/bash
set -x
THE FOLLOWING SCRIPT IS NOT REQUIRED FOR THIS JOB. IT IS DONE VIA virtualservers.sh and servers.sh
# Machine name
host=$(hostname -A | cut -d " " -f1)

#Open Ports (External Network) Choose which you want, comment it out.
#openports=$(lsof -Pnl +M -i4 | grep *: | grep LISTEN | cut -d ":" -f2 | grep -o '[0-9]*' | sort -u | sort -n | tr '\n' ' ' )
openports=$(nmap localhost | grep "open " | cut -d "/" -f1 | tr '\n' ' ' || nmap "$host" | grep "open " | cut -d "/" -f1 | tr '\n' ' ' )
#openports=$(ss -ltu -n | grep *: | cut -d ":" -f2 | cut -d " " -f1 |sort -u | sort -n| tr '\n' ' '

printf '| %s | %s |\n' "$host" "$openports" > /tmp/openports.txt

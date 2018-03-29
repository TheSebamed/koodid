#!/bin/bash
#set -x
THE FOLLOWING SCRIPT IS NOT REQUIRED FOR THIS JOB. IT IS DONE VIA virtualservers.sh and servers.sh
# Location where bash scripts are located.
openports=/opt/wiki_scripts/ports.sh

# Hosts where we will ssh into.
Hosts=( vmfarm1.stacc.ee barclay.stacc.ee p12.stacc.ee maximus.stacc.ee backup.stacc.ee firefly.stacc.ee accountant.stacc.ee 10.6.6.90 icinga.stacc.ee ldap.stacc.ee mail.stacc.ee openvpn.stacc.ee dns.stacc.ee redmine.stacc.ee owncloud.stacc.ee www.stacc.ee git.stacc.ee elasticsearch.stacc.ee jenkins.stacc.ee egcut.stacc.ee demo.stacc.ee client.stacc.ee live.stacc.ee 10.6.6.92 10.6.6.93 )

SendFiles () {
        local host="$1"
        ssh "root@$host" 'bash -s' <"$openports"
        ssh "root@$host" cat /tmp/openports.txt
}

printf 'h2. UT firewall \n\n|_.Name|_.Ports|\n' > openports.txt

# Save the following data to the phy_machine file.
for host in "${Hosts[@]}"; do
        SendFiles "$host"
done >>/opt/wiki_scripts/openports.txt

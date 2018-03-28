#!/bin/bash
set -x
#Delete files on remote host.

# Hosts where we will ssh into.
Phy_Hosts=( vmfarm1.stacc.ee barclay.stacc.ee p12.stacc.ee maximus.stacc.ee backup.stacc.ee firefly.stacc.ee accountant.stacc.ee 10.6.6.90 )
Vm_Hosts=( icinga.stacc.ee ldap.stacc.ee mail.stacc.ee openvpn.stacc.ee dns.stacc.ee redmine.stacc.ee owncloud.stacc.ee www.stacc.ee git.stacc.ee elasticsearch.stacc.ee jenkins.stacc.ee egcut.stacc.ee demo.stacc.ee client.stacc.ee live.stacc.ee 10.6.6.92 10.6.6.93 ) 

DeleteFiles () {
        local host="$1"
        ssh "root@$host" rm -f /tmp/phy_machines.txt
}

DeleteFiles1 () {
        local host1="$1"
        ssh "root@$host1" rm -f /tmp/vm_machines.txt
}


# Deleting hosts in Loop (goes through all the hosts above) 
for host in "${Phy_Hosts[@]}"; do
        DeleteFiles "$host"
done

# Save the following data to the vm_machine file.
for host1 in "${Vm_Hosts[@]}"; do
        DeleteFiles1 "$host1"
done

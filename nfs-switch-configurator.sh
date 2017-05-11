#!/bin/bash

host=`vd print $1 | egrep "item|0.ip.address|0.ip.network|0.ip.gateway" | sed 's/interface.*= //g' | sed ':a $!N;s/\n\t17/ 17/;ta P;D' | sed ':a $!N;s/\n\tasset.desc = / = /;ta P;D' | sed 's/item //g' | sed 's/.me.com//g' | sed 's/\// /g' | awk '{print $1}'` # while read host ip gateway network netmask; do
ip=`vd print $1 | egrep "item|0.ip.address|0.ip.network|0.ip.gateway" | sed 's/interface.*= //g' | sed ':a $!N;s/\n\t17/ 17/;ta P;D' | sed ':a $!N;s/\n\tasset.desc = / = /;ta P;D' | sed 's/item //g' | sed 's/.me.com//g' | sed 's/\// /g' | awk '{print $2}'`
gateway=`vd print $1 | egrep "item|0.ip.address|0.ip.network|0.ip.gateway" | sed 's/interface.*= //g' | sed ':a $!N;s/\n\t17/ 17/;ta P;D' | sed ':a $!N;s/\n\tasset.desc = / = /;ta P;D' | sed 's/item //g' | sed 's/.me.com//g' | sed 's/\// /g' | awk '{print $3}'`
network=`vd print $1 | egrep "item|0.ip.address|0.ip.network|0.ip.gateway" | sed 's/interface.*= //g' | sed ':a $!N;s/\n\t17/ 17/;ta P;D' | sed ':a $!N;s/\n\tasset.desc = / = /;ta P;D' | sed 's/item //g' | sed 's/.me.com//g' | sed 's/\// /g' | awk '{print $4}'`
netmask=`vd print $1 | egrep "item|0.ip.address|0.ip.network|0.ip.gateway" | sed 's/interface.*= //g' | sed ':a $!N;s/\n\t17/ 17/;ta P;D' | sed ':a $!N;s/\n\tasset.desc = / = /;ta P;D' | sed 's/item //g' | sed 's/.me.com//g' | sed 's/\// /g' | awk '{print $5}'`

echo $host
echo $ip
echo $gateway
echo $network
echo $netmask

if [[ $(echo $host | sed -r 's/^.{16}//') == 1 ]];
then echo "!
! _1_admin -- dynamic configurations sourced from verdad
!
hostname $host
ip domain-name apple.com
no feature telnet
no telnet server enable
cfs eth distribute
feature interface-vlan
feature lacp
feature vpc
default spanning-tree mode
clock timezone UTC 0 0

vrf context keepalive
vrf context management
  ip route 0.0.0.0/0 $gateway

vpc domain 2

logging level interface-vlan 2
role name limited-access
  rule 1 permit command clear counters interface all ; vlan *
username icmrun password 5 \$1\$b2nVKrSx\$lawg8REhU6o2Tq2ahW48w.  role network-operator
username icmrun role limited-access
username icmbuild password 5 \$1\$rtvOeziI\$kZRxQCslHu2YCrkfutgN2/  role network-operator
username icmbuild role limited-access
username isgdc password 5 \$1\$U8EtBxtM\$rDBJWx2ItStryBPZIlC5U/  role network-operator
username isgdc role limited-access
username admin password 5 \$1\$bqLj/NZq\$71eeAyKtybG88fVYNIFEs0  role network-admin
username storage password 5 \$1\$RlG8CiVF\$cheZ9On28DoozZIoTYyub.  role network-admin
username storage sshkey ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKsc5we0EnwIbQsXMCKzjVJCTsS3HoWLsGCHvok3cQpDJGXNISWlhkS3kr6VaT1MTMml0PdXRgPt1VVRiwU2QO9cXgfQYZWuK/EUQ5Yi8E+kdQGUD0y2KddNeeEqkDolR8cCGrGO7vd6mTU+pENCdkQrmsMuvAFyjdHPItzHV1ftzAQNXt4i2OPhQyRFDHydPseBQ2j4KJn5O456fgH5wonY5IG8sjaHY4AEoPhW9INwGxWYsTkS59qfpyTW6JC4EbX+SD0WKBMZzNtfTiDqCBcNgd28TlauofCl597K4diEIt6ZIpeCv11OhlxC+cSlr7l13+OPuGjL9aLGr5TKgT root@icm-adminm
username nagios password 5 \$1\$/u0NFEXw\$f7NxOYA8H3cY7JdQyETnt/  role network-operator
no password strength-check
ip domain-lookup
snmp-server source-interface trap mgmt0
snmp-server enable traps callhome event-notify
snmp-server enable traps callhome smtp-send-fail
snmp-server enable traps cfs state-change-notif
snmp-server enable traps snmp authentication

vlan 20

interface mgmt0
  ip add $ip/$netmask

interface Vlan1

interface Ethernet1/1
  switchport access vlan 20
  channel-group 11 mode active

interface Ethernet1/2
  switchport access vlan 20
  channel-group 12 mode active

interface Ethernet1/3
  switchport access vlan 20
  channel-group 13 mode active

interface Ethernet1/4
  switchport access vlan 20
  channel-group 14 mode active

interface Ethernet1/5
  switchport access vlan 20
  channel-group 15 mode active

interface Ethernet1/6
  switchport access vlan 20
  channel-group 15 mode active

interface Ethernet1/7
  switchport access vlan 20
  channel-group 16 mode active

interface Ethernet1/8
  switchport access vlan 20
  channel-group 16 mode active

interface Ethernet1/9
  switchport access vlan 20
  channel-group 17 mode active

interface Ethernet1/10
  switchport access vlan 20
  channel-group 17 mode active

interface Ethernet1/11
  switchport access vlan 20
  channel-group 18 mode active

interface Ethernet1/12
  switchport access vlan 20
  channel-group 18 mode active

interface Ethernet1/13
  switchport access vlan 20
  channel-group 19 mode active

interface Ethernet1/14
  switchport access vlan 20
  channel-group 19 mode active

!
interface Ethernet1/25
  switchport access vlan 20
  channel-group 20 mode active

interface Ethernet1/26
  switchport access vlan 20
  channel-group 21 mode active

interface Ethernet1/27
  switchport access vlan 20
  channel-group 22 mode active

interface Ethernet1/28
  switchport access vlan 20
  channel-group 23 mode active

interface Ethernet1/29
  switchport access vlan 20
  channel-group 24 mode active

interface Ethernet1/30
  switchport access vlan 20
  channel-group 24 mode active

interface Ethernet1/31
  switchport access vlan 20
  channel-group 25 mode active

interface Ethernet1/32
  switchport access vlan 20
  channel-group 25 mode active

interface Ethernet1/33
  switchport access vlan 20
  channel-group 26 mode active

interface Ethernet1/34
  switchport access vlan 20
  channel-group 26 mode active

interface Ethernet1/35
  switchport access vlan 20
  channel-group 27 mode active

interface Ethernet1/36
  switchport access vlan 20
  channel-group 27 mode active

interface Ethernet1/37
  switchport access vlan 20
  channel-group 28 mode active

interface Ethernet1/38
  switchport access vlan 20
  channel-group 28 mode active


interface Ethernet1/43
  description switchname-gw2|Eth1/43-44
  switchport mode trunk
  switchport trunk allowed vlan 20
  channel-group 999 mode active

interface Ethernet1/44
  description switchname-gw2|Eth1/43-44
  switchport mode trunk
  switchport trunk allowed vlan 20
  channel-group 999 mode active

vpc domain 2
  role priority 1
  peer-keepalive destination 10.140.0.254 source 10.140.0.253 vrf keepalive
  peer-gateway

interface port-channel999
  switchport mode trunk
  vpc peer-link
  switchport trunk allowed vlan 20
  spanning-tree port type network
  no negotiate auto

interface Ethernet1/42
  description switchname-gw2|Eth1/42
  no switchport
  vrf member keepalive
  no ip redirects
  ip address 10.140.0.253/30


interface Eth1/1
  desc filer 1 - e0d
interface Eth1/2
  desc filer 1 - e0f
interface Eth1/3
  desc filer 2 - e4a
interface Eth1/4
  desc filer 2 - e4b
interface Eth1/5
  desc MS  1 - port 1
interface Eth1/6
  desc MS  1 - port 3
interface Eth1/7
  desc MS  2 - port 1
interface Eth1/8
  desc MS  2 - port 3
interface Eth1/9
  desc MS  3 - port 1
interface Eth1/10
  desc MS  3 - port 3
interface Eth1/11
  desc MS  4 - port 1
interface Eth1/12
  desc MS  4 - port 3
interface Eth1/13
  desc MS  5 - port 1
interface Eth1/14
  desc MS  5 - port 3
!
interface Eth1/25
  desc filer 1 - e0d
interface Eth1/26
  desc filer 1 - e0f
interface Eth1/27
  desc filer 2 - e4a
interface Eth1/28
  desc filer 2 - e4b
interface Eth1/29
  desc MS  1 - port 1
interface Eth1/30
  desc MS  1 - port 3
interface Eth1/31
  desc MS  2 - port 1
interface Eth1/32
  desc MS  2 - port 3
interface Eth1/33
  desc MS  3 - port 1
interface Eth1/34
  desc MS  3 - port 3
interface Eth1/35
  desc MS  4 - port 1
interface Eth1/36
  desc MS  4 - port 3
interface Eth1/37
  desc MS  5 - port 1
interface Eth1/38
  desc MS  5 - port 3
!
interface Eth1/42
  desc switch 2 - Eth1/42
interface Eth1/43
  desc switch 2 - Eth1/43
interface Eth1/44
  desc switch 2 - Eth1/44


interface port-channel11
  desc filer 1 - vif X
  vpc 11

interface port-channel12
  desc filer 1 - vif X
  vpc 12

interface port-channel13
  desc filer 2 - vif X
  vpc 13

interface port-channel14
  desc filer 2 - vif X
  vpc 14

interface port-channel15
  desc MS  1
  vpc 15

interface port-channel16
  desc MS  2
  vpc 16

interface port-channel17
  desc MS  3
  vpc 17

interface port-channel18
  desc MS  4
  vpc 18

interface port-channel19
  desc MS  5
  vpc 19
!
interface port-channel20
  desc filer 1 - vif X
  vpc 20

interface port-channel21
  desc filer 1 - vif X
  vpc 21

interface port-channel22
  desc filer 2 - vif X
  vpc 22

interface port-channel23
  desc filer 2 - vif X
  vpc 23

interface port-channel24
  desc MS  1
  vpc 24

interface port-channel25
  desc MS  2
  vpc 25

interface port-channel26
  desc MS  3
  vpc 26

interface port-channel27
  desc MS  4
  vpc 27

interface port-channel28
  desc MS  5
  vpc 28

end

copy running-config startup-config

end"
exit

else echo "!
! _1_admin -- dynamic configurations sourced from verdad
!
hostname $host
ip domain-name apple.com
no feature telnet
no telnet server enable
cfs eth distribute
feature interface-vlan
feature lacp
feature vpc
default spanning-tree mode
clock timezone UTC 0 0

vrf context keepalive
vrf context management
  ip route 0.0.0.0/0 $gateway

vpc domain 2

logging level interface-vlan 2
role name limited-access
  rule 1 permit command clear counters interface all ; vlan *
username icmrun password 5 \$1\$b2nVKrSx\$lawg8REhU6o2Tq2ahW48w.  role network-operator
username icmrun role limited-access
username icmbuild password 5 \$1\$rtvOeziI\$kZRxQCslHu2YCrkfutgN2/  role network-operator
username icmbuild role limited-access
username isgdc password 5 \$1\$U8EtBxtM\$rDBJWx2ItStryBPZIlC5U/  role network-operator
username isgdc role limited-access
username admin password 5 \$1\$bqLj/NZq\$71eeAyKtybG88fVYNIFEs0  role network-admin
username storage password 5 \$1\$RlG8CiVF\$cheZ9On28DoozZIoTYyub.  role network-admin
username storage sshkey ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKsc5we0EnwIbQsXMCKzjVJCTsS3HoWLsGCHvok3cQpDJGXNISWlhkS3kr6VaT1MTMml0PdXRgPt1VVRiwU2QO9cXgfQYZWuK/EUQ5Yi8E+kdQGUD0y2KddNeeEqkDolR8cCGrGO7vd6mTU+pENCdkQrmsMuvAFyjdHPItzHV1ftzAQNXt4i2OPhQyRFDHydPseBQ2j4KJn5O456fgH5wonY5IG8sjaHY4AEoPhW9INwGxWYsTkS59qfpyTW6JC4EbX+SD0WKBMZzNtfTiDqCBcNgd28TlauofCl597K4diEIt6ZIpeCv11OhlxC+cSlr7l13+OPuGjL9aLGr5TKgT root@icm-adminm
username nagios password 5 \$1\$/u0NFEXw\$f7NxOYA8H3cY7JdQyETnt/  role network-operator
no password strength-check
ip domain-lookup

snmp-server source-interface trap mgmt0
snmp-server enable traps callhome event-notify
snmp-server enable traps callhome smtp-send-fail
snmp-server enable traps cfs state-change-notif
snmp-server enable traps snmp authentication

vlan 20

interface mgmt0
  ip add $ip/$netmask

interface Vlan1

interface Ethernet1/1
  switchport access vlan 20
  channel-group 11 mode active

interface Ethernet1/2
  switchport access vlan 20
  channel-group 12 mode active

interface Ethernet1/3
  switchport access vlan 20
  channel-group 13 mode active

interface Ethernet1/4
  switchport access vlan 20
  channel-group 14 mode active

interface Ethernet1/5
  switchport access vlan 20
  channel-group 15 mode active

interface Ethernet1/6
  switchport access vlan 20
  channel-group 15 mode active

interface Ethernet1/7
  switchport access vlan 20
  channel-group 16 mode active

interface Ethernet1/8
  switchport access vlan 20
  channel-group 16 mode active

interface Ethernet1/9
  switchport access vlan 20
  channel-group 17 mode active

interface Ethernet1/10
  switchport access vlan 20
  channel-group 17 mode active

interface Ethernet1/11
  switchport access vlan 20
  channel-group 18 mode active

interface Ethernet1/12
  switchport access vlan 20
  channel-group 18 mode active

interface Ethernet1/13
  switchport access vlan 20
  channel-group 19 mode active

interface Ethernet1/14
  switchport access vlan 20
  channel-group 19 mode active

!
interface Ethernet1/25
  switchport access vlan 20
  channel-group 20 mode active

interface Ethernet1/26
  switchport access vlan 20
  channel-group 21 mode active

interface Ethernet1/27
  switchport access vlan 20
  channel-group 22 mode active

interface Ethernet1/28
  switchport access vlan 20
  channel-group 23 mode active

interface Ethernet1/29
  switchport access vlan 20
  channel-group 24 mode active

interface Ethernet1/30
  switchport access vlan 20
  channel-group 24 mode active

interface Ethernet1/31
  switchport access vlan 20
  channel-group 25 mode active

interface Ethernet1/32
  switchport access vlan 20
  channel-group 25 mode active

interface Ethernet1/33
  switchport access vlan 20
  channel-group 26 mode active

interface Ethernet1/34
  switchport access vlan 20
  channel-group 26 mode active

interface Ethernet1/35
  switchport access vlan 20
  channel-group 27 mode active

interface Ethernet1/36
  switchport access vlan 20
  channel-group 27 mode active

interface Ethernet1/37
  switchport access vlan 20
  channel-group 28 mode active

interface Ethernet1/38
  switchport access vlan 20
  channel-group 28 mode active


interface Ethernet1/43
  description switchname-gw2|Eth1/43-44
  switchport mode trunk
  switchport trunk allowed vlan 20
  channel-group 999 mode active

interface Ethernet1/44
  description switchname-gw2|Eth1/43-44
  switchport mode trunk
  switchport trunk allowed vlan 20
  channel-group 999 mode active

vpc domain 2
  peer-keepalive destination 10.140.0.253 source 10.140.0.254 vrf keepalive
  peer-gateway

interface port-channel999
  switchport mode trunk
  vpc peer-link
  switchport trunk allowed vlan 20
  spanning-tree port type network
  no negotiate auto

interface Ethernet1/42
  description switchname-gw2|Eth1/42
  no switchport
  vrf member keepalive
  no ip redirects
  ip address 10.140.0.254/30

interface Eth1/1
  desc filer 1 - e4a
interface Eth1/2
  desc filer 1 - e4b
interface Eth1/3
  desc filer 2 - e0d
interface Eth1/4
  desc filer 2 - e0f
interface Eth1/5
  desc MS  1 - port 2
interface Eth1/6
  desc MS  1 - port 4
interface Eth1/7
  desc MS  2 - port 2
interface Eth1/8
  desc MS  2 - port 4
interface Eth1/9
  desc MS  3 - port 2
interface Eth1/10
  desc MS  3 - port 4
interface Eth1/11
  desc MS  4 - port 2
interface Eth1/12
  desc MS  4 - port 4
interface Eth1/13
  desc MS  5 - port 2
interface Eth1/14
  desc MS  5 - port 4

!
interface Eth1/25
  desc filer 1 - e4a
interface Eth1/26
  desc filer 1 - e4b
interface Eth1/27
  desc filer 2 - e0d
interface Eth1/28
  desc filer 2 - e0f
interface Eth1/29
  desc MS  1 - port 2
interface Eth1/30
  desc MS  1 - port 4
interface Eth1/31
  desc MS  2 - port 2
interface Eth1/32
  desc MS  2 - port 4
interface Eth1/33
  desc MS  3 - port 2
interface Eth1/34
  desc MS  3 - port 4
interface Eth1/35
  desc MS  4 - port 2
interface Eth1/36
  desc MS  4 - port 4
interface Eth1/37
  desc MS  5 - port 2
interface Eth1/38
  desc MS  5 - port 4

interface Eth1/42
  desc switch 1 - Eth1/42
interface Eth1/43
  desc switch 1 - Eth1/43
interface Eth1/44
  desc switch 1 - Eth1/44

interface Po11
  desc filer 1 - vif X
  vpc 11

interface Po12
  desc filer 1 - vif X
  vpc 12

interface Po13
  desc filer 2 - vif X
  vpc 13

interface Po14
  desc filer 2 - vif X
  vpc 14

interface Po15
  desc MS  1
  vpc 15

interface Po16
  desc MS  2
  vpc 16

interface Po17
  desc MS  3
  vpc 17

interface Po18
  desc MS  4
  vpc 18
interface Po19
  desc MS  5
  vpc 19

!

interface Po20
  desc filer 1 - vif X
  vpc 20

interface Po21
  desc filer 1 - vif X
  vpc 21

interface Po22
  desc filer 2 - vif X
  vpc 22

interface Po23
  desc filer 2 - vif X
  vpc 23

interface Po24
  desc MS  1
  vpc 24

interface Po25
  desc MS  2
  vpc 25

interface Po26
  desc MS  3
  vpc 26

interface Po27
  desc MS  4
  vpc 27

interface Po28
  desc MS  5
  vpc 28

end

copy running-config startup-config

end"
fi

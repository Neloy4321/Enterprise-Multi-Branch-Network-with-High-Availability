# BR1-R1 | RouterOS 7.21.4 | Area 10 branch edge
/system identity set name=BR1-R1
/interface vlan add interface=ether1 name=vlan110-USERS vlan-id=110
/ip address
add address=172.16.110.1/24 interface=vlan110-USERS
add address=10.0.1.2/30 interface=ether2 comment="To HQ-R1"
add address=10.0.3.2/30 interface=ether3 comment="To HQ-R2"
/ip pool add name=pool-BR1 ranges=172.16.110.100-172.16.110.200
/ip dhcp-server add name=dhcp-BR1 interface=vlan110-USERS address-pool=pool-BR1 disabled=no
/ip dhcp-server network add address=172.16.110.0/24 gateway=172.16.110.1 dns-server=1.1.1.1,8.8.8.8
/routing ospf instance
add name=ospf-br1 router-id=3.3.3.3 version=2
/routing ospf area
add instance=ospf-br1 name=area0 area-id=0.0.0.0
add instance=ospf-br1 name=area10 area-id=0.0.0.10 type=stub
/routing ospf interface-template
add area=area0 interfaces=ether2,ether3 type=ptp
add area=area10 interfaces=vlan110-USERS passive=yes
/ip firewall address-list
add list=admin-subnets address=172.16.30.0/24
add list=admin-subnets address=172.16.50.0/24
/ip firewall filter
add chain=input connection-state=established,related,untracked action=accept
add chain=input connection-state=invalid action=drop
add chain=input in-interface=ether2 protocol=ospf action=accept
add chain=input in-interface=ether3 protocol=ospf action=accept
add chain=input in-interface=vlan110-USERS protocol=udp dst-port=67 action=accept
add chain=input in-interface=vlan110-USERS protocol=icmp action=accept
add chain=input protocol=tcp dst-port=22 src-address-list=admin-subnets action=accept
add chain=input action=drop comment="Default drop to branch router"
add chain=forward connection-state=established,related,untracked action=accept
add chain=forward connection-state=invalid action=drop
add chain=forward action=accept src-address=172.16.0.0/16
add chain=forward action=drop comment="No unsolicited external transit"
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set www-ssl disabled=yes
set api disabled=yes
set api-ssl disabled=yes
set winbox disabled=yes
set ssh disabled=no port=22 address=172.16.30.0/24,172.16.50.0/24
/ip neighbor discovery-settings set discover-interface-list=none
/tool mac-server set allowed-interface-list=none
/tool mac-server mac-winbox set allowed-interface-list=none
/system logging action
add name=remote-syslog target=remote remote=172.16.40.201 remote-log-format=syslog
# Include informational events from the original lab logging policy.
/system logging add action=remote-syslog topics=info
/system logging add action=remote-syslog topics=warning
/system logging add action=remote-syslog topics=error
/system ntp client set enabled=yes
/system ntp client servers add address=172.16.40.201

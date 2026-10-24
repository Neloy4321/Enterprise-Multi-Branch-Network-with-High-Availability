# HQ-R1 | RouterOS 7.21.4 | HQ gateway and OSPF area 0
# Source of truth: lab/Enterprise_Multi_Branch_Network.unl and docs/REBUILD-AND-ACCEPTANCE.md
# Import into a clean CHR instance. No passwords or user secrets are stored here.
/system identity set name=HQ-R1

# Each gateway sees all HQ VLANs through the core-switch trunk on ether1.
/interface vlan
add interface=ether1 name=vlan10-HR vlan-id=10
add interface=ether1 name=vlan20-SALES vlan-id=20
add interface=ether1 name=vlan30-IT vlan-id=30
add interface=ether1 name=vlan40-SERVER vlan-id=40
add interface=ether1 name=vlan50-MGMT vlan-id=50

/interface vrrp
add interface=vlan10-HR name=vrrp10 vrid=10 priority=150 version=3 preemption-mode=yes
add interface=vlan20-SALES name=vrrp20 vrid=20 priority=150 version=3 preemption-mode=yes
add interface=vlan30-IT name=vrrp30 vrid=30 priority=150 version=3 preemption-mode=yes
add interface=vlan40-SERVER name=vrrp40 vrid=40 priority=150 version=3 preemption-mode=yes
add interface=vlan50-MGMT name=vrrp50 vrid=50 priority=150 version=3 preemption-mode=yes

/ip address
add address=172.16.10.1/24 interface=vlan10-HR
add address=172.16.20.1/24 interface=vlan20-SALES
add address=172.16.30.1/24 interface=vlan30-IT
add address=172.16.40.1/24 interface=vlan40-SERVER
add address=172.16.50.1/24 interface=vlan50-MGMT
add address=10.0.1.1/30 interface=ether2 comment="Transit to BR1-R1 ether2"
add address=10.0.2.1/30 interface=ether3 comment="Transit to BR2-R1 ether2"
add address=172.16.10.254/32 interface=vrrp10 comment="Shared VLAN 10 gateway"
add address=172.16.20.254/32 interface=vrrp20 comment="Shared VLAN 20 gateway"
add address=172.16.30.254/32 interface=vrrp30 comment="Shared VLAN 30 gateway"
add address=172.16.40.254/32 interface=vrrp40 comment="Shared VLAN 40 gateway"
add address=172.16.50.254/32 interface=vrrp50 comment="Shared VLAN 50 gateway"

# Both HQ routers use independent DHCP-assigned addresses from EVE-NG pnet0.
# Failover restores reachability, not established Internet TCP sessions.
/ip dhcp-client add interface=ether4 add-default-route=yes use-peer-dns=no use-peer-ntp=no disabled=no
/ip dns set servers=1.1.1.1,8.8.8.8

# Split DHCP scopes; the two servers do not replicate leases.
/ip pool
add name=pool-HR ranges=172.16.10.100-172.16.10.180
add name=pool-SALES ranges=172.16.20.100-172.16.20.180
add name=pool-IT ranges=172.16.30.100-172.16.30.180
add name=pool-MGMT ranges=172.16.50.100-172.16.50.180
/ip dhcp-server
add name=dhcp-HR interface=vlan10-HR address-pool=pool-HR lease-time=12h disabled=no
add name=dhcp-SALES interface=vlan20-SALES address-pool=pool-SALES lease-time=12h disabled=no
add name=dhcp-IT interface=vlan30-IT address-pool=pool-IT lease-time=12h disabled=no
add name=dhcp-MGMT interface=vlan50-MGMT address-pool=pool-MGMT lease-time=12h disabled=no
/ip dhcp-server network
add address=172.16.10.0/24 gateway=172.16.10.254 dns-server=1.1.1.1,8.8.8.8
add address=172.16.20.0/24 gateway=172.16.20.254 dns-server=1.1.1.1,8.8.8.8
add address=172.16.30.0/24 gateway=172.16.30.254 dns-server=1.1.1.1,8.8.8.8
add address=172.16.50.0/24 gateway=172.16.50.254 dns-server=1.1.1.1,8.8.8.8

# OSPF neighbors share area 0 on all four physical transit links.
/routing ospf instance
add name=ospf-hq router-id=1.1.1.1 version=2 originate-default=if-installed
/routing ospf area
add instance=ospf-hq name=area0 area-id=0.0.0.0
/routing ospf interface-template
add area=area0 interfaces=ether2,ether3 type=ptp
add area=area0 interfaces=vlan10-HR passive=yes
add area=area0 interfaces=vlan20-SALES passive=yes
add area=area0 interfaces=vlan30-IT passive=yes
add area=area0 interfaces=vlan40-SERVER passive=yes
add area=area0 interfaces=vlan50-MGMT passive=yes

/interface list
add name=HQ-LAN
add name=OSPF-TRANSIT
/interface list member
add list=HQ-LAN interface=vlan10-HR
add list=HQ-LAN interface=vlan20-SALES
add list=HQ-LAN interface=vlan30-IT
add list=HQ-LAN interface=vlan40-SERVER
add list=HQ-LAN interface=vlan50-MGMT
add list=OSPF-TRANSIT interface=ether2
add list=OSPF-TRANSIT interface=ether3

/ip firewall address-list
add list=admin-subnets address=172.16.30.0/24 comment="IT admins"
add list=admin-subnets address=172.16.50.0/24 comment="Management subnet"

# NAT must be present on BOTH routers to restore new Internet sessions after takeover.
/ip firewall nat
add chain=srcnat src-address=172.16.0.0/16 out-interface=ether4 action=masquerade comment="HQ Internet egress"

# Explicit router input protections. Allow OSPF/VRRP control traffic before drop.
/ip firewall filter
add chain=input action=accept connection-state=established,related,untracked comment="Established input"
add chain=input action=drop connection-state=invalid comment="Drop invalid input"
add chain=input action=accept protocol=udp in-interface=ether4 src-port=67 dst-port=68 comment="WAN DHCP reply"
add chain=input action=accept protocol=ospf in-interface-list=OSPF-TRANSIT comment="OSPF transit neighbors"
add chain=input action=accept protocol=112 in-interface-list=HQ-LAN comment="VRRP advertisements"
add chain=input action=accept protocol=udp dst-port=67 in-interface-list=HQ-LAN comment="HQ DHCP requests"
add chain=input action=accept protocol=icmp in-interface-list=HQ-LAN comment="HQ diagnostics"
add chain=input action=accept protocol=icmp in-interface-list=OSPF-TRANSIT comment="WAN link diagnostics"
add chain=input action=accept protocol=tcp dst-port=22 src-address-list=admin-subnets comment="SSH from IT and management"
add chain=input action=drop comment="Default drop to router"

# Site policy: HR cannot reach IT; branch clients cannot reach management.
# Other RFC1918 inter-site traffic is permitted as this lab has no full application ACL matrix.
add chain=forward action=accept connection-state=established,related,untracked comment="Established transit"
add chain=forward action=drop connection-state=invalid comment="Drop invalid transit"
add chain=forward action=drop src-address=172.16.10.0/24 dst-address=172.16.30.0/24 comment="HR to IT denied"
add chain=forward action=drop src-address=172.16.110.0/24 dst-address=172.16.50.0/24 comment="BR1 to management denied"
add chain=forward action=drop src-address=172.16.210.0/24 dst-address=172.16.50.0/24 comment="BR2 to management denied"
add chain=forward action=drop in-interface=ether4 connection-state=new comment="Unsolicited WAN ingress"
add chain=forward action=accept src-address=172.16.0.0/16 comment="Approved corporate source space"
add chain=forward action=drop comment="Default deny other forwarded traffic"

# Disable unneeded management services. SSH passwords/users are provisioned locally.
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

# 172.16.40.201 is an external Linux service VM, NOT the current VPCS placeholder.
/system logging action
add name=remote-syslog target=remote remote=172.16.40.201 remote-log-format=syslog
/system logging
# Include informational events from the original lab logging policy.
add action=remote-syslog topics=info
add action=remote-syslog topics=warning
add action=remote-syslog topics=error
add action=remote-syslog topics=critical
/system ntp client set enabled=yes
/system ntp client servers add address=172.16.40.201

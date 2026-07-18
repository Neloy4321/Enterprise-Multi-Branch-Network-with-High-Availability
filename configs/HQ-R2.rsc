#-------------------------------------------------------------------------
# Device: HQ-R2 (VRRP Backup)
# Operating System: RouterOS v7.21.4
#-------------------------------------------------------------------------

/system identity set name=HQ-R2

# Layer 2 VLAN Interface Creation (All on ether1 to CORE-SW2)
/interface vlan
add interface=ether1 name=vlan10-HR vlan-id=10
add interface=ether1 name=vlan20-SALES vlan-id=20
add interface=ether1 name=vlan30-IT vlan-id=30
add interface=ether1 name=vlan40-SERVER vlan-id=40
add interface=ether1 name=vlan50-MGMT vlan-id=50

# VRRP High Availability Configuration (Priority 100 = Backup)
/interface vrrp
add interface=vlan10-HR name=vrrp10 priority=100 vrid=10
add interface=vlan20-SALES name=vrrp20 priority=100 vrid=20
add interface=vlan30-IT name=vrrp30 priority=100 vrid=30
add interface=vlan40-SERVER name=vrrp40 priority=100 vrid=40
add interface=vlan50-MGMT name=vrrp50 priority=100 vrid=50

# Physical Subnet Mapping
/ip address
add address=172.16.10.2/24 interface=vlan10-HR
add address=172.16.20.2/24 interface=vlan20-SALES
add address=172.16.30.2/24 interface=vlan30-IT
add address=172.16.40.2/24 interface=vlan40-SERVER
add address=172.16.50.2/24 interface=vlan50-MGMT
add address=10.0.3.1/30 interface=ether2 comment="WAN-03: to BR1-R1 ether3"
add address=10.0.4.1/30 interface=ether3 comment="WAN-04: to BR2-R1 ether3"

# Redundant Shared Gateways Assignment
/ip address
add address=172.16.10.254/24 interface=vrrp10
add address=172.16.20.254/24 interface=vrrp20
add address=172.16.30.254/24 interface=vrrp30
add address=172.16.40.254/24 interface=vrrp40
add address=172.16.50.254/24 interface=vrrp50

# OSPF Multi-Area Setup
/routing ospf instance
add name=ospf-hq router-id=2.2.2.2
/routing ospf area
add instance=ospf-hq name=area0 area-id=0.0.0.0
/routing ospf interface-template
add area=area0 interfaces=ether2,ether3 type=ptp
add area=area0 interfaces=vlan10-HR,vlan20-SALES,vlan30-IT,vlan40-SERVER,vlan50-MGMT type=broadcast

# Hardening Infrastructure Services
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes

# Logging and Timestamps Tracking Setup
/system logging action add name=syslog-server remote=172.16.40.201 target=remote
/system logging add action=syslog-server topics=info,warning,error,critical
/ntp client set enabled=yes
/ntp client servers add address=172.16.40.201
#-------------------------------------------------------------------------
# Device: CORE-SW1 (Headquarters Core Switch 1)
# Operating System: RouterOS v7 (Hardware VLAN Filtering)
#-------------------------------------------------------------------------

/system identity set name=CORE-SW1

# Create Bridge Architecture
/interface bridge
add name=br-vlans vlan-filtering=no

# Bridge Member Port Mappings (Access & Trunk)
/interface bridge port
add bridge=br-vlans interface=ether1 comment="Trunk Link to HQ-R1 ether1"
add bridge=br-vlans interface=ether2 comment="Inter-Switch Trunk Link to CORE-SW2 ether2"
add bridge=br-vlans interface=ether3 pvid=10 comment="Access Port for HR Department"
add bridge=br-vlans interface=ether4 pvid=20 comment="Access Port for Sales Department"
add bridge=br-vlans interface=ether5 pvid=30 comment="Access Port for IT Department"

# VLAN Segmentation Egress Rules Mappings
/interface bridge vlan
add bridge=br-vlans tagged=ether1,ether2 untagged=ether3 vlan-ids=10
add bridge=br-vlans tagged=ether1,ether2 untagged=ether4 vlan-ids=20
add bridge=br-vlans tagged=ether1,ether2 untagged=ether5 vlan-ids=30
add bridge=br-vlans tagged=ether1,ether2 vlan-ids=40,50

# Enable Bridge VLAN Filtering
/interface bridge set br-vlans vlan-filtering=yes
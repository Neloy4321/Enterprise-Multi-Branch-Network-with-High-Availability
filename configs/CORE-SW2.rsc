#-------------------------------------------------------------------------
# Device: CORE-SW2 (Headquarters Core Switch 2)
# Operating System: RouterOS v7 (Hardware VLAN Filtering)
#-------------------------------------------------------------------------

/system identity set name=CORE-SW2

# Create Bridge Architecture
/interface bridge
add name=br-vlans vlan-filtering=no

# Bridge Member Port Mappings
/interface bridge port
add bridge=br-vlans interface=ether1 comment="Trunk Link to HQ-R2 ether1"
add bridge=br-vlans interface=ether2 comment="Inter-Switch Trunk Link to CORE-SW1 ether2"
add bridge=br-vlans interface=ether3 pvid=40 comment="Server VLAN Access Port"
add bridge=br-vlans interface=ether4 pvid=50 comment="Management Access Port"

# VLAN Segmentation Egress Rules Mappings
/interface bridge vlan
add bridge=br-vlans tagged=ether1,ether2 vlan-ids=10,20,30
add bridge=br-vlans tagged=ether1,ether2 untagged=ether3 vlan-ids=40
add bridge=br-vlans tagged=ether1,ether2 untagged=ether4 vlan-ids=50

# Enable Bridge VLAN Filtering
/interface bridge set br-vlans vlan-filtering=yes
#-------------------------------------------------------------------------
# Device: BR1-SW1 (Branch 1 Access Switch)
# Operating System: RouterOS v7
#-------------------------------------------------------------------------

/system identity set name=BR1-SW1

/interface bridge
add name=br-branch vlan-filtering=no

/interface bridge port
add bridge=br-branch interface=ether1 comment="Trunk Link to BR1-R1 ether1"
add bridge=br-branch interface=ether2 pvid=110 comment="Access Port for Users"
add bridge=br-branch interface=ether3 pvid=110 comment="Access Port for Endpoints"

/interface bridge vlan
add bridge=br-branch tagged=ether1 untagged=ether2,ether3 vlan-ids=110

/interface bridge set br-branch vlan-filtering=yes
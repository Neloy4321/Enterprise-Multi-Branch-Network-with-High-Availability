#-------------------------------------------------------------------------
# Device: BR2-SW1 (Branch 2 Access Switch)
# Operating System: RouterOS v7
#-------------------------------------------------------------------------

/system identity set name=BR2-SW1

/interface bridge
add name=br-branch vlan-filtering=no

/interface bridge port
add bridge=br-branch interface=ether1 comment="Trunk Link to BR2-R1 ether1"
add bridge=br-branch interface=ether2 pvid=210 comment="Access Port for Users"

/interface bridge vlan
add bridge=br-branch tagged=ether1 untagged=ether2 vlan-ids=210

/interface bridge set br-branch vlan-filtering=yes
# BR1-SW1 | RouterOS 7.21.4 | EVE-NG exported cabling
/system identity set name=BR1-SW1
/interface bridge add name=br-vlans protocol-mode=rstp vlan-filtering=no
/interface bridge port
add bridge=br-vlans interface=ether1 frame-types=admit-only-vlan-tagged ingress-filtering=yes comment="BR1-R1 trunk"
add bridge=br-vlans interface=ether2 pvid=110 frame-types=admit-only-untagged-and-priority-tagged ingress-filtering=yes comment="BR1-PC1"
add bridge=br-vlans interface=ether3 pvid=110 frame-types=admit-only-untagged-and-priority-tagged ingress-filtering=yes comment="BR1-PC2"
/interface bridge vlan
add bridge=br-vlans vlan-ids=110 tagged=ether1 untagged=ether2,ether3
/interface bridge set br-vlans vlan-filtering=yes
/ip service set telnet disabled=yes
/ip service set ftp disabled=yes
/ip service set www disabled=yes
/ip service set api disabled=yes
/ip service set api-ssl disabled=yes
/ip service set winbox disabled=yes
# Switches are Layer-2 only; management addressing is intentionally omitted.

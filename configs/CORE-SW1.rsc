# CORE-SW1 | RouterOS 7.21.4 | EVE-NG exported cabling
/system identity set name=CORE-SW1
/interface bridge add name=br-vlans protocol-mode=rstp vlan-filtering=no
/interface bridge port
add bridge=br-vlans interface=ether1 frame-types=admit-only-vlan-tagged ingress-filtering=yes comment="HQ-R1 trunk"
add bridge=br-vlans interface=ether2 frame-types=admit-only-vlan-tagged ingress-filtering=yes comment="CORE-SW2 trunk"
add bridge=br-vlans interface=ether3 pvid=10 frame-types=admit-only-untagged-and-priority-tagged ingress-filtering=yes comment="HR-PC1"
add bridge=br-vlans interface=ether4 pvid=10 frame-types=admit-only-untagged-and-priority-tagged ingress-filtering=yes comment="HR-PC2"
add bridge=br-vlans interface=ether5 pvid=20 frame-types=admit-only-untagged-and-priority-tagged ingress-filtering=yes comment="SALES-PC1"
add bridge=br-vlans interface=ether6 pvid=20 frame-types=admit-only-untagged-and-priority-tagged ingress-filtering=yes comment="SALES-PC2"
/interface bridge vlan
add bridge=br-vlans vlan-ids=10 tagged=ether1,ether2 untagged=ether3,ether4
add bridge=br-vlans vlan-ids=20 tagged=ether1,ether2 untagged=ether5,ether6
add bridge=br-vlans vlan-ids=30 tagged=ether1,ether2
add bridge=br-vlans vlan-ids=40 tagged=ether1,ether2
add bridge=br-vlans vlan-ids=50 tagged=ether1,ether2
/interface bridge set br-vlans vlan-filtering=yes
/ip service set telnet disabled=yes
/ip service set ftp disabled=yes
/ip service set www disabled=yes
/ip service set api disabled=yes
/ip service set api-ssl disabled=yes
/ip service set winbox disabled=yes
# Switches are Layer-2 only; management addressing is intentionally omitted.

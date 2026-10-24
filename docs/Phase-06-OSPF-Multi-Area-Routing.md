# Phase 06 — OSPF multi-area routing

**Original EVE-NG test:** [OSPF neighbor output](../images/phase-06/ospf-neighbor-verification.png) shows a Full adjacency; [dynamic routes](../images/phase-06/routing-table-verification.png) and a [branch-subnet ping](../images/testing/ospf-test.png) were also captured. The revised four-link Area 0 alignment still needs its own runtime verification.

The four numbered WAN links are point-to-point. Their area is **Area 0 on both sides**; unequal area IDs prevent OSPF neighbors from forming.

| Link | HQ side | Branch side | Area |
| --- | --- | --- | --- |
| 10.0.1.0/30 | HQ-R1 ether2 | BR1-R1 ether2 | 0 |
| 10.0.2.0/30 | HQ-R1 ether3 | BR2-R1 ether2 | 0 |
| 10.0.3.0/30 | HQ-R2 ether2 | BR1-R1 ether3 | 0 |
| 10.0.4.0/30 | HQ-R2 ether3 | BR2-R1 ether3 | 0 |

Branch 1 additionally has `area10` (stub) on passive VLAN110. Branch 2 has `area20` (stub) on passive VLAN210. Each branch is therefore an Area Border Router. HQ VLANs are passive in Area 0.

The canonical snippets are in [HQ-R1.rsc](../configs/HQ-R1.rsc), [HQ-R2.rsc](../configs/HQ-R2.rsc), [BR1-R1.rsc](../configs/BR1-R1.rsc), and [BR2-R1.rsc](../configs/BR2-R1.rsc). For example, Branch 1's WAN links now use:

```routeros
/routing ospf area
add instance=ospf-br1 name=area0 area-id=0.0.0.0
add instance=ospf-br1 name=area10 area-id=0.0.0.10 type=stub
/routing ospf interface-template
add area=area0 interfaces=ether2,ether3 type=ptp
add area=area10 interfaces=vlan110-USERS passive=yes
```

On all four routers:

```routeros
/routing ospf neighbor print detail
/routing ospf area print
/ip route print where ospf
```

Expected: four distinct HQ↔branch adjacencies in Full state across the physical links and learned routes for both branch client subnets. Tests must be repeated with each WAN link disabled independently.

**October 2026 revision status:** Area mismatch corrected in source. The earlier Full neighbor screenshot is valid evidence of the original EVE-NG test, but does not certify the edited four-link setup.

# Phase 05 — DHCP

HQ DHCP is deliberately split between the two gateways. Both advertise the same per-VLAN default gateway VIP ending in `.254`, but they lease from disjoint ranges.

| VLAN | HQ-R1 pool | HQ-R2 pool |
| --- | --- | --- |
| 10 HR | .100–.180 | .181–.220 |
| 20 Sales | .100–.180 | .181–.220 |
| 30 IT | .100–.180 | .181–.220 |
| 50 Management | .100–.180 | .181–.220 |

Each range is within its own `172.16.<VLAN>.0/24` subnet. VLAN 40 servers receive static addresses. Branch-1 users use 172.16.110.100–.200 and Branch-2 users 172.16.210.100–.200.

This is **split-scope DHCP**, not a synchronized lease database. Both HQ servers can respond while online, and their lease records remain independent. This tradeoff keeps the demonstration simple but is not a full DHCP HA solution.

No DHCP relay is needed for the present branch layout because each branch has its own local DHCP server. Earlier notes referring to centralized branch relay describe a future design, not the exported configuration.

Useful commands:

```routeros
/ip dhcp-server print
/ip dhcp-server network print
/ip dhcp-server lease print
```

Renew two hosts in each VLAN, inspect their subnet/gateway, then shut down HQ-R1's DHCP service and test a new lease from HQ-R2. **These runtime cases are pending.**

# Phase 03 — VLAN configuration

The current Layer-2 source is the four `configs/*SW1.rsc` files. These bridge scripts use tagged trunks, explicit PVIDs and `ingress-filtering=yes` with suitable `frame-types`. Each switch starts with `vlan-filtering=no`, programs its ports and VLAN table, then enables filtering.

## EVE-NG access-port map

| Switch | Access ports | VLAN |
| --- | --- | --- |
| CORE-SW1 | ether3/ether4: HR-PC1/HR-PC2 | 10 |
| CORE-SW1 | ether5/ether6: SALES-PC1/SALES-PC2 | 20 |
| CORE-SW2 | ether3/ether4: IT-PC1/IT-PC2 | 30 |
| CORE-SW2 | ether5: ADMIN-PC | 50 |
| CORE-SW2 | ether6/ether7: File and Syslog placeholders | 40 |
| BR1-SW1 | ether2/ether3: branch clients | 110 |
| BR2-SW1 | ether2/ether3: branch clients | 210 |

Trunk mapping: each core switch `ether1` faces its HQ router and `ether2` faces the other core switch. Branch `ether1` faces the router.

VLAN 60, 120 and 220 are reserved in the plan but **not present in this build**.

## Check after importing

```routeros
/interface bridge port print detail
/interface bridge vlan print
/interface bridge host print
```

The original port mapping was inconsistent with the actual `.unl` endpoint cables (notably Sales/IT and the second Branch-2 client). The revised scripts use the exported wiring. This correction is statically checked but has not been boot-tested.

Historical screenshots are under `images/phase-03/`; do not reuse them as acceptance evidence for this revision.

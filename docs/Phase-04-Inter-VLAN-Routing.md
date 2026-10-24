# Phase 04 — Inter-VLAN routing

**Original EVE-NG test:** The [inter-VLAN test screenshot](../images/phase-04/inter-vlan-connectivity-test.png) shows successful responses from hosts in three HQ subnets. The revised `.254` virtual-gateway settings have not been retested in EVE-NG.

Headquarters uses router-on-a-stick on each HQ gateway's `ether1` trunk. Both routers attach VLAN interfaces 10, 20, 30, 40 and 50 with unique real IPs:

- HQ-R1: `172.16.<VLAN>.1/24`
- HQ-R2: `172.16.<VLAN>.2/24`
- VRRP default gateway: `172.16.<VLAN>.254/32`

A host uses the .254 gateway, not the physical .1/.2. The VRRP backup will route for the floating address only after becoming Master.

Branch-1 local subnet is 172.16.110.0/24; Branch-2 is 172.16.210.0/24. Branch router VLAN subinterfaces terminate their local broadcast domains. Cross-site routing is handled by OSPF, not by VLAN trunking across the WAN.

Check device addresses and packet paths:

```routeros
/interface vlan print
/ip address print
/ip route print
/interface vrrp print
```

Then ping from HR to the permitted Sales/server destination, and from HR to IT to confirm it is blocked by policy. A failed ping may be a VLAN, route, host or firewall problem; check counters before assigning the cause.

**October 2026 revision status:** Static configuration review complete. The original inter-VLAN test passed in EVE-NG, but the edited config has not been rerun. Use [the acceptance checklist](REBUILD-AND-ACCEPTANCE.md).

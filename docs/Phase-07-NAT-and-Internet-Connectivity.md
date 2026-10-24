# Phase 07 — Internet path and NAT

**Original EVE-NG test:** An [HR VPCS received five replies from 8.8.8.8](../images/phase-07/internet-connectivity-test.png), and HQ-R1's [masquerade rule](../images/phase-07/source-nat-configuration.png) was captured. This is original connectivity evidence; the added HQ-R2 WAN/NAT path has not been retested.

Both HQ routers now have an `ether4` connection to the EVE-NG management cloud. Each uses an independent DHCP client to learn a default route and address. Each has a source NAT masquerade rule for the corporate `172.16.0.0/16` space.

```routeros
/ip dhcp-client print detail
/ip route print where dst-address=0.0.0.0/0
/ip firewall nat print stats
```

OSPF uses `originate-default=if-installed` so an HQ device without an installed default route should not advertise itself as an Internet exit.

The management cloud is **one shared upstream failure domain**. This setup demonstrates router-level gateway takeover but not two independent ISPs. When traffic changes from HQ-R1 to HQ-R2, outbound NAT can use a different source address. Existing TCP sessions are not promised to survive.

Live test sequence:
1. Check each HQ WAN has an address and active default route.
2. Start new Internet traffic from every VLAN.
3. Disable HQ-R1 and verify a **new** connection through HQ-R2.
4. Record time to first successful request and whether old sessions reset.
5. Restore HQ-R1 and repeat.

**October 2026 revision status:** Earlier EVE-NG Internet connectivity is documented; revised dual-uplink behavior and failover have not been measured.

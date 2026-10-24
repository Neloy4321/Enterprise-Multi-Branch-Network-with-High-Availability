# Phase 09 — HQ virtual gateway redundancy

HQ-R1 and HQ-R2 share the same VRID set (10, 20, 30, 40, 50) and virtual gateway addresses ending `.254`. HQ-R1 uses priority **150**, HQ-R2 priority **100**. VRRP virtual IPs are **/32**, while router physical VLAN addresses retain /24 subnet masks.

These values avoid the old non-owner `priority=255` and `.254/24` settings. The VRRP and physical address assignments are in the current [HQ-R1](../configs/HQ-R1.rsc) and [HQ-R2](../configs/HQ-R2.rsc) exports.

```routeros
/interface vrrp print detail
/ip address print where interface~"vrrp"
```

With both routers healthy, expect HQ-R1 to own each VIP and HQ-R2 to be Backup. During a deliberate HQ-R1 shutdown, the backup should become Master after the VRRP timeout. The interval and real packet loss must be recorded in the running lab.

## What failover means here

- The **gateway address** can survive HQ-R1 loss if Layer 2 and HQ-R2 remain healthy.
- HQ-R2 now has a WAN DHCP client and NAT, allowing **new** Internet connections to be tested after takeover.
- Existing Internet connections can still reset when the NAT public source IP changes.
- One shared management cloud is not dual-carrier redundancy.
- A WAN-only failure does not automatically imply VRRP role change; upstream monitoring is future work.

Do not label the design zero-loss, hitless or session-preserving. Use the [acceptance checklist](REBUILD-AND-ACCEPTANCE.md) and save timestamped failure/recovery measurements.

**Status:** Script-level redundancy improved; live takeover and loss metrics remain unverified.

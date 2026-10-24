# Phase 13 — Original EVE-NG test results and revision status

The multi-branch network was **built and tested in EVE-NG by the author**. The screenshots show working client communication, DHCP assignment, OSPF adjacency and learned routes, Internet connectivity, firewall enforcement examples, VRRP backup takeover and recovery, SSH access, and Syslog/NTP service exercises. This is a completed emulation project with historical evidence, not an untested proposal.

![Original lab canvas](../images/phase-01/eve-ng-topology.png)

## Recorded EVE-NG outcomes

- **VLANs and routing:** [client pings across HQ networks](../images/testing/vlan-verification.png), [OSPF Full neighbor](../images/phase-06/ospf-neighbor-verification.png) and [branch ping](../images/phase-13/enterprise-functional-testing.png).
- **DHCP and Internet:** [bound DHCP leases](../images/phase-05/dhcp-lease-verification.png) and [successful Internet ICMP](../images/phase-07/internet-connectivity-test.png).
- **Security:** [HR-to-IT traffic denied](../images/phase-08/traffic-filtering-verification.png), [firewall drop rule counters](../images/phase-08/firewall-rule-validation.png) and [SSH administration](../images/phase-10/ssh-login-verification.png).
- **High availability:** [HQ-R1 initially Master](../images/phase-09/master-backup-status.png), [HQ-R2 takes over](../images/phase-09/vrrp-failover-test.png), [HQ-R1 recovers](../images/phase-09/vrrp-recovery-verification.png).
- **Infrastructure services:** [Syslog packets and Linux collector](../images/phase-11/syslog-validation.png), [RouterOS NTP synchronized](../images/phase-12/time-synchronization-verification.png).

All 79 project images, evidence limits and version differences are indexed in [EVE-NG implementation and test evidence](EVE-NG-TEST-EVIDENCE.md). Not every network path or fault scenario is covered by those screenshots, and measured convergence timing/packet-loss results are not part of the saved record.

## October 2026 engineering revision

The `.unl` export and eight `.rsc` files have since been reconciled: Layer-2 port assignments, Area 0 WAN OSPF adjacency definitions, VRRP priorities and `/32` VIPs, dual HQ WAN/NAT paths, split DHCP pools, RouterOS management filters and service configuration paths were revised. The automated source checker has passed.

**Only this newer configuration is pending fresh EVE-NG execution.** The original lab's screenshots include different gateway settings, a VRRP priority of 255 and a RouterOS 7.12 console capture. Therefore those results document the original build; they cannot be copied as if they came from the edited scripts.

## Next verification

1. Re-import all eight edited configs and confirm RouterOS accepts them.
2. Confirm VLAN mapping, DHCP gateways, OSPF Full neighbors and branch routes under the new addresses.
3. Repeat firewall positive/negative tests on both HQ routers.
4. Repeat VRRP takeover and recovery, measuring lost packets, recovery time and new NAT sessions.
5. Attach the Linux Syslog/NTP service VM missing from the exported `.unl` and retain new server-side evidence.

That is the distinction used throughout the repository: **tested original EVE-NG implementation; revised configuration awaiting re-test.** Neither the original screenshots nor the static checker alone establish a production deployment or a zero-loss availability SLA.

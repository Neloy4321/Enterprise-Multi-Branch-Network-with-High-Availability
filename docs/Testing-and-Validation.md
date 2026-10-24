# Testing and validation

## What has been tested

**The original project was built and tested in EVE-NG.** The screenshot archive contains client ping results, DHCP leases, OSPF state, NAT rule and Internet reachability, firewall counters, VRRP takeover and recovery, an SSH login, Syslog reception and NTP status. These are historical test results, not just intended commands. See the [annotated evidence register](EVE-NG-TEST-EVIDENCE.md) for direct screenshots and the exact scope of each result.

**The configuration and topology changes made in October 2026 are a separate revision.** Their source consistency was checked automatically, but EVE-NG has not been available for a new execution pass. Historical screenshots are retained as authentic project work without presenting them as a new run.

## Evidence matrix

| ID | Exercise | Original EVE-NG screenshot evidence | October 2026 revised build |
| --- | --- | --- | --- |
| T01 | Emulation environment and topology | EVE dashboard / topology canvas [screenshots](../images/phase-01/eve-ng-topology.png) | CHR 7.21.4 cold import not rerun |
| T02 | VLANs and inter-VLAN connectivity | [Successful client pings](../images/testing/vlan-verification.png) | New cable/port assignments statically checked; not rerun |
| T03 | DHCP addresses and leases | [DORA response](../images/testing/dhcp-test.png), [bound leases](../images/phase-05/dhcp-lease-verification.png) | Split-scope DHCP and `.254` VIP gateway not rerun |
| T04 | OSPF and cross-site routes | [Full neighbor](../images/phase-06/ospf-neighbor-verification.png), [learned routes](../images/phase-06/routing-table-verification.png), [client ping](../images/testing/ospf-test.png) | Corrected Area 0 neighbors on all four WAN links not rerun |
| T05 | HR-to-IT firewall block | [Timeouts](../images/testing/firewall-test.png) and [rule hit counter](../images/phase-08/firewall-rule-validation.png) | Both HQ router policies and denied-source tests not rerun |
| T06 | Internet path / NAT | [8.8.8.8 replies](../images/testing/nat-test.png) and [masquerade rule](../images/phase-07/source-nat-configuration.png) | Dual HQ uplink and failover NAT not rerun |
| T07 | VRRP failover / recovery | [Original roles](../images/phase-09/master-backup-status.png), [backup takeover](../images/phase-09/vrrp-failover-test.png), [recovery](../images/phase-09/vrrp-recovery-verification.png) | Corrected priorities/VIPs and measured failover not rerun |
| T08 | Post-failover traffic continuity | Role transition is pictured; packet-loss/session data not available | New-connection recovery and existing session behavior not rerun |
| T09 | SSH login | [Successful SSH terminal session](../images/testing/ssh-test.png) | Revised source allowlist and denied-source cases not rerun |
| T10 | Central Syslog | [Linux UDP capture](../images/phase-11/syslog-validation.png) and [collector file](../images/phase-11/monitoring-dashboard.png) | Linux service VM absent from current exported `.unl`; new end-to-end test not rerun |
| T11 | NTP | [Router synchronized status](../images/phase-12/time-synchronization-verification.png) and [service events](../images/phase-12/integrated-service-verification.png) | Revised client paths and actual clock offset not rerun |

## Observations that must travel with the evidence

- The historical DHCP screenshots show gateways ending in `.1`; the corrected VRRP design advertises `.254`. Both are real records of **different configuration versions**, not interchangeable pass results.
- The historical VRRP screenshot shows HQ-R1 priority `255`. The revised non-owner priority is `150` with HQ-R2 at `100`.
- The SSH screenshot shows RouterOS `7.12 (stable)`; the `.unl` revision references a CHR 7.21.4 image. Record the exact version during the next run.
- The historical NAT screenshot named `nat-translation-table.png` is connection tracking, not source-NAT translations. Outbound ping and a masquerade rule exist, but the backup NAT path is not measured.
- The older NTP screenshots include a router `synchronized` status and a separate Linux `ntpq -p` output with `LOCAL(0)` selected. Do not infer external-clock accuracy from this.
- The original Linux collector screenshots are useful evidence that Syslog/NTP exercises were performed. The current exported EVE-NG lab topology, however, contains a VPCS node named SYSLOG-SERVER. The actual Linux service host is not captured as a deployable node in that export.

## New revision test record

Use the detailed [EVE-NG rebuild and acceptance checklist](REBUILD-AND-ACCEPTANCE.md). When the environment is available, capture:

```text
Test ID:
Execution date/time and timezone:
EVE-NG lab file and revision SHA:
RouterOS image version:
Device(s), interfaces and test client:
Commands and complete output path:
Expected outcome:
Observed outcome, including packet loss/duration:
PASS / FAIL / BLOCKED:
Issue and retest reference:
```

**Summary:** Original EVE-NG implementation — **tested, with screenshot evidence**. October 2026 revised config — **static CI verified, live retest not performed**. No production hardware deployment or zero-loss SLA is claimed.

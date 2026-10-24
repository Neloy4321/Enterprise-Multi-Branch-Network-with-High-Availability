# Test results and evidence register

**Revised configuration:** 24 October 2026

This page supersedes the original all-PASS narrative. The older screenshots in `images/testing/` belong to an earlier lab session and are not sufficient proof that the updated configuration works.

The executable-style checklist is [REBUILD-AND-ACCEPTANCE.md](REBUILD-AND-ACCEPTANCE.md). When EVE-NG is available again, capture raw device output and fill the following table.

| Test ID | What to verify | Current evidence | Result |
| --- | --- | --- | --- |
| T01 | RouterOS v7.21.4 import without errors | Not captured | PENDING |
| T02 | EVE port-to-VLAN and DHCP assignments | Static source check only | PENDING |
| T03 | HQ to branch OSPF Full adjacencies | Source updated, no runtime log | PENDING |
| T04 | Cross-site routing and packet capture | Not captured | PENDING |
| T05 | HR→IT and branch→management negative tests | Rules present, counters not captured | PENDING |
| T06 | Separate HQ WAN addresses and NAT | Config present, cloud not running | PENDING |
| T07 | VRRP HQ-R1 loss, HQ-R2 takeover | Config present, failover not measured | PENDING |
| T08 | Fresh traffic following failover | Not captured | PENDING |
| T09 | SSH from approved and denied sources | Not captured | PENDING |
| T10 | Real Linux Syslog reception | Placeholder VPCS only | PENDING |
| T11 | NTP status from configured time server | No live server or device result | PENDING |

## Evidence format

For every case append:

```text
Test:
Date/time (including timezone):
Lab/RouterOS version:
Devices and test traffic:
Commands issued:
Raw output location:
Expected:
Observed:
PASS / FAIL / BLOCKED:
Failure cause and retest:
```

Do not label tests PASS based only on the existence of command examples or PNG files. For failover, report exact packet counts, time to master election, time to first recovered packet, and whether existing sessions reset.

Current acceptance status: **BLOCKED — original EVE-NG environment unavailable**.

# Phase 08 — Router firewall and management access

**Original EVE-NG test:** [HR-to-IT ping attempts timed out](../images/testing/firewall-test.png), while the [forward-chain rule counters](../images/phase-08/firewall-rule-validation.png) show packets matched a drop rule. The mirrored HQ-R2 policy and full negative-test matrix for the revised configuration have not yet been run.

Both HQ routers now contain equivalent input and forward filters. The input policy first accepts established/related traffic and required control protocols, permits SSH from the IT/management address list, then drops the rest. The forward policy rejects invalid packets and unsolicited new WAN traffic.

The specific lateral restrictions are:

| Source | Destination | Action |
| --- | --- | --- |
| HQ HR 172.16.10.0/24 | HQ IT 172.16.30.0/24 | Drop |
| Branch 1 users 172.16.110.0/24 | HQ management 172.16.50.0/24 | Drop |
| Branch 2 users 172.16.210.0/24 | HQ management 172.16.50.0/24 | Drop |

Other internal traffic is allowed while the lab lacks a full application-specific requirement matrix. This is a baseline segmentation policy, **not zero-trust**.

SSH access is limited to 172.16.30.0/24 and 172.16.50.0/24. Telnet, FTP, HTTP(S) management, API and Winbox are disabled in the provided scripts; serial EVE consoles remain the recovery path. User accounts and credentials must be provisioned securely outside Git.

Run positive and negative tests after import:

```routeros
/ip firewall filter print stats
/ip firewall address-list print
/ip service print
```

Observe an incrementing drop counter when sending denied traffic. Repeat while HQ-R2 has taken over the VRRP VIP. IPv6 policy, OSPF authentication, and an application allowlist remain open design work.

**October 2026 revision status:** Earlier EVE-NG filtering was tested; updated dual-router policies received static review but no live retest.

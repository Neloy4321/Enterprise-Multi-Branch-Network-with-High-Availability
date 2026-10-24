# Phase 12 — Time synchronization

**Original EVE-NG test:** The [HQ-R1 console reports synchronized to 172.16.40.201](../images/phase-12/time-synchronization-verification.png), with [time-sync messages](../images/phase-12/integrated-service-verification.png) in the central log. The historical `ntpq -p` [server view](../images/phase-12/ntp-status-validation.png) shows `LOCAL(0)`, so external time accuracy was not established. The corrected command paths have not been rerun.

The current RouterOS v7 scripts use:

```routeros
/system ntp client set enabled=yes
/system ntp client servers add address=172.16.40.201
```

The earlier shortened `/ntp client` path did not match the documented RouterOS v7 command tree.

Set up a proper Linux chrony server at `172.16.40.201` on VLAN 40 before checking these clients. [The service reference](../services/README.md) gives a minimal configuration; the VPCS placeholder cannot serve NTP.

Runtime evidence must include:

```routeros
/system ntp client print
/system ntp client servers print
/system clock print
```

Capture the real synchronized status and upstream source; do not assume millisecond accuracy from a config export.

**October 2026 revision status:** Original NTP synchronization was documented in EVE-NG; the corrected client syntax, time accuracy and clean-rebuild service setup need retesting.

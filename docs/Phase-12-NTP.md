# Phase 12 — Time synchronization

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

**Status:** Configuration path corrected; clock synchronization pending live service and router verification.

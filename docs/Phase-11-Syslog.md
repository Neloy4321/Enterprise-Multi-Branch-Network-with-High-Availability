# Phase 11 — Central logging

RouterOS logging actions target `172.16.40.201:514` for warning and error events. The configuration is in each router `.rsc` file, and a Linux rsyslog example is in [services](../services/README.md).

The node labeled `SYSLOG-SERVER` in the exported EVE-NG topology is **VPCS**. It is not a running rsyslog host. Place a Linux VM on CORE-SW2 ether7/VLAN 40 at the specified address and enable UDP 514 only within the lab.

Validate on the router:

```routeros
/system logging action print
/system logging print
```

Trigger an identifiable event in the lab. On the Linux server, inspect packet arrival and the per-host log file. A RouterOS logging rule alone does not demonstrate log delivery.

**Status:** Client-side configuration prepared; server deployment and end-to-end Syslog evidence pending.

# Phase 11 — Central logging

**Original EVE-NG test:** Screenshots show [UDP 514 messages reaching a Linux host](../images/phase-11/syslog-validation.png) and [router events written to a collector log](../images/phase-11/monitoring-dashboard.png). The original practical test is documented; the current `.unl` export does not package the Linux server, so a clean rebuild still needs to add one.

RouterOS logging actions target `172.16.40.201:514` for warning and error events. The configuration is in each router `.rsc` file, and a Linux rsyslog example is in [services](../services/README.md).

The node labeled `SYSLOG-SERVER` in the exported EVE-NG topology is **VPCS**. It is not a running rsyslog host. Place a Linux VM on CORE-SW2 ether7/VLAN 40 at the specified address and enable UDP 514 only within the lab.

Validate on the router:

```routeros
/system logging action print
/system logging print
```

Trigger an identifiable event in the lab. On the Linux server, inspect packet arrival and the per-host log file. A RouterOS logging rule alone does not demonstrate log delivery.

**October 2026 revision status:** The original EVE-NG Syslog exercise includes Linux collector screenshots. A new Linux collector instance is absent from the exported rebuild and must be configured for this revision.

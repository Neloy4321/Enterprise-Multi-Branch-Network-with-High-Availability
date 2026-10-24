# Phase 10 — SSH management baseline

The revised RouterOS scripts disable unused management services and limit SSH to IT and management sources (`172.16.30.0/24`, `172.16.50.0/24`). No login credentials are committed.

After deploying to clean routers, create a named personal administrative account through a secure console or your organization’s credential-management procedure, then test key-based or otherwise appropriately secured SSH access. Do not reuse a shared demo password.

```routeros
/ip service print
/user print
/ip firewall filter print stats
```

Confirm access from the approved ADMIN/IT subnet, and denial from Sales, HR and branch-user subnets. MAC Winbox/MAC server and neighbor discovery are disabled to reduce unintended L2 management exposure.

**Status:** Configuration policy present; successful SSH key authentication and negative connection tests await EVE-NG execution. Out-of-band hardware management and centralized AAA are not deployed.

# Phase 13 — Rebuild status and next acceptance gate

The enterprise lab consists of two HQ gateways, two core switches, two branch routers, two branch access switches and thirteen VPCS endpoints. The exported EVE-NG topology and RouterOS source files have been reconciled in October 2026.

The historical phase screenshots document earlier development work. They do not prove that the current revisions have been imported and tested in RouterOS.

## What is available

- Revised VLAN access/trunk mapping to match the exported `.unl` cable map.
- Common OSPF Area 0 transit links, with passive local branch area interfaces.
- HQ gateway VIPs using distinct primary/backup priorities and `/32` virtual IP addresses.
- Backup HQ external interface in the lab topology, split DHCP scopes, and mirrored outbound NAT/firewall policy.
- Restrictive router input policy and scoped SSH access.
- Static source checker and a step-by-step test register.

## Still required

1. Run all eight files on clean RouterOS 7.21.4 CHR instances and record zero import errors.
2. Verify VLAN assignments, address leases, OSPF neighbors, routes and cross-site reachability.
3. Simulate primary failure and measure loss, master election and new connection recovery.
4. Replace the VPCS server placeholder with a genuine Linux Syslog/NTP service.
5. Complete the negative security cases and retain console logs.

Do not describe this version as production-ready or zero-downtime. The appropriate project description is **Enterprise Multi-Branch Network Design and EVE-NG Emulation Lab** until live acceptance is complete.

See [Testing and Validation](Testing-and-Validation.md) and [Rebuild and Acceptance](REBUILD-AND-ACCEPTANCE.md).

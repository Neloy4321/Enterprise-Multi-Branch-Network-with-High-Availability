# RouterOS configuration set

The original enterprise network was **implemented and tested in EVE-NG**, with [screenshots of the actual exercises](../docs/EVE-NG-TEST-EVIDENCE.md). This directory now contains eight **revised** RouterOS v7.21.4 import scripts for the eight CHR devices. They are the source of truth **for the October 2026 revision**. Historical screenshots may show different router settings and are not substitutes for a new clean import.

## Import order

1. Import `lab/Enterprise_Multi_Branch_Network.unl` into EVE-NG.
2. Install the CHR image named `mikrotik-chr-7.21.4` on the EVE-NG host.
3. Start a **clean** CHR instance for each node; avoid applying these files on top of unknown existing configurations.
4. Apply `CORE-SW1.rsc`, `CORE-SW2.rsc`, `BR1-SW1.rsc`, `BR2-SW1.rsc`.
5. Apply `HQ-R1.rsc`, `HQ-R2.rsc`, `BR1-R1.rsc`, `BR2-R1.rsc`.
6. Provision administrative credentials locally; the repository deliberately contains none.
7. Bring up a proper Linux Syslog/NTP server in VLAN 40 before checking those services.
8. Run the acceptance cases in [REBUILD-AND-ACCEPTANCE.md](../docs/REBUILD-AND-ACCEPTANCE.md).

RouterOS import syntax to use in the device console:

```routeros
/import file-name=HQ-R1.rsc verbose=yes
```

Transfer the matching file to each device first. Inspect import errors and `/log print` before treating an import as complete.

## Design notes

- HQ router VLAN addressing is `.1` and `.2`; VRRP gateway `.254/32`.
- Each HQ router has an independent DHCP-backed uplink on `ether4`. A management-cloud uplink is **not** a production ISP design.
- DHCP for HQ subnets uses split, non-overlapping pools; the leases are **not** synchronized.
- Branch routers are ABRs with WAN transit in Area 0 and local passive interfaces in Area 10/20.
- Branch printer VLAN 120/220 and HQ printer VLAN 60 are reserved for future work, not deployed.
- Firewall policy blocks HR→IT and branch-users→HQ management; the remaining internal flow policy is intentionally permissive until an application access matrix is defined.
- Backup WAN addressing changes the NAT source IP after a full HQ-R1 failure. Established internet connections are not promised to survive.
- The **original EVE-NG tests were performed and documented**. RouterOS import and runtime re-verification for **these edited scripts** remain pending until EVE-NG is available.

Run the repository's dependency-free static check with:

```sh
python3 tools/lint_lab.py
```

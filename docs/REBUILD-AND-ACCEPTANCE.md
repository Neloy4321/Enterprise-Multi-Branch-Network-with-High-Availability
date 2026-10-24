# Rebuild and acceptance checklist

**Original EVE-NG lab: implemented and tested.** The project includes screenshots of routing, DHCP, firewall filtering, VRRP takeover, SSH, Syslog and NTP. See [original test evidence](EVE-NG-TEST-EVIDENCE.md). **October 2026 revision: awaiting its own EVE-NG re-test.** The steps below apply to the updated configuration and are not a denial of the earlier successful tests.

## Preconditions

- EVE-NG Community with CHR 7.21.4 image available.
- All eight `.rsc` scripts imported into clean devices with zero import errors.
- An EVE-NG management cloud that issues separate DHCP WAN addresses to both HQ routers.
- Service VM at `172.16.40.201/24`, gateway `172.16.40.254`, running rsyslog and chrony (see [services](../services/README.md)).
- Lab consoles and at least two client endpoints with continuous ping capability.
- All tests run in an isolated lab, never on a production switch without a change window.

For each test record: date/time, RouterOS version, device, command, raw output, observed vs expected result, and a clear PASS/FAIL. Keep failed results; they are useful troubleshooting evidence.

## 1. Import and cable mapping

On each CHR:

```routeros
/system resource print
/interface print
/log print where topics~"error"
```

Inspect the `.unl` topology, especially HQ-R2 `ether4` and core-switch access port assignments. Run `python3 tools/lint_lab.py` in the repository first.

**Pass:** No rejected import command; all expected interfaces up. **October 2026 revision:** Not rerun in EVE-NG; see the separately recorded original-lab results.

## 2. Layer 2 and DHCP

On switches:

```routeros
/interface bridge port print
/interface bridge vlan print
/interface bridge host print
```

On HQ routers and branches:

```routeros
/ip dhcp-server print detail
/ip dhcp-server lease print
```

Endpoint expectations:

| Endpoint | VLAN | Expected subnet | Gateway |
| --- | --- | --- | --- |
| HR-PC1, HR-PC2 | 10 | 172.16.10.0/24 | 172.16.10.254 |
| SALES-PC1, SALES-PC2 | 20 | 172.16.20.0/24 | 172.16.20.254 |
| IT-PC1, IT-PC2 | 30 | 172.16.30.0/24 | 172.16.30.254 |
| ADMIN-PC | 50 | 172.16.50.0/24 | 172.16.50.254 |
| File-SERVER, SYSLOG-SERVER placeholder | 40 | 172.16.40.0/24 | 172.16.40.254 |
| BR1-PC1, BR1-PC2 | 110 | 172.16.110.0/24 | 172.16.110.1 |
| BR2-PC1, BR2-PC2 | 210 | 172.16.210.0/24 | 172.16.210.1 |

Servers are statically addressed. VLANs 60, 120 and 220 are **not** deployed.

**Pass:** Every configured endpoint maps to the intended VLAN and gateway. **October 2026 revision:** Not rerun in EVE-NG; see the separately recorded original-lab results.

## 3. OSPF areas, neighbors and routes

On all four routers:

```routeros
/routing ospf instance print detail
/routing ospf area print
/routing ospf interface-template print
/routing ospf neighbor print detail
/ip route print where ospf
```

Expect four WAN links using area 0 at both ends. Branch LANs are passive area 10/20 networks. HQ should learn `172.16.110.0/24` and `172.16.210.0/24`; branches should learn the HQ prefixes and, where WAN default routes exist, a default route.

**Pass:** Each physical point-to-point adjacency is Full; expected routes are active; inter-site pings return. **October 2026 revision:** Not rerun in EVE-NG; see the separately recorded original-lab results.

## 4. Firewall and SSH

Verify:

- HR → IT denied, including when HQ-R2 is master.
- Branch 1 and Branch 2 users → HQ VLAN 50 denied.
- IT/MGMT → routers SSH allowed after a local administrator is provisioned.
- General user and outside networks → router administrative ports denied.
- Legitimate HR/Sales/IT → authorized server paths remain usable.

On routers:

```routeros
/ip firewall filter print stats
/ip service print
```

Do not interpret a ping timeout by itself as proof of firewall enforcement; observe the corresponding drop counter. **October 2026 revision:** Not rerun in EVE-NG; see the separately recorded original-lab results.

## 5. Internet path and NAT

On both HQ routers:

```routeros
/ip dhcp-client print detail
/ip route print where dst-address=0.0.0.0/0
/ip firewall nat print stats
```

Confirm separate DHCP-assigned WAN addresses and that a fresh flow from each HQ/branch VLAN can exit via the active path. A management cloud is a test Internet source, not equivalent to a redundant ISP.

**Pass:** New client sessions work through each gateway in the appropriate failure scenario. **October 2026 revision:** Not rerun in EVE-NG; see the separately recorded original-lab results.

## 6. VRRP and controlled failover

Before a failure:

```routeros
/interface vrrp print detail
/ip address print where interface~"vrrp"
```

Expect HQ-R1 master (priority 150) and HQ-R2 backup (priority 100), all VIPs ending `.254/32`. Then, in the lab only:

1. Run continuous pings to a local HQ gateway, a branch endpoint, and an outside address.
2. Capture VRRP state on both routers.
3. Disable `ether1` on HQ-R1 or stop the HQ-R1 VM.
4. Measure when HQ-R2 becomes master, lost pings, and recovery of new Internet connections.
5. Re-enable the link/device; measure preemption and route recovery.
6. Repeat with the HQ-R1 WAN link disabled; note that basic VRRP does not automatically track outside reachability.

**Important:** Different DHCP WAN addresses mean established NAT sessions may reset. A zero-loss or session-preserving failover is **not** part of the present design.

**Pass:** Virtual gateway changes owner correctly and new flows recover within a measured, documented interval. **October 2026 revision:** Not rerun in EVE-NG; see the separately recorded original-lab results.

## 7. Syslog and NTP

Do not treat the VPCS label `SYSLOG-SERVER` as a running service. Replace/attach a Linux VM in VLAN 40 and start the services under [services](../services/README.md).

Router commands:

```routeros
/system logging action print
/system ntp client print
/system ntp client servers print
/system clock print
```

Generate a controlled warning event, verify it at the Linux collector, then check the clock offset against the Linux time server.

**Pass:** Server-side Syslog entry includes a router identity and timestamp; NTP client shows synchronized status. **October 2026 revision:** Not rerun in EVE-NG; see the separately recorded original-lab results.

## Final approval record

| Gate | State |
| --- | --- |
| Original EVE-NG tests and screenshot archive | Available — [evidence register](EVE-NG-TEST-EVIDENCE.md) |
| Static topology/config consistency of 2026 revision | CI check passed on the current PR |
| Zero-error RouterOS imports | Pending |
| L2/DHCP connectivity | Pending |
| Multi-area OSPF neighbors/routes | Pending |
| Security policy negative tests | Pending |
| Both egress paths and fresh NAT sessions | Pending |
| VRRP failover timing/packet loss | Pending |
| Central Syslog and NTP evidence | Pending |

The **original lab was tested in EVE-NG**; the rows above specify the additional proof needed before saying the **October 2026 edited configuration** was also tested. Production deployment would separately require physical hardware, upstream link diversity, monitoring, operations and security acceptance.

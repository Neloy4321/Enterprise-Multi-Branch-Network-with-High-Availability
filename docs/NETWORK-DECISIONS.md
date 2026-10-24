# Network design decisions and limits

This is a practical engineering note for future rebuilds and design reviews. It records *why* the source configuration takes its current form.

## Topology and addressing

HQ uses two routers and two Layer-2 core switches with a trunk between them. VLAN 10/20 users attach to CORE-SW1; VLAN 30 IT, VLAN 40 services and VLAN 50 administration attach to CORE-SW2. Each HQ router has an 802.1Q trunk into its adjacent switch. The EVE-NG `.unl` cable map, rather than the older overview diagram, is authoritative for port numbers.

WAN links are direct /30 point-to-point paths. Each branch has one router and two paths back to HQ; the access switch at a branch remains a single point of failure. The project does not claim fully redundant branch LANs.

## OSPF

The four WAN physical links are in Area 0 on **both** ends. Branch routers are area border routers for local Area 10/20 segments, which are passive and configured as stub areas. Local HQ interfaces are passive in Area 0. The former branch configuration placed WAN interfaces in Area 10/20 while the HQ end used Area 0; that is not a valid adjacency.

HQ router instances advertise a default route only when one is installed. A DHCP-assigned default route from the EVE management cloud is an emulator dependency, not a designed ISP SLA.

## HQ gateway redundancy

HQ-R1 normally wins VRRP election with priority 150; HQ-R2 uses 100. Virtual router addresses are `172.16.<VLAN>.254/32`; real addresses are `.1/24` and `.2/24`.

Both routers have an independent management-cloud WAN interface and NAT. This permits **new** outbound connections after router failure, assuming WAN DHCP works. It does not preserve established Internet sessions because public source addressing differs. VRRP does not solve WAN upstream failure by itself. Connection tracking synchronization and shared upstream address design are deferred until the exact availability requirement is chosen.

The lab should record loss/recovery times empirically; it has no measured sub-second target.

## DHCP approach

HQ DHCP scopes are split:
- HQ-R1: `.100–.180`
- HQ-R2: `.181–.220`

They are deliberately non-overlapping. This is **not** lease-state replication, and it does not provide enterprise DHCP failover semantics. A dedicated redundant DHCP service with coordinated leases would be preferable beyond this lab. Branch router scopes remain local.

## Security policy

The router input chain explicitly accepts required control-plane protocols (OSPF, VRRP, DHCP and scoped management) and denies other input. WAN-originated new forwarded sessions are denied. Existing HR→IT and branch-users→management restrictions are retained on both HQ routers.

There is **no application owner-approved east/west access matrix**. Internal traffic otherwise remains permitted. Call this basic segmentation and management hardening, not a zero-trust policy. IPv6, OSPF authentication, site-to-site encryption, privileged AAA and centralized secrets are separate work items.

The configuration deliberately contains no device password. Provision a personal administrator locally or from a proper secrets service, test SSH, then restrict/remove default accounts as appropriate.

## Monitoring services

The EVE-NG `SYSLOG-SERVER` is a VPCS host in the original export. It cannot serve as a Linux Syslog/NTP collector. The service configuration is provided in `services/`, but an operator must attach a real Linux VM at `172.16.40.201` and record that server's actual output.

## Evidence and scope

Old screenshots are retained to preserve the project history. The revised scripts have not been executed in a live EVE-NG session. The CI check is intentionally conservative: it catches stale cables, missing policies and invalid source assertions, but it does not replace a network emulator or RouterOS parser.

The next milestone is a complete rebuild and a filled acceptance report with raw outputs. Until then, the network is an emulation design with reviewed configuration sources.

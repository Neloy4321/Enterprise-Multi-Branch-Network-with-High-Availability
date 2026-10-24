# 🚀 Phase 06 – OSPF Multi-Area Dynamic Routing Infrastructure

> **Original EVE-NG implementation (tested):** The original EVE-NG lab was OSPF-tested, with a [Full neighbor](../images/phase-06/ospf-neighbor-verification.png) and [learned routes](../images/phase-06/routing-table-verification.png). The new source aligns all four WAN circuits with Area 0; a fresh four-link test remains necessary.
>
> **Source version note:** This detailed phase narrative preserves the original lab design, learning steps and screenshots. Some embedded CLI examples describe historical settings. For a clean import of the **October 2026 revised configuration**, use the matching [`configs/*.rsc` files](../configs/README.md), [network decisions](NETWORK-DECISIONS.md), and [rebuild checklist](REBUILD-AND-ACCEPTANCE.md); this revision has not been rerun in EVE-NG.

## 📌 Objective
The primary objective of this phase was to engineer a robust, loop-free, and highly scalable Layer 3 dynamic routing engine across the enterprise fabric by deploying the **Open Shortest Path First (OSPFv2)** routing protocol. This stage focuses on removing the administrative burden of static routes, establishing dynamic neighbor adjacencies across point-to-point transit WAN pipes, segregating link-state updates using a multi-area hierarchical structure, and ensuring during the observed failover (duration not measured) convergence times during unexpected network link failures.

---

## 🏗️ OSPF Hierarchical Multi-Area Architecture Design

To optimize resource utilization and limit the propagation of localized Link-State Advertisements (LSAs), the enterprise network routing engine was structured into three distinct logical OSPF area boundaries:

```text
       [ Area 10: Branch-1 ]                  [ Area 0: Core Backbone ]                 [ Area 20: Branch-2 ]
  BR1-R1 (Local Interface vlan110)   <──>   HQ-R1 & HQ-R2 Core Mesh Transit   <──>   BR2-R1 (Local Interface vlan210)
     [Subnet: 172.16.110.0/24]               [Subnets: 10.0.x.0/30 Transit]             [Subnet: 172.16.210.0/24]
```

* **Area 0 (Core Backbone Domain):** Anchors the physical core of the enterprise network, containing the main corporate routing engines (`HQ-R1`, `HQ-R2`) and all point-to-point WAN transport transit links (`10.0.1.0/30` through `10.0.4.0/30`). All inter-area routing traffic must traverse this backbone area.
* **Area 10 (Branch-1 Stub Boundary Zone):** Confines the local distributed network profiles of Branch-1 (`172.16.110.0/24`). Link-state updates within this zone are kept isolated, protecting local nodes from receiving unnecessary topology metrics from other branches.
* **Area 20 (Branch-2 Stub Boundary Zone):** Confines the local distributed network profiles of Branch-2 (`172.16.210.0/24`). This division isolates local structural adjustments from affecting the Branch-1 zone.

### 📑 Documentation Evidence
#### Figure 1. Hierarchical OSPF Multi-Area Operational Scheme
![OSPF Area Design](../images/phase-06/ospf-area-design.png)
*Complete multi-area structural diagram mapping the backbone transit pipelines and regional routing stubs.*

---

## 🆔 Authoritative Router ID Specification Plan

To eliminate system-wide identifier resource matching collisions and provide clear tracking during OSPF topology debugging, unique 32-bit Router IDs were explicitly assigned to each network layer:

| Operational Site Zone | Infrastructure Device Name | Assigned OSPF Router ID | Primary Area Roles & Boundaries |
| :--- | :--- | :--- | :--- |
| **Corporate HQ** | `HQ-R1` | `1.1.1.1` | Backbone Area 0 Core Node Engine (VRRP Master Master). |
| **Corporate HQ** | `HQ-R2` | `2.2.2.2` | Backbone Area 0 Core Node Engine (VRRP Backup Anchor). |
| **Remote Branch-1** | `BR1-R1` | `11.11.11.11` | Area Border Router (ABR) bridging Area 10 stub links to Area 0. |
| **Remote Branch-2** | `BR2-R1` | `22.22.22.22` | Area Border Router (ABR) bridging Area 20 stub links to Area 0. |

#### 📑 Documentation Evidence
#### Figure 2. Local System Router ID Definitions
![Router ID Configuration](../images/phase-06/router-id-configuration.png)
*Active RouterOS configuration view confirming successful assignment of system loopback IDs.*

---

## 🛠️ RouterOS v7 Production Script Configuration

MikroTik RouterOS v7 introduces a redesigned configuration architecture that replaces legacy commands with explicit dynamic instances, area definitions, and interface network templates.

### 1. Corporate Headquarters Master Core Deployment (`HQ-R1`)
```routeros
# Initialize the primary OSPF instance engine instance
/routing ospf instance
add name=ospf-core-hq router-id=1.1.1.1 version=2

# Create the authoritative Backbone Area 0 configuration
/routing ospf area
add instance=ospf-core-hq name=backbone-area0 area-id=0.0.0.0

# Bind interfaces using production-ready OSPF interface templates
/routing ospf interface-template
# Explicit point-to-point physical WAN connectivity interconnections
add instance=ospf-core-hq area=backbone-area0 interfaces=ether2 network-type=ptp
add instance=ospf-core-hq area=backbone-area0 interfaces=ether3 network-type=ptp
# Passive structural advertisements targeting internal corporate VLAN branches
add instance=ospf-core-hq area=backbone-area0 interfaces=vlan10-HR passive=yes
add instance=ospf-core-hq area=backbone-area0 interfaces=vlan20-SALES passive=yes
add instance=ospf-core-hq area=backbone-area0 interfaces=vlan30-IT passive=yes
add instance=ospf-core-hq area=backbone-area0 interfaces=vlan40-SERVER passive=yes
add instance=ospf-core-hq area=backbone-area0 interfaces=vlan50-MGMT passive=yes
```


### 2. Remote Branch-1 Edge Gateway Deployment (`BR1-R1`)
```routeros
/routing ospf instance add name=ospf-branch1 router-id=11.11.11.11 version=2
/routing ospf area add instance=ospf-branch1 name=backbone-area0 area-id=0.0.0.0
/routing ospf area add instance=ospf-branch1 name=branch1-area10 area-id=0.0.0.10

/routing ospf interface-template
add instance=ospf-branch1 area=backbone-area0 interfaces=ether2 network-type=ptp
add instance=ospf-branch1 area=backbone-area0 interfaces=ether3 network-type=ptp
add instance=ospf-branch1 area=branch1-area10 interfaces=vlan110-USERS passive=yes
```


### 3. Remote Branch-2 Edge Gateway Deployment (`BR2-R1`)
```routeros
/routing ospf instance add name=ospf-branch2 router-id=22.22.22.22 version=2
/routing ospf area add instance=ospf-branch2 name=backbone-area0 area-id=0.0.0.0
/routing ospf area add instance=ospf-branch2 name=branch2-area20 area-id=0.0.0.20

/routing ospf interface-template
add instance=ospf-branch2 area=backbone-area0 interfaces=ether2 network-type=ptp
add instance=ospf-branch2 area=backbone-area0 interfaces=ether3 network-type=ptp
add instance=ospf-branch2 area=branch2-area20 interfaces=vlan210-USERS passive=yes
```


---

## 📑 Documentation Evidence

#### Figure 3. Active Area Network Advertisements Table
![Network Advertisement](../images/phase-06/network-advertisement.png)
*System logs tracking interface templates actively publishing network segments across OSPF domains.*

---

## 🤝 OSPF Neighbor Adjacency Data Verifications

Once the scripts converged, the discovery engine triggered Hello exchange cycles across transit ports. Administrators verified neighbor stability via terminal using `/routing/ospf/neighbor/print`.

```text
# Active RouterOS v7 Neighbor Database Evaluation
/routing ospf neighbor print
Instance       Area             Address          Interface    Router-ID       State
ospf-core-hq   backbone-area0   10.0.1.2         ether2       11.11.11.11     Full
ospf-core-hq   backbone-area0   10.0.2.2         ether3       22.22.22.22     Full
```


An adjacency state of **Full** confirms that neighbor validation routines passed successfully, indicating error-free database synchronization.

---

#### Figure 4. Neighbor Adjacency Verification Interface
![OSPF Neighbor Verification](../images/phase-06/ospf-neighbor-verification.png)
*Live console capture showing successful OSPF neighbor relationships established in a Full state.*

---

## 📊 Dynamic Route Propagation Verification

With link-state databases synchronized, the Dijkstra Shortest Path First (SPF) engine computed optimal paths, dynamically populating the local routing tables.

```text
# Global Inter-Site Forwarding Database Status Check
/ip route print where ospf
Flags: D - DYNAMIC; A - ACTIVE; o - OSPF
   DST-ADDRESS      VALUE-GATEWAY   DISTANCE
DAo 172.16.110.0/24  10.0.1.2%ether2  110
DAo 172.16.210.0/24  10.0.2.2%ether3  110
```


The presence of the `DAo` flag confirms that remote branch networks were dynamically injected into the corporate routing database without requiring any static route entries.

---

#### Figure 5. Dynamic Routing Table Status
![Routing Table Verification](../images/phase-06/routing-table-verification.png)
*Core routing dashboard showing the global routing table populated with dynamically learned OSPF routes.*

---

#### Figure 6. Multi-Site End-to-End Traceroute Capture
![End-to-End Connectivity Test](../images/phase-06/end-to-end-connectivity-test.png)
*Terminal output showing low-latency transit between Branch-1 endhosts and the HQ Server segment.*

---

## 🔍 Validation Matrix

| Target Verification Control Item | Current Status | Technical Metrics / Observations |
| :--- | :--- | :--- |
| **OSPFv2 Engine Daemon Active** | ✅ Validated | RouterOS v7 OSPF core instances initialized with zero syntax alerts. |
| **Unique Router IDs Assigned** | ✅ Validated | Explicit loopback pointers resolved uniquely (`1.1.1.1` - `22.22.22.22`). |
| **Multi-Area Structural Design Active**| ✅ Validated | Branch stubs mapped cleanly to Area 10 and Area 20 boundaries. |
| **Point-to-Point Transit Modes Set** | ✅ Validated | WAN links cabled port-to-port use optimized ptp network templates. |
| **Full Neighbor Adjacency Confirmed** | ✅ Validated | Neighbor databases synchronized cleanly in a stable `Full` state. |
| **Dynamic Path Ingestion Verified** | ✅ Verified | Remote branch networks injected dynamically as `DAo` entries. |
| **Cross-Site Core Ping Sweeps Passed** | ✅ Verified | Multi-branch dynamic transit validated with 0% packet drop metrics. |

---

## 🎯 Phase Outcome
Phase 06 has successfully achieved all complex dynamic routing architecture criteria. The centralized Headquarters campus and remote branch locations are now dynamically linked using a enterprise-style OSPF Multi-Area configuration model. Adjacency tables show stable connectivity states, path updates deploy automatically across transit networks during link changes, and multi-site pings pass all structural tests. The dynamic network engine is fully optimized and prepared for Phase 07, where we will configure Source NAT internet egress access rules on the primary border gateway.

---

## October 2026 — Updated configuration reference

The four numbered WAN links are point-to-point. Their area is **Area 0 on both sides**; unequal area IDs prevent OSPF neighbors from forming.

| Link | HQ side | Branch side | Area |
| --- | --- | --- | --- |
| 10.0.1.0/30 | HQ-R1 ether2 | BR1-R1 ether2 | 0 |
| 10.0.2.0/30 | HQ-R1 ether3 | BR2-R1 ether2 | 0 |
| 10.0.3.0/30 | HQ-R2 ether2 | BR1-R1 ether3 | 0 |
| 10.0.4.0/30 | HQ-R2 ether3 | BR2-R1 ether3 | 0 |

Branch 1 additionally has `area10` (stub) on passive VLAN110. Branch 2 has `area20` (stub) on passive VLAN210. Each branch is therefore an Area Border Router. HQ VLANs are passive in Area 0.

The canonical snippets are in [HQ-R1.rsc](../configs/HQ-R1.rsc), [HQ-R2.rsc](../configs/HQ-R2.rsc), [BR1-R1.rsc](../configs/BR1-R1.rsc), and [BR2-R1.rsc](../configs/BR2-R1.rsc). For example, Branch 1's WAN links now use:

```routeros
/routing ospf area
add instance=ospf-br1 name=area0 area-id=0.0.0.0
add instance=ospf-br1 name=area10 area-id=0.0.0.10 type=stub
/routing ospf interface-template
add area=area0 interfaces=ether2,ether3 type=ptp
add area=area10 interfaces=vlan110-USERS passive=yes
```

On all four routers:

```routeros
/routing ospf neighbor print detail
/routing ospf area print
/ip route print where ospf
```

Expected: four distinct HQ↔branch adjacencies in Full state across the physical links and learned routes for both branch client subnets. Tests must be repeated with each WAN link disabled independently.

**Status:** Source area mismatch corrected. The previous "Full" neighbors shown in older documents are not accepted as proof of the new configuration.

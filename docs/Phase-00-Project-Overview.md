# 🏢 Project Overview – Enterprise Multi-Branch Network with High Availability

## 📌 Introduction
This project showcases the architectural design, implementation, and verification of a highly resilient, enterprise-grade multi-branch network infrastructure simulated inside an **EVE-NG** network emulation platform using **MikroTik RouterOS Cloud Hosted Routers (CHR)**[cite: 1, 2]. 

The production-ready simulation maps a corporate blueprint comprising a centralized **Headquarters (HQ)** and two geographically distributed remote branches interconnected over a redundant Type-2 transport WAN backbone[cite: 1]. Designed in accordance with industry best practices, the network incorporates strategic segmentation, automated resource provisioning, dynamic scaling, robust border translation, strict firewall filter chains, high availability failover mechanisms, and centralized out-of-band logging and clock synchronization services[cite: 1].

---

## 🎯 Core Project Goals

To achieve a resilient corporate infrastructure, the network is built upon eleven primary design objectives:

* **Scalable Hierarchical Architecture:** Construct a standardized, three-site network layout designed to seamlessly adapt to future organizational expansion[cite: 1].
* **Logical Security Zoning:** Implement structural network isolation using IEEE 802.1Q VLAN tags to keep sensitive corporate data securely segmented[cite: 1].
* **Inter-VLAN Communication:** Deploy a centralized Router-on-a-Stick gateway layout on the core infrastructure to route legitimate cross-department traffic[cite: 1].
* **Dynamic Route Propagation:** Eliminate the management overhead of static entries by implementing an **OSPF Multi-Area** dynamic routing fabric[cite: 1].
* **Centralized Automated Provisioning:** Deploy centralized DHCP pools and branch relays to dynamically assign IP parameters to client endpoints[cite: 1].
* **Edge Access Security:** Configure localized Source NAT translation services to securely route all enterprise internet traffic out of a unified perimeter gateway[cite: 1].
* **Granular Traffic Filtering:** Enforce organizational security governance through stateful Firewall Access Control Lists (ACLs) to block unauthorized inter-zone movement[cite: 1].
* **Gateway Redundancy (High Availability):** Remove single points of failure at the core by deploying **VRRP** active/standby gateway routing pairs[cite: 1].
* **Secure Device Management:** Protect administrative configuration access by replacing insecure protocols with encrypted SSH out-of-band management[cite: 1].
* **Centralized Operations Logging:** Implement an authoritative internal **Syslog Server** layer to continuously harvest operational system event notifications[cite: 1].
* **Authoritative Clock Synchronization:** Provision a centralized **NTP Server** instance to guarantee uniform timestamps across all event logs for accurate audit tracking[cite: 1].

---

## 🗺️ Enterprise Topology Framework

The network architecture is physically partitioned into three operational infrastructure sites[cite: 1]:

### 1. Corporate Headquarters (HQ)
The headquarters acts as the authoritative core routing hub, dynamic area boundary, central internet egress zone, and hosting platform for shared corporate application layers[cite: 1].

* **Core Routing Node Engine:** `HQ-R1` (VRRP Master) and `HQ-R2` (VRRP Backup)[cite: 1].
* **Switching Infrastructure:** `CORE-SW1` and `CORE-SW2` interconnected via a local cross-chassis trunk line[cite: 1, 2].
* **Centralized Application Assets:** Deployed inside a dedicated Server Segment, including the `File-SERVER` and the consolidated `SYSLOG-SERVER` / `NTP-SERVER` asset[cite: 1, 2].
* **Department User Profiles:** Structured into 4 core functional departments[cite: 1]:
  * **HR Department:** 20 Target End Users[cite: 1].
  * **Sales Department:** 20 Target End Users[cite: 1].
  * **IT Administration:** 10 Systems/Network Staff Users[cite: 1].
  * **Executive Management:** 5 Core Executive Users[cite: 1].

### 2. Remote Branch Office 1 (Branch-1)
A standard distributed site supporting branch user hosts and localized equipment[cite: 1].
* **Boundary Infrastructure:** `BR1-R1` (Gateway Router) and `BR1-SW1` (L2 Access Switch)[cite: 1].
* **Site Capacity Allocation:** 10 Active Local Users and 1 Networked Office Printer resource[cite: 1].

### 3. Remote Branch Office 2 (Branch-2)
A secondary distributed site structurally mirroring Branch-1 to validate cross-site area scalability[cite: 1].
* **Boundary Infrastructure:** `BR2-R1` (Gateway Router) and `BR2-SW1` (L2 Access Switch)[cite: 1].
* **Site Capacity Allocation:** 10 Active Local Users and 1 Networked Office Printer resource[cite: 1].

---

## 🛠️ Network Inventory Architecture

The physical node layout and interface links configured within the EVE-NG topology schema conform to the following asset mapping structure[cite: 1, 2]:

| Site Location | Node Name | Emulator Node Type | OS Image Version | Physical Interface Link Interconnections |
| :--- | :--- | :--- | :--- | :--- |
| **HQ** | `HQ-R1` | QEMU Appliance | RouterOS v7.21.4 | `eth1` ↔ `CORE-SW1 eth1` \| `eth2` ↔ `BR1-R1 eth2` \| `eth3` ↔ `BR2-R1 eth2` \| `eth4` ↔ `Cloud0 (NAT)`[cite: 1, 2] |
| **HQ** | `HQ-R2` | QEMU Appliance | RouterOS v7.21.4 | `eth1` ↔ `CORE-SW2 eth1` \| `eth2` ↔ `BR1-R1 eth3` \| `eth3` ↔ `BR2-R1 eth3`[cite: 1, 2] |
| **HQ** | `CORE-SW1` | QEMU Appliance | RouterOS v7.21.4 | `eth1` ↔ `HQ-R1 eth1` \| `eth2` ↔ `CORE-SW2 eth2` \| `eth3` ↔ `HR-PCs` \| `eth4` ↔ `Sales-PCs`[cite: 1, 2] |
| **HQ** | `CORE-SW2` | QEMU Appliance | RouterOS v7.21.4 | `eth1` ↔ `HQ-R2 eth1` \| `eth2` ↔ `CORE-SW1 eth2` \| `eth3` ↔ `Server-VLAN (Assets)`[cite: 1, 2] |
| **Branch-1** | `BR1-R1` | QEMU Appliance | RouterOS v7.21.4 | `eth1` ↔ `BR1-SW1 eth1` \| `eth2` ↔ `HQ-R1 eth2` \| `eth3` ↔ `HQ-R2 eth2`[cite: 1, 2] |
| **Branch-1** | `BR1-SW1` | QEMU Appliance | RouterOS v7.21.4 | `eth1` ↔ `BR1-R1 eth1` \| `eth2/eth3` ↔ `Branch Endpoints`[cite: 1, 2] |
| **Branch-2** | `BR2-R1` | QEMU Appliance | RouterOS v7.21.4 | `eth1` ↔ `BR2-SW1 eth1` \| `eth2` ↔ `HQ-R1 eth3` \| `eth3` ↔ `HQ-R2 eth3`[cite: 1, 2] |
| **Branch-2** | `BR2-SW1` | QEMU Appliance | RouterOS v7.21.4 | `eth1` ↔ `BR2-R1 eth1` \| `eth2` ↔ `Branch Endpoints`[cite: 1, 2] |

---

## 🔒 Implemented Network Technologies Matrix

The logical design relies on a multi-layered implementation matrix to govern all traffic within the enterprise[cite: 1]:

```text
  [ User Endpoint Layer ] ──> IEEE 802.1Q VLAN Bridge Filtering (Layer 2 Segmentation)
            │
            ▼
  [ Local Gateway Layer ] ──> VRRP Redundancy + DHCP Centralized Scopes (Layer 2/3 Services)
            │
            ▼
  [ Core Routing Layer ]  ──> OSPF Multi-Area Dynamics + Stateful Firewall Chains (Layer 3 Routing & Security)
            │
            ▼
  [ Border Edge Layer  ]  ──> Source NAT Masquerade Processing (Central Internet Access)
```

* **VLAN Design & Subnet Scheme:** Implements explicit `/24` department isolation scopes (VLAN 10: HR, VLAN 20: Sales, VLAN 30: IT, VLAN 40: Servers, VLAN 50: Management) structured consistently to optimize administrative troubleshooting[cite: 1].
* **Dynamic Routing Blueprint:** The core transport system uses OSPF point-to-point interface templates across Area 0 (Backbone HQ), Area 10 (Branch-1), and Area 20 (Branch-2) to automate dynamic route distribution[cite: 1].
* **Resilient Infrastructure Services:** Integrates active VRRP failover elections that share a virtual default gateway (`172.16.x.254`), stateful drop policies targeting cross-zone intrusions, and internal network tracking mapped cleanly back to centralized Syslog and NTP log configurations[cite: 1].

---

## 🎯 Project Phase Outcome
This project successfully transitions from abstract business requirements to an operational, automated enterprise network lab environment[cite: 1]. By running validated deployment scripts across the custom EVE-NG topology blueprint, the infrastructure actively delivers low-latency inter-vlan routing, dynamic path updates during link failure states, transparent internet access, and comprehensive out-of-band monitoring collection[cite: 1, 2]. The resulting framework forms a clean, production-ready portfolio case study demonstrating real-world network engineering and system administration concepts using MikroTik RouterOS v7 platforms[cite: 1].
```
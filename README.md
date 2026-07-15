<div align="center">

# Enterprise Multi-Branch Network with High Availability

Enterprise-grade network simulation built with **MikroTik RouterOS (CHR)** and **EVE-NG**, demonstrating scalable network design, dynamic routing, security, high availability, and centralized management across a headquarters and multiple branch offices.

![Enterprise Network Topology](topology/Enterprise-Network.png)

![GitHub last commit](https://img.shields.io/github/last-commit/Neloy4321/Enterprise-Multi-Branch-Network-with-High-Availability)
![GitHub repo size](https://img.shields.io/github/repo-size/Neloy4321/Enterprise-Multi-Branch-Network-with-High-Availability)
![GitHub License](https://img.shields.io/github/license/Neloy4321/Enterprise-Multi-Branch-Network-with-High-Availability)
![MikroTik](https://img.shields.io/badge/MikroTik-RouterOS-blue)
![EVE-NG](https://img.shields.io/badge/EVE--NG-Community-green)

</div>

---

# Overview

This project simulates a real-world enterprise network consisting of one Headquarters (HQ) and two Branch Offices. It was developed in **EVE-NG** using **MikroTik CHR** to demonstrate enterprise networking concepts commonly used in production environments.

The implementation focuses on scalability, redundancy, secure management, centralized services, and structured documentation while following enterprise networking best practices.

---

# Project Objectives

- Build a scalable enterprise network architecture
- Segment departments using VLANs
- Enable communication through Inter-VLAN Routing
- Deploy dynamic routing using OSPF Multi-Area
- Automate IP allocation with DHCP
- Provide centralized Internet access using NAT
- Implement enterprise firewall policies
- Eliminate gateway single points of failure using VRRP
- Secure device management with SSH
- Centralize logging using Syslog
- Synchronize network devices using NTP

---

# Enterprise Features

| Feature | Status |
|---------|:------:|
| VLAN Segmentation | ✅ |
| Inter-VLAN Routing | ✅ |
| OSPF Multi-Area Routing | ✅ |
| DHCP | ✅ |
| NAT (Masquerade) | ✅ |
| Firewall / ACL | ✅ |
| VRRP High Availability | ✅ |
| SSH Management | ✅ |
| Centralized Syslog | ✅ |
| Network Time Protocol (NTP) | ✅ |

---

# Network Architecture

## Headquarters

- HQ-R1
- HQ-R2
- CORE-SW1
- CORE-SW2

Departments

- HR
- Sales
- IT
- Management

---

## Branch Offices

### Branch-1

- BR1-R1
- BR1-SW1

### Branch-2

- BR2-R1
- BR2-SW1

---

# Technologies

| Category | Technology |
|-----------|------------|
| Network Emulator | EVE-NG Community Edition |
| Router OS | MikroTik CHR |
| Layer 2 | VLAN |
| Layer 3 | Inter-VLAN Routing |
| Dynamic Routing | OSPF Multi-Area |
| Services | DHCP |
| Internet | NAT |
| Security | Firewall / ACL |
| High Availability | VRRP |
| Remote Management | SSH |
| Monitoring | Syslog |
| Time Synchronization | NTP |

---

# Project Structure

```text
Enterprise-Multi-Branch-Network-with-High-Availability
│
├── assets/
├── configs/
├── docs/
├── images/
├── lab/
├── topology/
│
├── README.md
├── LICENSE
└── .gitignore
```

---

# Project Phases

| Phase | Description |
|---------|-------------|
| Phase 00 | Environment Setup |
| Phase 01 | Network Planning & IP Addressing |
| Phase 02 | Infrastructure Deployment |
| Phase 03 | VLAN Configuration |
| Phase 04 | Inter-VLAN Routing |
| Phase 05 | DHCP Deployment |
| Phase 06 | OSPF Multi-Area Routing |
| Phase 07 | NAT & Internet Connectivity |
| Phase 08 | Firewall & ACL |
| Phase 09 | VRRP High Availability |
| Phase 10 | SSH Remote Management |
| Phase 11 | Centralized Syslog |
| Phase 12 | Network Time Protocol (NTP) |

---

# Repository Contents

## Documentation

The **docs/** directory contains detailed phase-by-phase implementation notes, including:

- Objectives
- Design Decisions
- Configuration
- Verification
- Troubleshooting
- Results

---

## Configuration Files

The **configs/** directory contains RouterOS configuration exports for all routers and switches.

Devices include:

- HQ-R1
- HQ-R2
- CORE-SW1
- CORE-SW2
- BR1-R1
- BR1-SW1
- BR2-R1
- BR2-SW1

---

## Topology

The **topology/** directory contains:

- Enterprise Network Diagram (.drawio)
- PNG Export
- PDF Version

---

## Screenshots

Screenshots are organized by implementation phase inside the **images/** directory.

---

## Lab Files

The complete EVE-NG lab file is available inside the **lab/** directory.

---

# Skills Demonstrated

- Enterprise Network Design
- MikroTik RouterOS
- EVE-NG
- VLAN Implementation
- Inter-VLAN Routing
- OSPF Multi-Area
- DHCP
- NAT
- Firewall & ACL
- VRRP
- SSH
- Syslog
- NTP
- Network Troubleshooting
- Technical Documentation

---

# Future Improvements

Possible future enhancements include:

- IPv6
- BGP
- MPLS
- WireGuard VPN
- Site-to-Site VPN
- Zabbix Monitoring
- The Dude
- Network Automation using Ansible

---

# Author

**Neloy Pramanik Supto**

GitHub: https://github.com/Neloy4321

---

# License

This project is licensed under the MIT License.
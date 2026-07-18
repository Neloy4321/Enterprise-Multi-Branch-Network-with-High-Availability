# Project Overview

## Introduction

This project demonstrates the design and implementation of a complete enterprise network infrastructure using MikroTik RouterOS (CHR) in the EVE-NG network emulation platform.

The simulated environment consists of one Headquarters (HQ) and two geographically distributed branch offices connected through a redundant WAN infrastructure. The network was designed following common enterprise networking principles, focusing on scalability, security, high availability, centralized management, and ease of maintenance.

The implementation covers both Layer 2 and Layer 3 networking technologies, including VLAN segmentation, Inter-VLAN Routing, dynamic routing with OSPF Multi-Area, DHCP, NAT, firewall policies, VRRP gateway redundancy, SSH-based device management, centralized Syslog logging, and Network Time Protocol (NTP).

Throughout the project, each implementation phase was documented with design decisions, configuration procedures, verification methods, troubleshooting steps, and implementation results to provide a structured reference for learning, demonstration, and future maintenance.

---

## Project Goals

The primary objectives of this project are:

- Design a scalable enterprise network architecture.
- Implement logical network segmentation using VLANs.
- Enable communication between VLANs through Layer 3 routing.
- Deploy dynamic routing using OSPF Multi-Area.
- Automate IP address allocation with DHCP.
- Provide centralized Internet connectivity using NAT.
- Secure internal communication using Firewall and ACL policies.
- Improve network availability through VRRP.
- Secure administrative access using SSH.
- Centralize logging with Syslog.
- Synchronize system clocks using NTP.
- Produce professional technical documentation for every implementation phase.

---

## Enterprise Topology

The enterprise network consists of three primary sites:

### Headquarters (HQ)

The headquarters functions as the central network hub and hosts core routing, switching, centralized services, and Internet connectivity.

Devices include:

- HQ-R1
- HQ-R2
- CORE-SW1
- CORE-SW2

Departments:

- HR
- Sales
- IT
- Management

---

### Branch-1

Devices:

- BR1-R1
- BR1-SW1

---

### Branch-2

Devices:

- BR2-R1
- BR2-SW1

---

## Technologies Implemented

The project includes the following enterprise networking technologies:

- VLAN Segmentation
- Inter-VLAN Routing
- OSPF Multi-Area Routing
- DHCP
- NAT
- Firewall / ACL
- VRRP High Availability
- SSH Remote Management
- Centralized Syslog
- Network Time Protocol (NTP)

---

## Project Outcome

The completed implementation demonstrates a scalable and enterprise-oriented network capable of supporting multiple departments and branch offices while maintaining secure communication, dynamic routing, centralized management, and gateway redundancy. The project also serves as a portfolio-ready reference that reflects practical enterprise networking concepts using MikroTik RouterOS and EVE-NG.
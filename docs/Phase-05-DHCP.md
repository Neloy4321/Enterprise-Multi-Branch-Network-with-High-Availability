# Phase 05 – DHCP Configuration

## Objective

The objective of this phase was to implement the Dynamic Host Configuration Protocol (DHCP) service across the enterprise network. DHCP was configured to automate IP address allocation, reduce manual configuration errors, simplify network administration, and ensure consistent network settings for all client devices within each VLAN.

---

# DHCP Overview

In an enterprise environment, manually assigning IP addresses to every client device is inefficient, time-consuming, and prone to configuration errors. As the number of users and departments increases, centralized IP address management becomes essential.

To address this challenge, DHCP services were implemented on the MikroTik routers. Each VLAN received its own dedicated DHCP scope, ensuring that clients automatically receive the correct network configuration based on their VLAN membership.

The DHCP implementation provides:

- Automatic IP address assignment
- Automatic subnet mask allocation
- Default gateway configuration
- DNS server configuration
- Centralized IP management
- Simplified network maintenance

---

# DHCP Design Strategy

The DHCP architecture was designed according to the enterprise VLAN structure prepared during the planning phase.

Each VLAN represents an independent Layer 3 network. Therefore, every VLAN requires its own DHCP address pool and network configuration.

This design ensures that:

- HR users receive addresses only from the HR subnet.
- Sales users receive addresses only from the Sales subnet.
- IT devices receive addresses from the IT subnet.
- Branch users receive addresses only from their respective branch networks.
- Management and Server networks remain logically separated.

The separation of DHCP scopes prevents IP conflicts and improves overall network organization.

---

# DHCP Network Planning

The following DHCP scopes were prepared for enterprise deployment.

| VLAN | Department | DHCP Scope |
|------|------------|------------|
| VLAN 10 | HR | Dedicated HR Address Pool |
| VLAN 20 | Sales | Dedicated Sales Address Pool |
| VLAN 30 | IT | Dedicated IT Address Pool |
| VLAN 40 | Server | Dedicated Server Address Pool |
| VLAN 50 | Management | Dedicated Management Address Pool |
| VLAN 60 | Printer | Dedicated Printer Address Pool |
| VLAN 110 | Branch 01 Users | Dedicated Branch 01 User Pool |
| VLAN 120 | Branch 01 Printer | Dedicated Branch 01 Printer Pool |
| VLAN 210 | Branch 02 Users | Dedicated Branch 02 User Pool |
| VLAN 220 | Branch 02 Printer | Dedicated Branch 02 Printer Pool |

---

# DHCP Server Configuration

A DHCP server was configured for each network segment.

Each DHCP server was associated with:

- Appropriate VLAN interface
- DHCP Address Pool
- Network Gateway
- DNS Server
- Lease Time

This configuration allows devices connected to different VLANs to automatically obtain valid network parameters immediately after joining the network.

### Documentation Evidence

#### Figure 1. DHCP Server Configuration

![DHCP Server Configuration](../images/phase-05/dhcp-server-configuration.png)

*DHCP server configuration on the MikroTik router.*

---

# DHCP Address Pool Configuration

Dedicated address pools were created for every enterprise subnet.

Each pool was designed to:

- Prevent address overlap
- Avoid IP conflicts
- Reserve addresses for infrastructure devices
- Support future network expansion

Using separate address pools ensures efficient utilization of available IP space while maintaining organized address management.

### Documentation Evidence

#### Figure 2. DHCP Address Pool

![DHCP Address Pool](../images/phase-05/dhcp-address-pool.png)

*DHCP address pools configured for enterprise VLANs.*

---

# Gateway and DNS Configuration

Every DHCP scope distributes the required network parameters to connected clients.

These parameters include:

- Default Gateway
- DNS Server
- Network Address
- Subnet Mask
- Lease Duration

Automatically assigning these settings eliminates manual client configuration and reduces deployment time.

### Documentation Evidence

#### Figure 3. Gateway and DNS Configuration

![Gateway and DNS Configuration](../images/phase-05/gateway-dns-configuration.png)

*Gateway and DNS information distributed through DHCP.*

---

# DHCP Lease Verification

After the DHCP servers were configured, client devices requested IP addresses automatically.

Each client successfully received:

- Valid IP Address
- Correct Subnet Mask
- Default Gateway
- DNS Server
- DHCP Lease Information

This confirmed that the DHCP service was operating correctly.

### Documentation Evidence

#### Figure 4. DHCP Lease Verification

![DHCP Lease Verification](../images/phase-05/dhcp-lease-verification.png)

*Verification of dynamically assigned IP addresses.*

---

# Client Connectivity Verification

Connectivity testing was performed after DHCP deployment.

The following tests were completed:

- Client received an IP address automatically.
- Client successfully reached its default gateway.
- Devices within the same VLAN communicated successfully.
- Inter-VLAN communication remained functional.
- No duplicate IP addresses were detected.
- DHCP leases were successfully registered.

These tests confirmed successful DHCP operation throughout the enterprise network.

### Documentation Evidence

#### Figure 5. Client Connectivity Test

![Client Connectivity Test](../images/phase-05/client-connectivity-test.png)

*Verification of client connectivity after DHCP address assignment.*

---

# Enterprise Benefits

Implementing DHCP provides several operational benefits.

| Benefit | Description |
|----------|-------------|
| Centralized IP Management | All client addressing managed automatically |
| Reduced Administrative Overhead | Eliminates manual IP configuration |
| Faster Device Deployment | New devices connect immediately |
| Improved Network Consistency | Standardized client configuration |
| Reduced Human Error | Minimizes addressing mistakes |
| Better Scalability | Supports future enterprise growth |
| Easier Troubleshooting | Centralized lease monitoring |

---

# Phase Verification

The DHCP implementation was verified before proceeding to dynamic routing configuration.

| Verification Item | Status |
|------------------------------|--------|
| DHCP Servers Configured | ✅ |
| Address Pools Created | ✅ |
| Gateway Configuration Verified | ✅ |
| DNS Configuration Verified | ✅ |
| Clients Received IP Addresses | ✅ |
| DHCP Lease Successfully Assigned | ✅ |
| Network Connectivity Verified | ✅ |
| Ready for OSPF Configuration | ✅ |

---

# Outcome

This phase successfully implemented centralized DHCP services across the enterprise network. Dedicated DHCP servers and address pools were configured for every VLAN, allowing client devices to obtain IP addresses and network settings automatically. The implementation significantly simplified network administration, eliminated manual addressing, and ensured consistent IP management across Headquarters and Branch Offices. With automatic address allocation fully operational, the enterprise network was prepared for dynamic routing implementation using OSPF in the next phase.
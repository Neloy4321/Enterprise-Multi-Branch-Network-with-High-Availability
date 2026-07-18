# Phase 02 – Infrastructure Deployment

## Objective

The objective of this phase was to deploy the enterprise network infrastructure inside the EVE-NG virtual environment. This included creating the network topology, deploying all required virtual devices, establishing physical connections, and verifying that the laboratory environment was ready for network configuration in the following phases.

---

# Infrastructure Deployment Overview

After completing the planning and design phase, the enterprise topology was implemented inside the EVE-NG environment. All routers, switches, and client devices were deployed according to the approved network design to ensure a consistent implementation throughout the project.

The infrastructure deployment was performed before applying any routing, switching, or security configurations.

---

# Enterprise Topology Deployment

The first task was to recreate the enterprise network topology inside EVE-NG based on the design prepared during the planning phase.

The topology consists of:

- Headquarters (HQ)
- Branch Office 01
- Branch Office 02
- Core Switching Infrastructure
- Access Layer
- Client Devices
- Internet Connection

Each device was positioned according to the enterprise design to improve readability and simplify future troubleshooting.

### Documentation Evidence

#### Figure 1. Enterprise Topology Deployment

![Enterprise Topology Deployment](../images/phase-02/enterprise-topology-deployment.png)

*Enterprise network topology deployed inside the EVE-NG environment.*

---

# Deploying MikroTik Routers

The required MikroTik CHR routers were added to the topology.

The deployed routers included:

| Device | Purpose |
|---------|---------|
| HQ-R1 | Headquarters Router |
| BR1-R1 | Branch Office 01 Router |
| BR2-R1 | Branch Office 02 Router |

Each router was placed according to the planned topology to maintain a structured enterprise network layout.

### Documentation Evidence

#### Figure 2. Router Deployment

![Router Deployment](../images/phase-02/router-deployment.png)

*Deployment of MikroTik CHR routers inside the EVE-NG topology.*

---

# Deploying Switching Infrastructure

Core and access switches were deployed to provide Layer 2 connectivity between routers and end-user devices.

The switching infrastructure was prepared for future VLAN implementation and Inter-VLAN routing.

### Documentation Evidence

#### Figure 3. Switch Deployment

![Switch Deployment](../images/phase-02/switch-deployment.png)

*Deployment of core and access switches.*

---

# Deploying End Devices

Virtual PC (VPCS) devices were added to simulate enterprise users.

These client devices will later be used to verify:

- DHCP
- Inter-VLAN Routing
- OSPF Connectivity
- Internet Access
- Firewall Policies
- High Availability

### Documentation Evidence

#### Figure 4. Client Device Deployment

![Client Device Deployment](../images/phase-02/client-device-deployment.png)

*Virtual client devices deployed within the enterprise topology.*

---

# Physical Link Configuration

After deploying all devices, the required network links were created according to the enterprise design.

Connections were established between:

- Headquarters Router and Core Switch
- Headquarters Router and Branch Router 01
- Headquarters Router and Branch Router 02
- Branch Routers and Access Switches
- Switches and Client Devices
- Headquarters Router and Internet

The physical connectivity was verified before proceeding to device configuration.

### Documentation Evidence

#### Figure 5. Physical Connections

![Physical Connections](../images/phase-02/physical-connections.png)

*Physical links established between enterprise network devices.*

---

# Initial Topology Verification

After completing the deployment, the topology was reviewed to verify that every device had been added correctly and all required links were connected.

The following checks were performed before continuing to the configuration phase:

- All routers successfully deployed
- All switches successfully deployed
- Client devices added
- Required links connected
- No disconnected interfaces
- Enterprise topology matched the original network design

### Documentation Evidence

#### Figure 6. Completed Infrastructure

![Completed Infrastructure](../images/phase-02/completed-infrastructure.png)

*Completed enterprise infrastructure inside the EVE-NG laboratory.*

---

# Phase Verification

The infrastructure deployment was verified before beginning network configuration.

| Verification Item | Status |
|------------------------------|--------|
| Enterprise Topology Created | ✅ |
| HQ Router Deployed | ✅ |
| Branch Routers Deployed | ✅ |
| Switching Infrastructure Ready | ✅ |
| Client Devices Added | ✅ |
| Physical Connections Completed | ✅ |
| Topology Verified | ✅ |
| Ready for Network Configuration | ✅ |

---

# Outcome

This phase successfully deployed the complete enterprise network infrastructure within the EVE-NG virtual environment. All routers, switches, and client devices were added according to the planned topology, and the required physical connections were established and verified. With the infrastructure fully prepared, the environment was ready for the configuration of VLANs, routing, IP addressing, and enterprise network services in the subsequent phases.
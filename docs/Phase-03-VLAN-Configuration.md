# Phase 03 – VLAN Configuration

## Objective

The objective of this phase was to implement Virtual Local Area Networks (VLANs) across the enterprise network to provide logical segmentation between different departments. VLAN implementation improves network performance, enhances security, reduces broadcast traffic, and simplifies network management.

---

# VLAN Design Overview

Based on the enterprise network design, separate VLANs were created for each department and branch office. This approach ensures that devices belonging to different departments operate within isolated broadcast domains while still allowing controlled communication through Inter-VLAN Routing.

The VLAN structure was planned to support future expansion without requiring major network redesign.

---

# Headquarters VLAN Configuration

The Headquarters network contains multiple departments. A dedicated VLAN was assigned to each department to separate user traffic and improve security.

| VLAN ID | Department |
|----------|------------|
| 10 | HR |
| 20 | Sales |
| 30 | IT |
| 40 | Server |
| 50 | Management |
| 60 | Printer |

### Documentation Evidence

#### Figure 1. Headquarters VLAN Configuration

![Headquarters VLAN Configuration](../images/phase-03/hq-vlan-configuration.png)

*Configured VLANs for the Headquarters network.*

---

# Branch Office VLAN Configuration

Separate VLANs were configured for each branch office to isolate users and network resources.

### Branch Office 01

| VLAN ID | Department |
|----------|------------|
| 110 | Users |
| 120 | Printer |

### Branch Office 02

| VLAN ID | Department |
|----------|------------|
| 210 | Users |
| 220 | Printer |

### Documentation Evidence

#### Figure 2. Branch VLAN Configuration

![Branch VLAN Configuration](../images/phase-03/branch-vlan-configuration.png)

*Configured VLANs for Branch Office 01 and Branch Office 02.*

---

# Access Port Configuration

Switch access ports were assigned to their respective VLANs based on the department or device connected to each interface.

This configuration ensures that end-user devices automatically become members of the appropriate VLAN when connected.

### Documentation Evidence

#### Figure 3. Access Port Configuration

![Access Port Configuration](../images/phase-03/access-port-configuration.png)

*Configuration of access ports for departmental VLANs.*

---

# Trunk Port Configuration

Trunk links were configured between routers and switches to allow multiple VLANs to traverse a single physical connection.

The trunk configuration enables VLAN traffic to be transported across the enterprise network while preserving VLAN separation.

### Documentation Evidence

#### Figure 4. Trunk Port Configuration

![Trunk Port Configuration](../images/phase-03/trunk-port-configuration.png)

*Trunk links configured between networking devices.*

---

# VLAN Verification

After completing the VLAN configuration, verification was performed to ensure that:

- All VLANs were successfully created.
- Access ports were assigned correctly.
- Trunk links were operational.
- VLAN information appeared correctly in the switch configuration.
- The VLAN design matched the enterprise planning document.

### Documentation Evidence

#### Figure 5. VLAN Verification

![VLAN Verification](../images/phase-03/vlan-verification.png)

*Verification of VLAN configuration on enterprise switches.*

---

# Benefits of VLAN Implementation

The implemented VLAN design provides several advantages for the enterprise network.

- Improved network security through traffic isolation.
- Reduced broadcast traffic.
- Simplified network administration.
- Better overall network performance.
- Scalable architecture for future departmental expansion.
- Efficient traffic management across multiple branches.

---

# Phase Verification

The VLAN implementation was verified before proceeding to the routing configuration.

| Verification Item | Status |
|-------------------------------|--------|
| HQ VLANs Created | ✅ |
| Branch VLANs Created | ✅ |
| Access Ports Assigned | ✅ |
| Trunk Ports Configured | ✅ |
| VLAN Database Verified | ✅ |
| Enterprise VLAN Structure Completed | ✅ |
| Ready for Inter-VLAN Routing | ✅ |

---

# Outcome

This phase successfully implemented VLAN segmentation across the enterprise network. Separate VLANs were created for each department and branch office, access and trunk ports were configured, and the VLAN design was verified successfully. The network was now logically segmented and prepared for Inter-VLAN Routing in the next phase.
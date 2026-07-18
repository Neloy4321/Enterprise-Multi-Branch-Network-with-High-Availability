# Phase 04 – Inter-VLAN Routing

## Objective

The objective of this phase was to enable communication between different VLANs within the enterprise network. Since each VLAN operates as an independent broadcast domain, Inter-VLAN Routing was configured to allow controlled communication while maintaining network segmentation.

---

# Inter-VLAN Routing Overview

After completing VLAN implementation, devices located in different VLANs were unable to communicate directly because each VLAN represents a separate Layer 3 network.

To solve this issue, Inter-VLAN Routing was configured on the MikroTik routers. Each VLAN was assigned a dedicated Layer 3 gateway, allowing traffic to be routed securely between VLANs.

---

# Router Interface Preparation

The router interfaces connected to the switching infrastructure were prepared to support multiple VLANs.

Sub-interfaces were configured to serve as default gateways for each VLAN while maintaining proper VLAN separation.

### Documentation Evidence

#### Figure 1. Router Interface Configuration

![Router Interface Configuration](../images/phase-04/router-interface-configuration.png)

*Router interfaces prepared for Inter-VLAN Routing.*

---

# VLAN Gateway Configuration

Each VLAN was assigned its own gateway address to enable communication with other VLANs.

The gateway addresses act as the default route for devices within their respective VLANs.

### Documentation Evidence

#### Figure 2. VLAN Gateway Configuration

![VLAN Gateway Configuration](../images/phase-04/vlan-gateway-configuration.png)

*Gateway configuration for all enterprise VLANs.*

---

# Inter-VLAN Routing Implementation

Routing was configured between all enterprise VLANs to allow authorized communication while preserving logical network segmentation.

This configuration enables departments to exchange data without removing VLAN isolation.

### Documentation Evidence

#### Figure 3. Inter-VLAN Routing Configuration

![Inter-VLAN Routing Configuration](../images/phase-04/inter-vlan-routing-configuration.png)

*Inter-VLAN Routing configured on MikroTik routers.*

---

# Connectivity Verification

After the routing configuration was completed, connectivity tests were performed between devices located in different VLANs.

The following verification confirmed successful implementation:

- Devices successfully reached their default gateway.
- Communication between different VLANs was successful.
- No routing errors were observed.
- Gateway interfaces were operational.

### Documentation Evidence

#### Figure 4. Inter-VLAN Connectivity Test

![Inter-VLAN Connectivity Test](../images/phase-04/inter-vlan-connectivity-test.png)

*Successful communication between devices located in different VLANs.*

---

# Routing Verification

Additional verification was performed to confirm that all VLAN interfaces were operational and correctly associated with their respective IP networks.

### Documentation Evidence

#### Figure 5. Routing Verification

![Routing Verification](../images/phase-04/routing-verification.png)

*Verification of Layer 3 interfaces and routing configuration.*

---

# Benefits of Inter-VLAN Routing

The implemented routing solution provides several enterprise advantages.

- Enables communication between departments.
- Maintains logical VLAN separation.
- Supports centralized network services.
- Improves scalability.
- Simplifies enterprise network management.
- Provides the foundation for DHCP, OSPF, NAT, and security policies.

---

# Phase Verification

The Inter-VLAN Routing implementation was verified before proceeding to DHCP configuration.

| Verification Item | Status |
|------------------------------|--------|
| Router Interfaces Configured | ✅ |
| VLAN Gateways Configured | ✅ |
| Inter-VLAN Routing Enabled | ✅ |
| Gateway Reachability Verified | ✅ |
| Cross-VLAN Communication Successful | ✅ |
| Layer 3 Connectivity Verified | ✅ |
| Ready for DHCP Configuration | ✅ |

---

# Outcome

This phase successfully enabled Layer 3 communication between all enterprise VLANs. Dedicated gateway interfaces were configured for each VLAN, allowing secure communication across different network segments while preserving logical isolation. The enterprise network was now prepared for automatic IP address allocation using DHCP in the next phase.
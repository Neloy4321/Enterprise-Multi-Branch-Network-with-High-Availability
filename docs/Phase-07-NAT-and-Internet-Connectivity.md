# Phase 07 – NAT and Internet Connectivity

## Objective

The objective of this phase was to provide Internet connectivity for all enterprise networks using Network Address Translation (NAT). NAT was implemented to translate private IP addresses into a public address, allowing internal devices from Headquarters and Branch Offices to communicate with external networks while preserving the security of the internal addressing scheme.

---

# NAT Overview

All enterprise devices were configured with private IP addresses that are not routable over the public Internet. Although internal communication between Headquarters and Branch Offices was already established through OSPF, users still required Internet access for external communication.

To achieve this, Network Address Translation (NAT) was configured on the Headquarters router. NAT enables multiple internal devices to share a single public IP address when accessing external networks.

This implementation provides:

- Internet connectivity for all internal users.
- Address translation from private to public networks.
- Efficient utilization of public IP addresses.
- Additional protection by hiding internal addressing.
- Simplified Internet access management.

---

# NAT Design Strategy

The Headquarters router was selected as the Internet gateway because it serves as the central point connecting the enterprise network to external networks.

All traffic generated from Headquarters and Branch Offices is forwarded to the Headquarters router, where NAT is performed before the traffic leaves the enterprise network.

This centralized architecture offers several advantages:

- Simplified Internet management.
- Easier troubleshooting.
- Centralized security enforcement.
- Scalable enterprise design.
- Reduced configuration complexity.

---

# Internet Gateway Configuration

Before configuring NAT, the Internet-facing interface on the Headquarters router was verified.

The gateway router performs two primary functions:

- Internal routing using OSPF.
- External communication through the ISP connection.

This dual role allows the Headquarters router to serve as the enterprise edge router.

### Documentation Evidence

#### Figure 1. Internet Gateway Configuration

![Internet Gateway Configuration](../images/phase-07/internet-gateway-configuration.png)

*Configuration of the Internet-facing interface on the Headquarters router.*

---

# Source NAT Configuration

Source NAT (Masquerade) was implemented to translate private enterprise addresses into the public IP assigned to the Headquarters router.

Masquerade was selected because:

- It is recommended for dynamic public IP environments.
- Configuration is simple.
- It automatically adjusts if the public IP changes.
- It is widely used in MikroTik enterprise deployments.

This configuration ensures that all internal traffic leaving the enterprise network is translated correctly before reaching the Internet.

### Documentation Evidence

#### Figure 2. Source NAT Configuration

![Source NAT Configuration](../images/phase-07/source-nat-configuration.png)

*Masquerade rule configured on the Headquarters router.*

---

# Traffic Flow Verification

After configuring NAT, packet flow was verified to confirm successful address translation.

The verification confirmed the following traffic path:

1. Client device generates traffic.
2. Traffic reaches the local default gateway.
3. OSPF forwards the packet to Headquarters.
4. Headquarters performs Source NAT.
5. Traffic exits toward the Internet.
6. Return traffic is translated back to the original client.

This confirms that communication between internal devices and external networks functions correctly.

### Documentation Evidence

#### Figure 3. NAT Traffic Flow

![NAT Traffic Flow](../images/phase-07/nat-traffic-flow.png)

*Verification of packet flow through the NAT process.*

---

# Internet Connectivity Testing

After NAT implementation, Internet connectivity tests were performed from multiple enterprise locations.

The following tests confirmed successful operation:

- Headquarters users accessed external networks.
- Branch Office 01 users accessed the Internet.
- Branch Office 02 users accessed the Internet.
- Private IP addresses remained hidden.
- External communication completed successfully.

The successful tests verified that NAT was functioning correctly across the enterprise network.

### Documentation Evidence

#### Figure 4. Internet Connectivity Test

![Internet Connectivity Test](../images/phase-07/internet-connectivity-test.png)

*Successful Internet connectivity from enterprise client devices.*

---

# NAT Translation Verification

The NAT translation table was monitored to verify that active sessions were being translated correctly.

The verification confirmed:

- Source address translation.
- Active translation entries.
- Correct outbound interface.
- Successful return traffic.

Monitoring the translation table also assists in troubleshooting Internet connectivity issues.

### Documentation Evidence

#### Figure 5. NAT Translation Table

![NAT Translation Table](../images/phase-07/nat-translation-table.png)

*Verification of active NAT translation entries.*

---

# Benefits of NAT Implementation

The implemented NAT solution provides several enterprise advantages.

| Benefit | Description |
|----------|-------------|
| Internet Connectivity | Enables enterprise users to access external networks |
| Address Conservation | Multiple clients share a single public IP |
| Enhanced Security | Internal IP addresses remain hidden |
| Centralized Gateway | Internet access managed from Headquarters |
| Scalable Design | Supports future network expansion |
| Simplified Administration | Easy to maintain and troubleshoot |
| Enterprise Compatibility | Standard deployment for MikroTik enterprise networks |

---

# Phase Verification

The NAT implementation was verified before proceeding to enterprise security configuration.

| Verification Item | Status |
|------------------------------|--------|
| Internet Gateway Configured | ✅ |
| Source NAT Configured | ✅ |
| Masquerade Rule Verified | ✅ |
| Traffic Translation Successful | ✅ |
| NAT Table Verified | ✅ |
| Headquarters Internet Access Verified | ✅ |
| Branch Internet Access Verified | ✅ |
| Ready for Firewall & ACL Configuration | ✅ |

---

# Outcome

This phase successfully implemented Network Address Translation (NAT) for the enterprise network. The Headquarters router was configured as the central Internet gateway, translating private enterprise addresses into a public address using Source NAT (Masquerade). Internet connectivity was successfully verified for Headquarters and Branch Offices, while internal addressing remained protected. With secure Internet access established, the enterprise network was ready for the implementation of Firewall and Access Control List (ACL) policies in the next phase.
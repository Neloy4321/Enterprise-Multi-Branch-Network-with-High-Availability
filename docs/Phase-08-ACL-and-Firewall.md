# Phase 08 – Firewall and ACL

## Objective

The objective of this phase was to enhance the security of the enterprise network by implementing Firewall Filters and Access Control Lists (ACLs). These security mechanisms were configured to control network traffic, protect internal resources, prevent unauthorized access, and ensure that only legitimate communication was permitted across the enterprise infrastructure.

---

# Security Overview

After implementing VLANs, Inter-VLAN Routing, DHCP, OSPF, and Internet connectivity, the enterprise network was fully operational. However, unrestricted communication between networks and unrestricted access from external sources could expose the infrastructure to security threats.

To strengthen the network, Firewall Filters and Access Control Lists (ACLs) were implemented on the MikroTik routers. These security policies inspect network traffic and determine whether packets should be accepted, rejected, or dropped based on predefined rules.

The implementation provides:

- Protection against unauthorized access.
- Controlled communication between network segments.
- Improved network security.
- Centralized traffic management.
- Secure Internet access.
- Reduced attack surface.

---

# Security Design Strategy

The firewall architecture was designed using a layered security approach.

Instead of allowing unrestricted communication, traffic was evaluated according to enterprise security policies. Only authorized traffic was permitted while unnecessary or potentially harmful traffic was blocked.

The security implementation focused on:

- Protecting the Headquarters network.
- Restricting unauthorized access from external networks.
- Allowing legitimate internal communication.
- Securing management interfaces.
- Maintaining normal enterprise operations.

This design follows standard enterprise network security practices and provides a scalable foundation for future policy expansion.

---

# Firewall Rule Configuration

Firewall Filter Rules were created to inspect incoming, outgoing, and forwarded traffic.

The configured rules perform tasks such as:

- Allowing established connections.
- Allowing related connections.
- Dropping invalid packets.
- Blocking unauthorized access attempts.
- Filtering unwanted traffic.
- Protecting router management services.

The rules were arranged according to best practices so that legitimate traffic is processed efficiently before restrictive rules are applied.

### Documentation Evidence

#### Figure 1. Firewall Filter Rules

![Firewall Filter Rules](../images/phase-08/firewall-filter-rules.png)

*Firewall filter rules configured on the MikroTik router.*

---

# Access Control Policy

Access Control Lists were implemented to regulate communication between network segments and administrative services.

The ACL policy was designed to ensure that:

- Authorized users could access required services.
- Management traffic remained protected.
- Unnecessary communication was restricted.
- Network resources remained secure.

By enforcing access policies, the enterprise network reduces the possibility of unauthorized communication while maintaining business operations.

### Documentation Evidence

#### Figure 2. Access Control Configuration

![Access Control Configuration](../images/phase-08/access-control-configuration.png)

*ACL policies implemented for enterprise traffic control.*

---

# Management Access Protection

Administrative access to enterprise networking devices was secured using dedicated firewall rules.

Only trusted management traffic was permitted to access router management services, reducing the risk of unauthorized configuration changes.

Security measures included:

- Restricting management access.
- Filtering unnecessary management requests.
- Protecting router administrative interfaces.
- Preventing unauthorized login attempts.

### Documentation Evidence

#### Figure 3. Management Access Protection

![Management Access Protection](../images/phase-08/management-access-protection.png)

*Firewall rules protecting administrative access to enterprise devices.*

---

# Traffic Filtering Verification

After implementing the firewall policies, multiple connectivity tests were performed to verify that security rules operated correctly.

The verification confirmed:

- Authorized traffic passed successfully.
- Blocked traffic was denied.
- Established connections continued without interruption.
- Internal enterprise communication remained functional.
- Internet connectivity continued to operate normally.

These tests verified that security controls were functioning without negatively affecting normal business traffic.

### Documentation Evidence

#### Figure 4. Traffic Filtering Verification

![Traffic Filtering Verification](../images/phase-08/traffic-filtering-verification.png)

*Verification of firewall traffic filtering.*

---

# Firewall Rule Validation

Additional verification was performed to ensure that firewall rules were processed correctly and matched the intended enterprise security policy.

The validation included:

- Rule ordering.
- Packet counters.
- Rule matching.
- Drop statistics.
- Allowed traffic verification.

Monitoring firewall statistics provides valuable information for troubleshooting and future security optimization.

### Documentation Evidence

#### Figure 5. Firewall Rule Validation

![Firewall Rule Validation](../images/phase-08/firewall-rule-validation.png)

*Validation of firewall rule operation and packet counters.*

---

# Enterprise Security Benefits

The implemented firewall and ACL policies provide several operational advantages.

| Benefit | Description |
|----------|-------------|
| Access Control | Restricts unauthorized communication |
| Network Protection | Prevents unwanted traffic |
| Management Security | Protects administrative interfaces |
| Traffic Inspection | Monitors packet flow |
| Layered Security | Multiple protection mechanisms |
| Centralized Policy Enforcement | Security managed from Headquarters |
| Scalable Security | Supports future enterprise growth |

---

# Phase Verification

The Firewall and ACL implementation was verified before proceeding to High Availability configuration.

| Verification Item | Status |
|------------------------------|--------|
| Firewall Rules Configured | ✅ |
| ACL Policies Applied | ✅ |
| Management Access Protected | ✅ |
| Authorized Traffic Allowed | ✅ |
| Unauthorized Traffic Blocked | ✅ |
| Internet Connectivity Maintained | ✅ |
| Security Policy Verified | ✅ |
| Ready for VRRP High Availability | ✅ |

---

# Outcome

This phase successfully enhanced the security of the enterprise network through the implementation of Firewall Filter Rules and Access Control Lists (ACLs). The configured security policies protected network resources, restricted unauthorized access, secured management interfaces, and maintained uninterrupted communication for legitimate users. With a secure enterprise infrastructure established, the network was fully prepared for High Availability implementation using Virtual Router Redundancy Protocol (VRRP) in the next phase.
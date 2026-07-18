# Troubleshooting Guide

## Overview

This document provides a collection of common issues that may occur during the deployment and operation of the **Enterprise Multi-Branch Network with High Availability** project. Each section describes the symptoms, possible causes, troubleshooting steps, and recommended solutions.

The guide is intended to assist network administrators in quickly identifying and resolving operational problems within the enterprise environment.

---

# Troubleshooting Methodology

When diagnosing network issues, the following troubleshooting approach was used throughout the project.

1. Verify physical connectivity.
2. Check interface status.
3. Verify IP addressing.
4. Test VLAN configuration.
5. Verify routing.
6. Check firewall policies.
7. Review system logs.
8. Confirm service status.
9. Perform end-to-end connectivity tests.
10. Document the resolution.

---

# Issue 1 – Interface Down

## Symptoms

- Device unreachable.
- Link indicator is down.
- No packet transmission.

## Possible Causes

- Disconnected cable.
- Disabled interface.
- Incorrect interface assignment.
- Virtual link disconnected.

## Solution

- Verify cable connections.
- Enable the interface.
- Check interface configuration.
- Confirm interface status.

---

# Issue 2 – Client Does Not Receive IP Address

## Symptoms

- No IP address assigned.
- APIPA address displayed.
- Unable to reach gateway.

## Possible Causes

- DHCP service disabled.
- Incorrect DHCP pool.
- Wrong VLAN assignment.
- DHCP interface mismatch.

## Solution

- Verify DHCP Server.
- Check address pool.
- Verify VLAN membership.
- Renew DHCP lease.

---

# Issue 3 – Incorrect Default Gateway

## Symptoms

- Local communication works.
- Internet unavailable.
- Remote networks unreachable.

## Possible Causes

- Incorrect DHCP option.
- Wrong gateway configured manually.

## Solution

- Verify DHCP gateway option.
- Check router interface address.
- Renew client configuration.

---

# Issue 4 – VLAN Communication Failure

## Symptoms

- Devices in same VLAN communicate.
- Devices in different VLAN cannot communicate.

## Possible Causes

- Missing VLAN interface.
- Incorrect switch configuration.
- Inter-VLAN routing disabled.

## Solution

- Verify VLAN interfaces.
- Check switch ports.
- Verify router configuration.

---

# Issue 5 – OSPF Neighbor Not Forming

## Symptoms

- No OSPF neighbors.
- Missing routes.

## Possible Causes

- Wrong Area ID.
- Network mismatch.
- Interface disabled.
- Authentication mismatch.

## Solution

- Verify Area configuration.
- Check advertised networks.
- Confirm interface status.
- Restart OSPF if necessary.

---

# Issue 6 – Missing Dynamic Routes

## Symptoms

- Routing table incomplete.
- Remote networks unreachable.

## Possible Causes

- Neighbor failure.
- Incorrect network advertisement.

## Solution

- Verify neighbors.
- Check routing table.
- Reconfigure advertised networks.

---

# Issue 7 – Internet Not Working

## Symptoms

- Internal communication works.
- External communication fails.

## Possible Causes

- NAT disabled.
- Gateway unreachable.
- ISP interface down.

## Solution

- Verify NAT rule.
- Check default route.
- Test Internet interface.

---

# Issue 8 – NAT Translation Failure

## Symptoms

- Private addresses appear externally.
- Internet inaccessible.

## Possible Causes

- Missing masquerade rule.
- Wrong outbound interface.

## Solution

- Verify Source NAT.
- Confirm outbound interface.
- Check NAT counters.

---

# Issue 9 – Firewall Blocking Valid Traffic

## Symptoms

- Unexpected packet drops.
- Service interruption.

## Possible Causes

- Incorrect firewall order.
- Wrong matching conditions.

## Solution

- Review firewall rules.
- Move allow rules above drop rules.
- Check packet counters.

---

# Issue 10 – Unauthorized Traffic Allowed

## Symptoms

- Security policy bypassed.

## Possible Causes

- Missing firewall rule.
- Incorrect ACL.

## Solution

- Review policy.
- Verify rule order.
- Apply least privilege principle.

---

# Issue 11 – VRRP Failover Does Not Occur

## Symptoms

- Gateway unavailable after router failure.

## Possible Causes

- VRRP disabled.
- Incorrect priority.
- VRID mismatch.

## Solution

- Verify VRRP configuration.
- Check priorities.
- Verify advertisements.

---

# Issue 12 – SSH Login Failure

## Symptoms

- Remote login rejected.

## Possible Causes

- SSH disabled.
- Wrong credentials.
- Firewall restriction.

## Solution

- Enable SSH.
- Verify administrator account.
- Check firewall rules.

---

# Issue 13 – Syslog Server Not Receiving Logs

## Symptoms

- No remote log entries.

## Possible Causes

- Wrong server address.
- Logging action disabled.
- Network connectivity problem.

## Solution

- Verify Syslog IP.
- Check logging rules.
- Test connectivity.

---

# Issue 14 – Incorrect Log Time

## Symptoms

- Log timestamps inconsistent.

## Possible Causes

- NTP not synchronized.
- Incorrect timezone.

## Solution

- Verify NTP server.
- Check system clock.
- Configure timezone.

---

# Issue 15 – NTP Synchronization Failure

## Symptoms

- Clock drift.
- Unsynchronized devices.

## Possible Causes

- NTP server unreachable.
- Incorrect configuration.

## Solution

- Verify server IP.
- Test connectivity.
- Restart NTP client.

---

# Issue 16 – High CPU Usage

## Symptoms

- Slow router response.
- Increased latency.

## Possible Causes

- Routing instability.
- Excessive logging.
- Broadcast traffic.

## Solution

- Monitor CPU usage.
- Review routing.
- Optimize firewall rules.

---

# Issue 17 – High Memory Usage

## Symptoms

- Router becomes slow.

## Possible Causes

- Large routing table.
- Excessive logs.

## Solution

- Clear unnecessary logs.
- Review running services.

---

# Issue 18 – Packet Loss

## Symptoms

- Ping failure.
- Slow communication.

## Possible Causes

- Congestion.
- Faulty interface.
- Routing instability.

## Solution

- Verify interfaces.
- Monitor bandwidth.
- Review routing.

---

# Issue 19 – DNS Resolution Failure

## Symptoms

- IP ping works.
- Domain names fail.

## Possible Causes

- Incorrect DNS server.
- DNS unreachable.

## Solution

- Verify DNS configuration.
- Test DNS connectivity.

---

# Issue 20 – Duplicate IP Address

## Symptoms

- Intermittent connectivity.
- IP conflict warnings.

## Possible Causes

- Static IP conflict.
- DHCP overlap.

## Solution

- Check DHCP pools.
- Remove duplicate addresses.

---

# Issue 21 – Configuration Lost After Reboot

## Symptoms

- Router returns to old configuration.

## Possible Causes

- Configuration not saved.

## Solution

- Save configuration.
- Create backup exports.

---

# Issue 22 – Slow Network Performance

## Symptoms

- High latency.
- Slow response.

## Possible Causes

- Routing loops.
- High utilization.
- Interface errors.

## Solution

- Review topology.
- Check routing.
- Verify interfaces.

---

# Issue 23 – Unable to Access Router Management

## Symptoms

- WinBox or SSH unavailable.

## Possible Causes

- Firewall restriction.
- Wrong management IP.
- Interface disabled.

## Solution

- Verify management address.
- Check firewall.
- Test interface.

---

# Issue 24 – Branch Office Cannot Reach Headquarters

## Symptoms

- Remote office disconnected.

## Possible Causes

- OSPF failure.
- WAN interface down.
- Routing issue.

## Solution

- Verify WAN interfaces.
- Check OSPF neighbors.
- Review routing table.

---

# Issue 25 – Headquarters Cannot Reach Branch Office

## Symptoms

- HQ loses connectivity.

## Possible Causes

- Branch router offline.
- Missing routes.
- Firewall restriction.

## Solution

- Verify branch router.
- Check routing.
- Review firewall rules.

---

# Troubleshooting Tools

The following tools were frequently used during deployment and testing.

| Tool | Purpose |
|------|----------|
| Ping | Verify connectivity |
| Traceroute | Identify routing path |
| Interface Monitor | Verify interface status |
| Routing Table | Check learned routes |
| OSPF Neighbor Table | Verify adjacency |
| DHCP Lease Table | Verify IP assignment |
| Firewall Counters | Analyze packet filtering |
| NAT Table | Verify address translation |
| Syslog | Review system events |
| NTP Status | Verify time synchronization |

---

# Best Practices

To minimize operational issues, the following best practices were followed throughout the project:

- Document every configuration change.
- Maintain regular configuration backups.
- Use descriptive device names.
- Verify configurations after each phase.
- Test before deploying additional services.
- Monitor router resources regularly.
- Secure administrative access using SSH.
- Review firewall logs periodically.
- Synchronize all devices using NTP.
- Keep enterprise documentation up to date.

---

# Conclusion

This troubleshooting guide serves as a practical reference for diagnosing and resolving common issues encountered during the deployment and operation of the enterprise network. By following a structured troubleshooting methodology and applying the recommended solutions, administrators can quickly restore normal network operation while maintaining the reliability, security, and availability of the enterprise infrastructure.
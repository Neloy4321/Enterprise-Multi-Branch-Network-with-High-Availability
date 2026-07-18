# Enterprise Multi-Branch Network with High Availability - Device Configurations

This directory contains the production-ready RouterOS v7 configuration scripts (`.rsc`) strictly mapped to the project infrastructure requirements[cite: 1].

## 📂 Directory Structure
* `HQ-R1.rsc` / `HQ-R2.rsc`: Dual core gateway routers handling VRRP failover, OSPF area boundaries, Firewall/ACL filters, and automated DHCP leases[cite: 1].
* `BR1-R1.rsc` / `BR2-R1.rsc`: Branch boundary nodes managing localized subnets and OSPF adjacency[cite: 1].
* `CORE-SW1.rsc` / `CORE-SW2.rsc`: Corporate core switching fabrics utilizing RouterOS Bridge VLAN Filtering (IEEE 802.1Q)[cite: 1].
* `BR1-SW1.rsc` / `BR2-SW1.rsc`: Edge multi-port access switches[cite: 1].
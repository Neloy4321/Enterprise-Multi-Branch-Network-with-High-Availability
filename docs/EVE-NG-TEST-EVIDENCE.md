# EVE-NG implementation and test evidence

**Original implementation: tested in EVE-NG.** The author built and exercised the original MikroTik enterprise lab and committed screenshots of the setup, live console commands and connectivity outcomes. This page records what is visible in those files, without erasing the original practical work.

**October 2026 source revision: not yet EVE-NG retested.** The revised `.rsc` scripts and updated `.unl` cable map have passed static consistency checks; the historical screenshots do not automatically validate this particular edited build. This is a version distinction, not a claim that the project was never tested.

## Reviewed evidence

| Tested function | Screenshots | What the original EVE-NG record shows | Scope / version note |
| --- | --- | --- | --- |
| Lab setup and topology | [EVE-NG dashboard](../images/phase-00/eve-ng-dashboard.png), [lab canvas](../images/phase-01/eve-ng-topology.png) | EVE-NG project and connected devices shown in the original lab. | Does not prove the newer `.unl` export boots unchanged. |
| VLAN / inter-VLAN reachability | [VLAN screenshot](../images/testing/vlan-verification.png), [inter-VLAN pings](../images/testing/inter-vlan-test.png) | VPCS ping replies across 172.16.10/20/30/50 networks. | Not a packet-capture proof for every access port. |
| DHCP | [VPCS DHCP test](../images/testing/dhcp-test.png), [bound leases](../images/phase-05/dhcp-lease-verification.png) | DHCP DORA and multiple `bound` client leases are visible. | Screenshot gateway `.1`, whereas revised VIP gateway is `.254`. |
| OSPF and branch reachability | [Full neighbor](../images/phase-06/ospf-neighbor-verification.png), [OSPF routes](../images/phase-06/routing-table-verification.png), [client ping](../images/testing/ospf-test.png) | At least one Full OSPF neighbor, dynamic routes and successful branch-subnet ping. | Does not prove all four revised Area 0 sessions or failover convergence. |
| Internet / NAT | [HR client Internet ping](../images/phase-07/internet-connectivity-test.png), [masquerade rule](../images/phase-07/source-nat-configuration.png) | Five replies from 8.8.8.8 and a configured source-NAT masquerade rule. | The file called `nat-translation-table.png` shows connection tracking, not actual source-translation mapping; new HQ-R2 egress remains untested. |
| Firewall filtering | [Denied ping](../images/testing/firewall-test.png), [drop counters](../images/phase-08/firewall-rule-validation.png) | HR-to-IT ping times out; a forward-chain drop counter shows 15 packets against an HR→IT rule. | A controlled pre/post counter delta and backup-router policy test are still needed for revised config. |
| VRRP master / takeover / return | [Roles before](../images/phase-09/master-backup-status.png), [takeover](../images/phase-09/vrrp-failover-test.png), [recovery](../images/phase-09/vrrp-recovery-verification.png) | HQ-R1 Master, HQ-R2 Backup; after HQ-R1 interface shutdown HQ-R2 becomes Master; roles recover when link returns. | Historical output used HQ-R1 priority `255`; revised configs use `150/100`. Packet-loss and session-continuity numbers were not shown. |
| SSH administration | [Login evidence](../images/phase-10/ssh-login-verification.png) | `netadmin` successfully logs into HQ-R1 over SSH and reads `/system resource print`. | Shown device reports RouterOS 7.12; revised scripts target CHR 7.21.4. Denied-source test not documented. |
| Central Syslog | [UDP/514 packet capture](../images/phase-11/syslog-validation.png), [collector log](../images/phase-11/monitoring-dashboard.png) | Linux terminal captures incoming UDP 514 traffic and displays received device log lines. | The current exported `.unl` contains a VPCS placeholder, not the Linux collector used/shown in those historical screenshots. |
| NTP synchronization | [Router synchronized](../images/phase-12/time-synchronization-verification.png), [service log](../images/phase-12/integrated-service-verification.png), [NTP server view](../images/phase-12/ntp-status-validation.png) | HQ-R1 reports `system-status: synchronized` to 172.16.40.201; service log contains sync events. | `ntpq -p` screenshot shows `LOCAL(0)` as source; independent upstream time accuracy has not been demonstrated. |
| Final end-to-end sample | [OSPF learned routes and ping](../images/phase-13/enterprise-functional-testing.png) | HQ-R1 displays dynamic routes and a 3/3 successful ping to a branch address. | Illustrates a sample path, not complete acceptance of every branch/VLAN and failure mode. |

The screenshots are project artifacts, not raw emulator exports or tamper-evident audit logs. Their filenames and embedded terminal output provide useful evidence of the original work; the exact original runtime configuration and all execution timestamps are not reconstructed here. In particular, historical `.1` DHCP gateways, VRRP priority 255 and RouterOS 7.12 appear in some captures, while the later configuration revision uses `.254` VIPs, priority 150/100 and RouterOS 7.21.4.

## Screenshot archive

There are **79 non-empty images** in `images/` (including installation/setup screenshots, diagrams and command/test captures). Each file below is linked for inspection; an image's presence alone does not mean that a separate test was passed.

### phase-00

- [chr-directory-verification.png](../images/phase-00/chr-directory-verification.png)
- [eve-ng-dashboard.png](../images/phase-00/eve-ng-dashboard.png)
- [eve-ng-installation-complete.png](../images/phase-00/eve-ng-installation-complete.png)
- [eve-ng-login-page.png](../images/phase-00/eve-ng-login-page.png)
- [mikrotik-chr-upload.png](../images/phase-00/mikrotik-chr-upload.png)
- [mikrotik-template-detection.png](../images/phase-00/mikrotik-template-detection.png)
- [virtualbox-boot-error.png](../images/phase-00/virtualbox-boot-error.png)
- [virtualbox-installation-issue.png](../images/phase-00/virtualbox-installation-issue.png)
- [vmware-hardware-configuration.png](../images/phase-00/vmware-hardware-configuration.png)
- [vmware-vm-creation.png](../images/phase-00/vmware-vm-creation.png)

### phase-01

- [enterprise-network-topology.png](../images/phase-01/enterprise-network-topology.png)
- [eve-ng-topology.png](../images/phase-01/eve-ng-topology.png)

### phase-02

- [client-device-deployment.png](../images/phase-02/client-device-deployment.png)
- [completed-infrastructure.png](../images/phase-02/completed-infrastructure.png)
- [enterprise-topology-deployment.png](../images/phase-02/enterprise-topology-deployment.png)
- [physical-connections.png](../images/phase-02/physical-connections.png)
- [router-deployment.png](../images/phase-02/router-deployment.png)
- [switch-deployment.png](../images/phase-02/switch-deployment.png)

### phase-03

- [access-port-configuration.png](../images/phase-03/access-port-configuration.png)
- [branch-vlan-configuration.png](../images/phase-03/branch-vlan-configuration.png)
- [hq-vlan-configuration.png](../images/phase-03/hq-vlan-configuration.png)
- [trunk-port-configuration.png](../images/phase-03/trunk-port-configuration.png)
- [vlan-verification.png](../images/phase-03/vlan-verification.png)

### phase-04

- [inter-vlan-connectivity-test.png](../images/phase-04/inter-vlan-connectivity-test.png)
- [inter-vlan-routing-configuration.png](../images/phase-04/inter-vlan-routing-configuration.png)
- [router-interface-configuration.png](../images/phase-04/router-interface-configuration.png)
- [routing-verification.png](../images/phase-04/routing-verification.png)
- [vlan-gateway-configuration.png](../images/phase-04/vlan-gateway-configuration.png)

### phase-05

- [client-connectivity-test.png](../images/phase-05/client-connectivity-test.png)
- [dhcp-address-pool.png](../images/phase-05/dhcp-address-pool.png)
- [dhcp-lease-verification.png](../images/phase-05/dhcp-lease-verification.png)
- [dhcp-server-configuration.png](../images/phase-05/dhcp-server-configuration.png)
- [gateway-dns-configuration.png](../images/phase-05/gateway-dns-configuration.png)

### phase-06

- [end-to-end-connectivity-test.png](../images/phase-06/end-to-end-connectivity-test.png)
- [network-advertisement.png](../images/phase-06/network-advertisement.png)
- [ospf-area-design.png](../images/phase-06/ospf-area-design.png)
- [ospf-neighbor-verification.png](../images/phase-06/ospf-neighbor-verification.png)
- [router-id-configuration.png](../images/phase-06/router-id-configuration.png)
- [routing-table-verification.png](../images/phase-06/routing-table-verification.png)

### phase-07

- [internet-connectivity-test.png](../images/phase-07/internet-connectivity-test.png)
- [internet-gateway-configuration.png](../images/phase-07/internet-gateway-configuration.png)
- [nat-translation-table.png](../images/phase-07/nat-translation-table.png)
- [source-nat-configuration.png](../images/phase-07/source-nat-configuration.png)

### phase-08

- [access-control-configuration.png](../images/phase-08/access-control-configuration.png)
- [firewall-filter-rules.png](../images/phase-08/firewall-filter-rules.png)
- [firewall-rule-validation.png](../images/phase-08/firewall-rule-validation.png)
- [management-access-protection.png](../images/phase-08/management-access-protection.png)
- [traffic-filtering-verification.png](../images/phase-08/traffic-filtering-verification.png)

### phase-09

- [master-backup-status.png](../images/phase-09/master-backup-status.png)
- [vrrp-architecture-diagram.png](../images/phase-09/vrrp-architecture-diagram.png)
- [vrrp-configuration.png](../images/phase-09/vrrp-configuration.png)
- [vrrp-failover-test.png](../images/phase-09/vrrp-failover-test.png)
- [vrrp-recovery-verification.png](../images/phase-09/vrrp-recovery-verification.png)

### phase-10

- [administrator-account-configuration.png](../images/phase-10/administrator-account-configuration.png)
- [secure-management-validation.png](../images/phase-10/secure-management-validation.png)
- [ssh-login-verification.png](../images/phase-10/ssh-login-verification.png)
- [ssh-service-configuration.png](../images/phase-10/ssh-service-configuration.png)

### phase-11

- [log-collection-verification.png](../images/phase-11/log-collection-verification.png)
- [monitoring-dashboard.png](../images/phase-11/monitoring-dashboard.png)
- [syslog-architecture-diagram.png](../images/phase-11/syslog-architecture-diagram.png)
- [syslog-configuration.png](../images/phase-11/syslog-configuration.png)
- [syslog-validation.png](../images/phase-11/syslog-validation.png)

### phase-12

- [integrated-service-verification.png](../images/phase-12/integrated-service-verification.png)
- [ntp-architecture-diagram.png](../images/phase-12/ntp-architecture-diagram.png)
- [ntp-client-configuration.png](../images/phase-12/ntp-client-configuration.png)
- [ntp-status-validation.png](../images/phase-12/ntp-status-validation.png)
- [time-synchronization-verification.png](../images/phase-12/time-synchronization-verification.png)

### phase-13

- [enterprise-functional-testing.png](../images/phase-13/enterprise-functional-testing.png)
- [final-enterprise-topology.png](../images/phase-13/final-enterprise-topology.png)

### testing

- [dhcp-test.png](../images/testing/dhcp-test.png)
- [firewall-test.png](../images/testing/firewall-test.png)
- [inter-vlan-test.png](../images/testing/inter-vlan-test.png)
- [nat-test.png](../images/testing/nat-test.png)
- [ntp-test.png](../images/testing/ntp-test.png)
- [ospf-test.png](../images/testing/ospf-test.png)
- [ssh-test.png](../images/testing/ssh-test.png)
- [syslog-test.png](../images/testing/syslog-test.png)
- [vlan-verification.png](../images/testing/vlan-verification.png)
- [vrrp-test.png](../images/testing/vrrp-test.png)

## Reproducing the updated lab

The historical evidence establishes that EVE-NG testing was performed for the original implementation. To accept the **updated** configuration separately, follow the [rebuild and acceptance procedure](REBUILD-AND-ACCEPTANCE.md), save raw command output and packet loss/timing measurements, and add the new evidence under a dated run folder. Do not overwrite the original screenshots.

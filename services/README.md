# Syslog and NTP reference for the lab

The existing EVE-NG topology uses a VPCS node labeled `SYSLOG-SERVER` on VLAN 40. VPCS is useful for reachability checks, but it is **not** a Syslog or NTP server.

To validate those features, replace the placeholder or attach a proper Debian/Ubuntu Linux VM to CORE-SW2 ether7 (VLAN 40). Set a **static** address:

```text
Address: 172.16.40.201/24
Gateway: 172.16.40.254
DNS: 1.1.1.1
```

Adjust the VM's interface name and network settings through the guest OS; do not paste unreviewed static network configuration on a remote machine.

## Packages and sample config

On a disposable service VM:

```sh
sudo apt-get update
sudo apt-get install -y rsyslog chrony
```

Place [30-routeros.conf](rsyslog/30-routeros.conf) in `/etc/rsyslog.d/` and [enterprise-lab.conf](chrony/enterprise-lab.conf) in `/etc/chrony/conf.d/` (supported Debian/Ubuntu releases). Keep the stock chrony upstream configuration unless conflicting.

```sh
sudo mkdir -p /var/log/routeros
sudo rsyslogd -N1
sudo systemctl restart rsyslog
sudo systemctl restart chrony
sudo ss -lunp
chronyc tracking
chronyc sources -v
```

Open UDP 514 from the lab router subnets to the VM for Syslog and UDP 123 for NTP. In shared environments restrict these services to `172.16.0.0/16`, isolate them from the Internet, and apply OS firewall controls.

## Validate, don't assume

On the Linux server:

```sh
sudo tcpdump -n -i any 'udp port 514 or udp port 123'
sudo find /var/log/routeros -type f -maxdepth 1
```

On a RouterOS gateway:

```routeros
/system logging action print
/system ntp client print
/system ntp client servers print
```

The `services/` folder provides **configuration examples only**. No Linux image, running daemon, captured Syslog result or synchronized NTP status is bundled. Add live evidence to [the testing register](../docs/Testing-and-Validation.md) only after execution.

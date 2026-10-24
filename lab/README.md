# EVE-NG lab import

The export `Enterprise_Multi_Branch_Network.unl` describes **21 nodes**: eight RouterOS CHR nodes and thirteen VPCS endpoints. It captures wiring, not a running configuration or server VM.

## Requirements

- EVE-NG Community Edition with a working hardware virtualization backend.
- MikroTik CHR 7.21.4, provided separately under MikroTik licensing.
- A DHCP-enabled, isolated network behind the EVE-NG management cloud (`pnet0`) for lab-only Internet egress.

The `.unl` references image `mikrotik-chr-7.21.4`. Prepare `hda.qcow2` from the raw CHR image using **conversion**, not merely changing its extension:

```sh
sudo mkdir -p /opt/unetlab/addons/qemu/mikrotik-chr-7.21.4
qemu-img convert -f raw -O qcow2 chr-7.21.4.img hda.qcow2
qemu-img info hda.qcow2
sudo mv hda.qcow2 /opt/unetlab/addons/qemu/mikrotik-chr-7.21.4/hda.qcow2
sudo /opt/unetlab/wrappers/unl_wrapper -a fixpermissions
```

Execute these commands on the EVE host from a controlled staging directory; adjust source paths explicitly. The CHR raw image is **not** included.

## Physical map

| Connection | EVE interfaces |
| --- | --- |
| HQ-R1 → CORE-SW1 | ether1 ↔ ether1 |
| HQ-R2 → CORE-SW2 | ether1 ↔ ether1 |
| CORE-SW1 ↔ CORE-SW2 | ether2 ↔ ether2 |
| HQ-R1 → BR1-R1 | ether2 ↔ ether2 |
| HQ-R1 → BR2-R1 | ether3 ↔ ether2 |
| HQ-R2 → BR1-R1 | ether2 ↔ ether3 |
| HQ-R2 → BR2-R1 | ether3 ↔ ether3 |
| Both HQ WANs → management cloud | HQ-R1 ether4 and HQ-R2 ether4 ↔ pnet0 |
| BR1-R1 → BR1-SW1 | ether1 ↔ ether1 |
| BR2-R1 → BR2-SW1 | ether1 ↔ ether1 |

CORE-SW1 ether3/4 serve HR, ether5/6 Sales. CORE-SW2 ether3/4 serve IT, ether5 ADMIN, ether6 the file-server placeholder, ether7 the SYSLOG placeholder. Branch endpoint ports are ether2 and ether3.

## Sequence

1. Import `.unl` through EVE-NG.
2. Confirm the CHR image is detected, links are wired, and VPCS clients are present.
3. Import corresponding files from `configs/` to **clean** CHR systems.
4. Configure admin credentials locally. Do not commit them to Git.
5. Replace/attach an actual Linux server at `172.16.40.201` if Syslog/NTP tests are required.
6. Follow `docs/REBUILD-AND-ACCEPTANCE.md` and retain output evidence.

## Important limits

- `SYSLOG-SERVER` is currently a **VPCS placeholder**; it cannot collect Syslog or serve NTP.
- Both router uplinks share the **same** EVE host management cloud. That is path diversity at the router level, not independent upstream ISP diversity.
- This file is a topology export; it does not embed saved RouterOS configurations.
- This revised topology has not been boot-tested after the October 2026 source edits.

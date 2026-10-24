#!/usr/bin/env python3
"""Static checks tying RouterOS sources to the exported EVE-NG cabling.

This does not parse RouterOS syntax completely or run packets through the lab.
"""
from __future__ import annotations

import re
import sys
import xml.etree.ElementTree as ET
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CONFIGS = ROOT / "configs"
LAB = ROOT / "lab" / "Enterprise_Multi_Branch_Network.unl"
errors: list[str] = []


def check(condition: bool, message: str) -> None:
    if not condition:
        errors.append(message)


def read(name: str) -> str:
    return (CONFIGS / f"{name}.rsc").read_text(encoding="utf-8")


def port_number(interface: str) -> str:
    """EVE's eth1 maps to RouterOS ether1 in this CHR template."""
    return interface.replace("eth", "ether", 1)


nodes = ET.parse(LAB).getroot().findall("./topology/nodes/node")
by_name = {node.attrib["name"]: node for node in nodes}
by_net: dict[str, list[tuple[str, str]]] = defaultdict(list)
for node in nodes:
    for interface in node.findall("./interface"):
        network_id = interface.get("network_id")
        if network_id is not None:
            by_net[network_id].append((node.get("name", ""), interface.get("name", "")))

router_names = ("HQ-R1", "HQ-R2", "BR1-R1", "BR2-R1")
switch_names = ("CORE-SW1", "CORE-SW2", "BR1-SW1", "BR2-SW1")
check(len(nodes) == 21, f"Unexpected EVE node count: {len(nodes)}")
check(all(name in by_name for name in router_names + switch_names), "Missing RouterOS node")

# The output of /interface bridge port may be dynamic; these static checks
# validate only the intended source-to-topology mapping.
expected_clients = {
    "HR-PC1": ("CORE-SW1", 10),
    "HR-PC2": ("CORE-SW1", 10),
    "SALES-PC1": ("CORE-SW1", 20),
    "SALES-PC2": ("CORE-SW1", 20),
    "IT-PC1": ("CORE-SW2", 30),
    "IT-PC2": ("CORE-SW2", 30),
    "ADMIN-PC": ("CORE-SW2", 50),
    "File-SERVER": ("CORE-SW2", 40),
    "SYSLOG-SERVER": ("CORE-SW2", 40),
    "BR1-PC1": ("BR1-SW1", 110),
    "BR1-PC2": ("BR1-SW1", 110),
    "BR2-PC1": ("BR2-SW1", 210),
    "BR2-PC2": ("BR2-SW1", 210),
}

for name, (expected_switch, expected_vlan) in expected_clients.items():
    connections = [
        (network, members)
        for network, members in by_net.items()
        if any(node == name for node, _ in members)
    ]
    if len(connections) != 1:
        check(False, f"{name}: expected exactly one network")
        continue
    _, members = connections[0]
    ports = [
        port_number(interface)
        for node, interface in members
        if node == expected_switch
    ]
    if len(ports) != 1:
        check(False, f"{name}: not connected to {expected_switch}")
        continue
    port = ports[0]
    source = read(expected_switch)
    pattern = rf"^add bridge=br-vlans interface={re.escape(port)}\s+pvid={expected_vlan}\b"
    check(
        re.search(pattern, source, re.MULTILINE) is not None,
        f"{name}: {expected_switch}/{port} not set to VLAN {expected_vlan}",
    )

# Cross-check the four OSPF transit circuits, not just the labels in docs.
transits = {
    "6": {"HQ-R1", "BR1-R1"},
    "7": {"HQ-R1", "BR2-R1"},
    "8": {"HQ-R2", "BR1-R1"},
    "9": {"HQ-R2", "BR2-R1"},
}
for net, expected_pair in transits.items():
    members = by_net.get(net, [])
    check({name for name, _ in members} == expected_pair, f"WAN {net}: incorrect endpoints")
    for name, iface in members:
        template = next(
            (
                line for line in read(name).splitlines()
                if line.startswith("add area=area0 interfaces=")
                and "type=ptp" in line
                and port_number(iface) in line.split("interfaces=", 1)[1].split()[0].split(",")
            ),
            None,
        )
        check(template is not None, f"{name}/{iface}: WAN not in OSPF area 0 PTP")

for name, area, vlan in (("BR1-R1", 10, 110), ("BR2-R1", 20, 210)):
    source = read(name)
    check(f"area-id=0.0.0.{area} type=stub" in source, f"{name}: stub area missing")
    check(
        f"interfaces=vlan{vlan}-USERS passive=yes" in source,
        f"{name}: branch LAN must be passive",
    )

for i, name in enumerate(("HQ-R1", "HQ-R2")):
    source = read(name)
    expected_priority = 150 if i == 0 else 100
    for vlan in (10, 20, 30, 40, 50):
        vr = re.search(rf"^add interface=vlan{vlan}-\S+ name=vrrp{vlan} vrid={vlan} priority=(\d+)", source, re.MULTILINE)
        check(vr is not None, f"{name}: VRRP{vlan} missing")
        if vr:
            check(int(vr.group(1)) == expected_priority, f"{name}: VRRP{vlan} priority mismatch")
            check(1 <= int(vr.group(1)) <= 254, f"{name}: reserved VRRP priority")
        check(
            f"address=172.16.{vlan}.254/32 interface=vrrp{vlan}" in source,
            f"{name}: VRRP{vlan} virtual address must be /32",
        )
    check("interface=ether4 add-default-route=yes" in source, f"{name}: WAN DHCP absent")
    check("out-interface=ether4 action=masquerade" in source, f"{name}: outbound NAT absent")
    check("originate-default=if-installed" in source, f"{name}: unconditional OSPF default")
    check('comment="Default drop to router"' in source, f"{name}: input default drop missing")

# The two HQ gateways must have separate interfaces on the same pnet0 lab cloud.
for name in ("HQ-R1", "HQ-R2"):
    check((name, "eth4") in by_net.get("21", []), f"{name}: no ether4 to pnet0")

for name in router_names:
    source = read(name)
    check("/system ntp client set enabled=yes" in source, f"{name}: wrong v7 NTP path")
    check("/ntp client" not in source.replace("/system ntp client", ""), f"{name}: old NTP menu present")
    check("set winbox disabled=yes" in source, f"{name}: Winbox hardening absent")
    check("add action=remote-syslog topics=info" in source, f"{name}: informational Syslog forwarding missing")

readme = (ROOT / "README.md").read_text(encoding="utf-8")
for link in re.findall(r"\]\(([^)]+)\)", readme):
    if link.startswith(("https://", "http://", "#", "mailto:")):
        continue
    path = link.split("#", 1)[0]
    if path:
        check((ROOT / path).exists(), f"Broken README link: {link}")

check((ROOT / "LICENSE").stat().st_size > 300, "Incomplete LICENSE")
validation = (ROOT / "docs/Testing-and-Validation.md").read_text(encoding="utf-8")
evidence = ROOT / "docs/EVE-NG-TEST-EVIDENCE.md"
check(evidence.exists(), "Missing original EVE-NG test evidence register")
check(
    "Original EVE-NG" in validation and "not rerun" in validation.lower(),
    "Validation must distinguish original EVE-NG tests from the revised build",
)

if errors:
    print(f"Static check FAILED: {len(errors)} issue(s)")
    for error in errors:
        print(f" - {error}")
    sys.exit(1)

print(f"Static check PASS: {len(nodes)} nodes, {len(expected_clients)} endpoint ports, "
      f"{len(transits)} WAN links and router policy assumptions match the sources.")
print("Reminder: original EVE-NG testing is documented; revised RouterOS imports and failover still need a live retest.")

# EVE-NG Lab Topology Deployment Guide

This directory contains the official exported EVE-NG topology file (`.unl`) for the High Availability Enterprise Multi-Branch Network project. Importing this file allows network administrators, engineers, and reviewers to recreate the identical hardware environment, link intersections, and physical mappings used throughout this project.

---

## 💻 Lab Environment Specifications

To run this simulation seamlessly without environment node mismatch errors, ensure your virtualization platform matches the following parameters verified during the initial environment deployment[cite: 1]:

| Component / Parameter | Validated Value | Source Requirement |
| :--- | :--- | :--- |
| **Simulation Platform** | EVE-NG Community Edition (v6.2.0-4) | Core Lab Framework[cite: 1] |
| **Virtualization Base** | VMware Workstation Pro (17.x) | Hypervisor Layer[cite: 1] |
| **Node Template OS** | MikroTik RouterOS / CHR (v7.21.4) | Image Version Requirement[cite: 1] |
| **Assigned Resources** | 2 vCPUs / 4096 MB RAM / 40 GB Storage | Baseline Virtualization Capacity[cite: 1] |

---

## 📦 Prerequisites & Image Import Setup

Before uploading the `.unl` file, the exact MikroTik CHR image version must be properly registered inside your EVE-NG backend[cite: 1]. If your template is missing or named incorrectly, the nodes will appear greyed out and fail to boot[cite: 1].

Follow these steps to stage the image via WinSCP or SSH Terminal[cite: 1]:

1. **Create the Target QEMU Directory:**
   ```bash
   mkdir -p /opt/unetlab/addons/qemu/mikrotik-chr-7.21.4
   ```[cite: 1]

2. **Upload & Rename Image Binary:**
   Upload the `chr-7.21.4.img` source file into the newly created directory and rename it to the required raw block definition file format[cite: 1]:
   ```bash
   mv /opt/unetlab/addons/qemu/mikrotik-chr-7.21.4/chr-7.21.4.img /opt/unetlab/addons/qemu/mikrotik-chr-7.21.4/hda.qcow2
   ```[cite: 1]

3. **Apply Global Access Control and System Permissions:**
   Run the native EVE-NG permission correction wrapper tool to register the new hardware template definitions[cite: 1]:
   ```bash
   /opt/unetlab/wrappers/unl_wrapper -a fixpermissions
   ```[cite: 1]

---

## 🚀 Lab File Import Instructions

Once the QEMU images are compiled, follow these instructions to import the network scheme into the dashboard[cite: 1]:

```text
EVE-NG UI Portal ──> "Import external labs" ──> Select 'Enterprise-Multi-Branch-Network.unl' ──> Open & Verify Nodes
```[cite: 1]

1. Log into your EVE-NG Web Management Interface (e.g., `http://192.168.96.128`) using your administrator credentials[cite: 1].
2. Click on the **Import external labs** button located on the top folder management taskbar.
3. Browse and select the `Enterprise-Multi-Branch-Network.unl` file located inside this repository directory[cite: 1].
4. Double-click the imported lab file to enter the interactive workspace topology layout[cite: 1].

---

## 🗺️ Physical Interconnect Framework Verification

When the workspace loads, double-check that the automated setup conforms to the infrastructure blueprint[cite: 1]:

### 1. Headquarters Infrastructure Topology
* **HQ-R1 Linkages:** `ether1` is hard-mapped to the core trunk line on `CORE-SW1 ether1`[cite: 1]. `ether2` and `ether3` connect directly to the redundant boundary interfaces on `BR1-R1 ether2` and `BR2-R1 ether2` respectively[cite: 1].
* **HQ-R2 Linkages:** `ether1` is hard-mapped to the redundant trunk line on `CORE-SW2 ether1`[cite: 1]. `ether2` and `ether3` cross-connect to `BR1-R1 ether3` and `BR2-R1 ether3`[cite: 1].
* **Switch Interconnect fabrics:** An independent trunk pipe bridges local assets via `CORE-SW1 ether2 ↔ CORE-SW2 ether2`[cite: 1].

### 2. Remote Branch Distribution Layers
* **Branch 1 Loop:** `BR1-R1 ether1` bridges to the local internal distribution switch fabric at `BR1-SW1 ether1`[cite: 1].
* **Branch 2 Loop:** `BR2-R1 ether1` bridges to the local internal distribution switch fabric at `BR2-SW1 ether1`[cite: 1].

---

## 🔒 Post-Import Configuration Tasks

* [ ] Verify that all 4 routers (`HQ-R1`, `HQ-R2`, `BR1-R1`, `BR2-R1`) and all 4 switches (`CORE-SW1`, `CORE-SW2`, `BR1-SW1`, `BR2-SW1`) detect the MikroTik RouterOS template successfully[cite: 1].
* [ ] map `HQ-R1 ether4` to your local `Management Cloud (Cloud0)` interface component to establish a valid external physical gateway mapping for the internal simulated NAT infrastructure[cite: 1].
* [ ] Once ports are verified, start all nodes and proceed to flash the specific configuration scripts compiled inside the `/configs` directory of this repository[cite: 1].
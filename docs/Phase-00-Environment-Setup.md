> **October 2026 revision note:** This page is retained from the original lab build. Its screenshots and sample command output are historical; they are not the acceptance result for the revised `configs/*.rsc` files. Use [the current test checklist](REBUILD-AND-ACCEPTANCE.md) and [design decisions](NETWORK-DECISIONS.md) for source-level expectations.

# 🚀 Phase 00 – Environment Setup & Emulation Deployments

## 📌 Objective
The core objective of this phase was to prepare a stable and reliable virtualized lab environment using EVE-NG to simulate an Enterprise Multi-Branch Network with MikroTik CHR Routers. This stage covers hypervisor deployment optimization, configuration of the network emulation platform, and the successful ingestion of verified MikroTik RouterOS disk images.

---

## 🛠️ Hypervisor Selection & Virtualization Planning

The project deployment was initially attempted using Oracle VM VirtualBox as the primary virtualization platform for running the EVE-NG virtual machine. However, multiple stability and configuration issues were encountered during testing:
* The EVE-NG virtual machine failed to boot reliably or maintain stability.
* Network configuration profiles did not function correctly.
* Accessing the lab environment management web interface was highly problematic.
* EVE-NG Community Edition generally delivers more stable performance on VMware platforms.

> **Architectural Decision:** Due to these technical constraints within the VirtualBox execution layer, the decision was made to drop VirtualBox and deploy the platform using VMware Workstation Pro to achieve optimal stability and performance.

### 📑 Documentation Evidence

#### Figure 1. VirtualBox Error Screenshot
![VirtualBox Boot Error](../images/phase-00/virtualbox-boot-error.png)
*Evidence of the initial setup issues and boot errors inside Oracle VirtualBox.*

---

#### Figure 2. VirtualBox Boot Problem Screenshot
![VirtualBox Installation Issue](../images/phase-00/virtualbox-installation-issue.png)
*Documentation tracking the network configuration and access bugs within the VirtualBox deployment attempt.*

---

## 💾 Software Inventory Specifications

The enterprise lab infrastructure was constructed using the following specific software baselines:

| Structural Component | Selected Platform / Version |
| :--- | :--- |
| **Type-2 Hypervisor** | VMware Workstation Pro (17.x) |
| **Network Emulator** | EVE-NG Community Edition (6.2.0-4) |
| **Router Engine Image** | MikroTik CHR (7.21.4) |

---

## ⚙️ Virtual Machine Resource Allocation

The EVE-NG virtual machine was provisioned within the VMware Workstation hypervisor using the following hardware resource allocations:
* **vCPU Allocation:** 2 Cores
* **Memory Profile:** 4096 MB
* **Virtual Storage Capacity:** 40 GB
* **Network Adapter Profile:** NAT Mode
* **Local Storage Target Location:** `C:\Users\USER\Downloads\Networking-Lab\EVE-NG`

### 📑 Documentation Evidence

#### Figure 3. VMware Hardware Configuration
![VMware Hardware Configuration](../images/phase-00/vmware-hardware-configuration.png)
*Verification of the resource parameters mapped to the virtualization host container.*

---

#### Figure 4. VMware Virtual Machine Creation
![VMware Virtual Machine Creation](../images/phase-00/vmware-vm-creation.png)
*The configuration phase confirming successful allocation and provisioning of the virtual environment.*

---

## 🌐 EVE-NG Server Platform Deployment

Upon completing the hypervisor infrastructure initialization, the EVE-NG installation ISO was mounted, the operating system installation was finalized, and initial configuration parameters were defined.

The instance successfully obtained the following management control plane network profile:

| Parameter | Metric / Value |
| :--- | :--- |
| **Assigned Management IP** | 192.168.96.128 |
| **Web GUI Interface Endpoint** | `http://192.168.96.128` |

### 📑 Documentation Evidence

#### Figure 5. EVE-NG Installation Complete Screen
![EVE-NG Installation Completed](../images/phase-00/eve-ng-installation-complete.png)
*Terminal console output certifying the successful execution and completion of the core EVE-NG setup.*

---

#### Figure 6. EVE-NG Login Page
![EVE-NG Login Page](../images/phase-00/eve-ng-login-page.png)
*Verification of the responsive HTTP listener on the EVE-NG web interface landing page.*

---

#### Figure 7. EVE-NG Dashboard
![EVE-NG Dashboard](../images/phase-00/eve-ng-dashboard.png)
*Successful administrative authentication and system entry into the primary operations workspace dashboard.*

---

## 🗂️ MikroTik Cloud Hosted Router (CHR) Ingestion

The MikroTik Cloud Hosted Router (`chr-7.21.4.img`) binary image was uploaded onto the EVE-NG server file system using WinSCP to make the templates selectable inside the lab network. 

The exact directory paths, renaming structures, and permission rules executed via the secure console terminal consist of the following actions:

```bash
# 1. Generate the explicit hardware template QEMU target directory framework
mkdir -p /opt/unetlab/addons/qemu/mikrotik-chr-7.21.4

# 2. Transfer the raw binary asset into the folder path and adjust the file name parameters
mv chr-7.21.4.img hda.qcow2

# 3. Apply the global EVE-NG system permission correction utility wrapper
/opt/unetlab/wrappers/unl_wrapper -a fixpermissions
```

Following these execution policies, the RouterOS image template was successfully detected and activated within the device library.

### 📑 Documentation Evidence

#### Figure 8. WinSCP Upload
![MikroTik CHR Upload](../images/phase-00/mikrotik-chr-upload.png)
*Tracking the secure transmission of the chr-7.21.4.img target file into the remote host backend directory.*

---

#### Figure 9. CHR Directory Verification
![CHR Directory Verification](../images/phase-00/chr-directory-verification.png)
*Verifying the path structure, directory creation, and file rename adjustments inside the target file system.*

---

#### Figure 10. MikroTik Template Detection
![MikroTik Template Detection](../images/phase-00/mikrotik-template-detection.png)
*Active confirmation that the MikroTik RouterOS device type template is successfully parsed and selectable in EVE-NG.*

---

## 🔍 Validation Matrix

| Target Verification Control Item | Current Status | Notes |
| :--- | :--- | :--- |
| VMware Virtual Machine Running | ✅ Verified | Hypervisor hosting layer reports healthy operating status. |
| EVE-NG Installed Successfully | ✅ Verified | Core system components initialized without runtime errors. |
| Web Interface Accessible | ✅ Verified | Secure access validated via `http://192.168.96.128`. |
| MikroTik CHR Imported | ✅ Verified | Image binary correctly placed in the designated path framework. |
| RouterOS Template Detected | ✅ Verified | Node selection catalogs display the template asset actively. |
| Lab Ready for Deployment | ✅ Verified | All architectural environment readiness gates successfully passed. |

---

## 🎯 Phase Outcome
Phase 00 has successfully achieved all environmental infrastructure design requirements. By shifting from the unstable VirtualBox configuration to a robust VMware Workstation Pro hypervisor arrangement, nested virtualization bottlenecks were resolved. The EVE-NG platform is fully initialized, system permissions are correctly configured, and the MikroTik CHR v7 image library is successfully integrated into the system core. The testbed environment is now prepared to transition into the active network design and topology addressing stages.
```
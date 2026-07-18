# Phase 00 – Environment Setup

## Objective

The objective of this phase was to prepare a stable and reliable virtual lab environment for implementing the Enterprise Multi-Branch Network project. Before any network configuration could begin, the required virtualization platform, network emulator, and MikroTik RouterOS images had to be installed and verified.

---

# Initial Environment Planning

The project was initially planned using Oracle VirtualBox as the virtualization platform for running the EVE-NG virtual machine.

During testing, several stability issues were encountered, including boot problems, inconsistent network behavior, and difficulty accessing the EVE-NG web interface. Since these issues could affect future implementation and testing, an alternative virtualization platform was evaluated.

After comparing both environments, VMware Workstation Pro was selected because it provides better compatibility and more stable performance for EVE-NG Community Edition.

### Documentation Evidence

#### Figure 1. VirtualBox Boot Error

![VirtualBox Boot Error](../images/phase-00/virtualbox-boot-error.png)

*Boot failure encountered while deploying the EVE-NG virtual machine in Oracle VirtualBox.*

---

#### Figure 2. VirtualBox Installation Issue

![VirtualBox Installation Issue](../images/phase-00/virtualbox-installation-issue.png)

*Network and virtualization issues observed during the initial VirtualBox deployment.*

---

# Software Environment

The following software was used throughout the project.

| Component | Version |
|-----------|---------|
| VMware Workstation Pro | 17.x |
| EVE-NG Community Edition | 6.2.0-4 |
| MikroTik CHR | 7.21.4 |
| WinSCP | Latest |
| PuTTY | Latest |
| Draw.io | Latest |

---

# Virtual Machine Configuration

The EVE-NG virtual machine was deployed using the following hardware allocation.

| Parameter | Value |
|-----------|-------|
| vCPU | 2 |
| Memory | 4096 MB |
| Storage | 40 GB |
| Network Adapter | NAT |

The virtual machine files were stored locally to provide sufficient performance during lab development.

### Documentation Evidence

#### Figure 3. VMware Hardware Configuration

![VMware Hardware Configuration](../images/phase-00/vmware-hardware-configuration.png)

*Hardware resources allocated to the EVE-NG virtual machine.*

---

#### Figure 4. VMware Virtual Machine Creation

![VMware Virtual Machine Creation](../images/phase-00/vmware-vm-creation.png)

*Creation of the EVE-NG virtual machine using VMware Workstation Pro.*

---

# EVE-NG Installation

After deploying the virtual machine, EVE-NG Community Edition was installed successfully.

The following tasks were completed:

- Mounted the EVE-NG installation ISO.
- Installed the operating system.
- Performed the initial system configuration.
- Verified successful access to the web interface.

The lab environment was assigned the following management address during deployment.

| Parameter | Value |
|-----------|-------|
| Management IP | 192.168.96.128 |

Successful access to the EVE-NG dashboard confirmed that the installation was completed correctly.

### Documentation Evidence

#### Figure 5. EVE-NG Installation Completed

![EVE-NG Installation Completed](../images/phase-00/eve-ng-installation-complete.png)

*Successful installation of EVE-NG Community Edition.*

---

#### Figure 6. EVE-NG Login Page

![EVE-NG Login Page](../images/phase-00/eve-ng-login-page.png)

*Login page of the EVE-NG web interface.*

---

#### Figure 7. EVE-NG Dashboard

![EVE-NG Dashboard](../images/phase-00/eve-ng-dashboard.png)

*EVE-NG dashboard after successful login and initial configuration.*

---

# MikroTik CHR Import

The MikroTik Cloud Hosted Router (CHR) image was imported into the EVE-NG server using WinSCP.

The deployment process included:

- Creating the required image directory.
- Uploading the CHR image.
- Renaming the image to **hda.qcow2**.
- Applying EVE-NG file permissions.
- Verifying that the RouterOS template appeared inside EVE-NG.

After completing these steps, MikroTik devices became available for deployment in the lab environment.

### Documentation Evidence

#### Figure 8. MikroTik CHR Upload

![MikroTik CHR Upload](../images/phase-00/mikrotik-chr-upload.png)

*Uploading the MikroTik CHR image to the EVE-NG server using WinSCP.*

---

#### Figure 9. CHR Directory Verification

![CHR Directory Verification](../images/phase-00/chr-directory-verification.png)

*Verification of the MikroTik CHR image directory inside the EVE-NG server.*

---

#### Figure 10. MikroTik Template Detection

![MikroTik Template Detection](../images/phase-00/mikrotik-template-detection.png)

*Successful detection of the MikroTik CHR template in the EVE-NG device library.*

---

# Phase Verification

The environment was verified before moving to the implementation phases.

| Verification Item | Status |
|-------------------|--------|
| VMware Virtual Machine Running | ✅ |
| EVE-NG Installed Successfully | ✅ |
| Web Interface Accessible | ✅ |
| MikroTik CHR Imported | ✅ |
| RouterOS Template Detected | ✅ |
| Lab Ready for Deployment | ✅ |

---

# Outcome

This phase successfully established the enterprise lab environment required for the remainder of the project. A stable VMware-based EVE-NG platform was prepared, MikroTik CHR images were imported successfully, and the network emulator was verified to be fully operational. With the environment ready, the project proceeded to the network planning and design phase.
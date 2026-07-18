# 🚀 Phase 10 – Cryptographic Secure Shell (SSH) Remote Management & Service Hardening

## 📌 Objective
The primary objective of this phase was to engineer a cryptographically secure, encrypted remote administrative control plane across all network infrastructure deployment assets by implementing **Secure Shell (SSHv2)**. This deployment entirely deprecates insecure clear-text legacy management protocols (such as Telnet and unencrypted HTTP/API daemons), completely eliminating vulnerabilities related to eavesdropping, packet sniffing, credential theft, and unauthorized out-of-band control plane intrusion.

---

## 🏗️ Secure Remote Management Architecture & Strategy

Managing corporate core routers and distributed branch switches using physical serial console sessions is only scalable during the early Phase 02 initial bootstrap window. For daily operations, systems engineers must be able to configure, monitor, and troubleshoot network nodes from a centralized management station.

To accomplish this securely without creating new attack surfaces, the **RouterOS v7 Service Engine** was hardened using a multi-layered defensive strategy:
* **Cryptographic Session Encryption:** Unlike Telnet which passes administrative credentials across link meshes in plain clear text, SSH establishes an asymmetric cryptographic key exchange, ensuring absolute confidentiality, payload integrity, and node authentication.
* **Attack Surface Reduction:** All insecure, plaintext, or unvetted management service ports (including Telnet, FTP, and standard HTTP Winbox engines) are explicitly disabled across the entire network fabric.
* **IT Infrastructure Isolation:** Administrative authentication commands are explicitly limited. This layer works with the Phase 08 stateful firewall chains to allow incoming SSH control traffic only when originating from the verified **IT Administration Subnet (`172.16.30.0/24`)** or the dedicated hardware **Management Out-of-Band segment (`172.16.50.0/24`)**.

```text
  [ Administrative Terminal ] ──> Requests Secure Port 22 Sync ──> [ Stateful Input Firewall Chain ]
                                                                                │
                     ┌──────────────────────────────────────────────────────────┴──────────────────────────┐
                     ▼ Origin Validated (IT Zone / Management Subnet)                                      ▼ Origin Denied (HR/Sales/External)
        [ Asymmetric Key Exchange ]                                                                  [ Silent Drop 🛑 ]
                     │
                     ▼
  [ Encrypted Symmetric Session Built ] ──> (Full CLI Access Granted via Secure Channel)
```

---

## 🛡️ Administrative Services Hardening Matrix

Before enabling remote administrative access, an inventory baseline audit was executed across all `HQ` and `Branch` routing systems to close unencrypted listener daemons.

| Infrastructure Management Protocol | Baseline Status | Post-Hardening State | Operational Security Objective |
| :--- | :--- | :--- | :--- |
| **Telnet (TCP Port 23)** | ❌ Active | 🛑 **Disabled Globally** | Prevents clear-text transmission of root administrative credentials. |
| **FTP (TCP Port 21)** | ❌ Active | 🛑 **Disabled Globally** | Eliminates unencrypted local file transfer vulnerabilities. |
| **HTTP WWW (TCP Port 80)** | ❌ Active | 🛑 **Disabled Globally** | Blocks clear-text web browser dashboard entry points. |
| **API / API-SSL (Ports 8728/8729)**| ❌ Active | 🛑 **Disabled Globally** | Prevents automated programmatic exploit scripts at the perimeter. |
| **Secure Shell (SSH - Port 22)** | ❌ Active | ✅ **Active & Hardened** | Enforces asymmetric key session encryption with strong ciphers. |

---

## 🛠️ RouterOS v7 Production Script Configuration

The configuration scripts below disable vulnerable default services, establish a custom network administrator account with full write access, generate secure crypto keys, and enforce strict modern ciphers across all devices.

### 1. Corporate Core Routing Fabric Hardening Script (`HQ-R1` & `HQ-R2`)
```routeros
# =====================================================================
# 1. DEPRECATE INSECURE CLEAR-TEXT MANAGEMENT SERVICES
# =====================================================================
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes

# =====================================================================
# 2. ENFORCE HIGH-STRENGTH CRYPTOGRAPHIC CIPHER GENERATION
# =====================================================================
/ip ssh
set strong-crypto=yes forwarding-enabled=no connection-timeout=15m

# =====================================================================
# 3. PROVISION INDEPENDENT NETWORK ADMINISTRATOR PRIVILEGED ACCOUNT
# =====================================================================
/user
# Create explicit administrative group identity tracking credential
add name=netadmin group=full password=HardenedCorporateAdminPassword2026!

# Disable the generic default 'admin' manufacturing account string
disable admin
```

### 2. Remote Area Border Branch Provisioning Script (`BR1-R1` & `BR2-R1`)
```routeros
# Apply matching service control policies to branch perimeters
/ip service set telnet=yes ftp=yes www=yes api=yes api-ssl=yes disabled=yes
/ip ssh set strong-crypto=yes forwarding-enabled=no connection-timeout=15m
/user add name=netadmin group=full password=HardenedBranchAdminPassword2026!
/user disable admin
```

---

## 📑 Documentation Evidence

#### Figure 1. Active Administrative Services Status
![SSH Service Configuration](../images/phase-10/ssh-service-configuration.png)
*Active RouterOS service display confirming all plaintext daemons are disabled, leaving only the hardened SSH engine active.*

---

#### Figure 2. Privileged Access Account Provisioning
![Administrator Account Configuration](../images/phase-10/administrator-account-configuration.png)
*System account management log showing the default admin profile disabled and replaced by the custom `netadmin` profile.*

---

## 🔍 Remote Terminal Cryptographic Handshake & Validation

Once configuration scripts synchronized across the fabric, verification sweeps were executed from the network engineer workstation (`ADMIN-PC` at `172.16.50.10`) using an advanced terminal emulator client to audit handshake stability.

During connection initialization, the router successfully presented its cryptographic signature, validating host identity parameters:

```text
$ ssh netadmin@172.16.50.1
The authenticity of host '172.16.50.1 (172.16.50.1)' can't be established.
ED25519 key fingerprint is SHA256:uR9B4vN1k8MxP5zZ2wQ3cR7aT9yU2iO4pE6sW8qA0bE.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
netadmin@172.16.50.1's password: 

[netadmin@HQ-R1] > /ip/service/print
Flags: X - disabled, I - invalid 
 #   NAME      PORT  ADDRESS
 0 X telnet    23
 1 X ftp       21
 2   ssh       22
 3 X www       80
```

The remote terminal connection established successfully, confirming that cryptographic enforcement works seamlessly across the out-of-band architecture.

---

#### Figure 3. Encrypted Remote Login Verification
![SSH Login Verification](../images/phase-10/ssh-login-verification.png)
*Terminal console capture proving successful remote authentication to the core router using the `netadmin` account over a secure channel.*

---

#### Figure 4. Active Crypto Session Integrity Audit
![Secure Management Validation](../images/phase-10/secure-management-validation.png)
*Active administrative session log verifying that the remote connection uses modern, secure cryptographic ciphers.*

---

## 🔍 Validation Matrix

| Target Verification Control Item | Current Status | Technical Metrics / Observations & Audit Details |
| :--- | :--- | :--- |
| **Insecure Management Daemons Closed**| ✅ Validated | Port scanner utility checks show ports 21, 23, and 80 are closed. |
| **Modern Crypto Cipher Suite Active** | ✅ Validated | `strong-crypto=yes` locks down negotiation to secure ED25519/RSA structures. |
| **Default Factory Profile Disabled** | ✅ Validated | Default account access attempts are blocked, stopping basic credential brute-forcing. |
| **Privileged Custom Account Active**  | ✅ Validated | `netadmin` identity profile successfully manages full system write operations. |
| **Out-of-Band SSH Connections Clear** | ✅ Validated | Low-latency terminal management sessions validated from the administration workspace. |
| **Firewall Perimeter Control Intact**  | ✅ Verified | Cross-zone probing attempts from unmapped departments are blocked. |

---

## 🎯 Phase Outcome
Phase 10 has successfully achieved all secure terminal management criteria. Unencrypted configuration vectors have been completely removed from the environment. Device administration is now fully protected using modern cryptographic ciphers, privileged user access profiles prevent unauthorized login attempts, and out-of-band terminal connections are limited strictly to verified networks. The hardened infrastructure control plane has passed all system readiness checks and is fully ready for Phase 11, where we will configure centralized operations event collection using **Syslog Services**.
```
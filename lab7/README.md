# Ansible Automation Platform Installation and Configuration

## Objective

Install and configure Ansible Automation Platform (AAP) on control nodes, create inventories of a managed host, and perform ad-hoc commands to check functionality.

---

## **Prerequisites**

- A Linux-based control node (RHEL 8/9 recommended).
- Internet access or a local repository for package installations.
- A managed host with SSH access enabled.
- `sudo` privileges on the control node.

---

## **Step 1: Install Ansible Automation Platform**

### **1.1 Update System Packages**

```bash
sudo dnf update -y
```

### **1.2 Enable Required Repositories**

```bash
sudo subscription-manager repos --enable ansible-automation-platform-2.4-for-rhel-9-x86_64-rpms
```

### **1.3 Install Ansible Automation Platform**

```bash
sudo dnf install ansible -y
```

### **1.4 Verify Installation**

```bash
ansible --version
```

---

## **Step 2: Configure Ansible Inventory**

### **2.1 Create an Inventory File**

```bash
sudo mkdir -p /etc/ansible && sudo touch /etc/ansible/hosts
```

### **2.2 Add Managed Hosts to Inventory**

Edit `/etc/ansible/hosts`:

```ini
[web]
192.168.1.10 ansible_user=devops ansible_ssh_private_key_file=~/.ssh/id_rsa

[db]
192.168.1.11 ansible_user=devops ansible_ssh_private_key_file=~/.ssh/id_rsa
```

### **2.3 Test Inventory**

```bash
ansible all -m ping
```

---

## **Step 3: Perform Ad-Hoc Commands**

### **3.1 Check Connectivity**

```bash
ansible all -m ping
```

### **3.2 Gather System Information**

```bash
ansible all -m setup
```

### **3.3 Install a Package on Remote Hosts**

```bash
ansible web -m yum -a "name=httpd state=present" --become
```

### **3.4 Start a Service**

```bash
ansible web -m service -a "name=httpd state=started" --become
```

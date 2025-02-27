# Ansible Automation Project

## Overview
This project consists of Ansible playbooks to automate user creation, web server installation, and public key authentication setup on remote hosts. The playbooks adapt based on the operating system distribution and utilize Ansible Vault for secure credential storage.

## Files in the Repository

- **amir_secret.yml** - Ansible Vault-encrypted file containing sensitive credentials.
- **ansible.cfg** - Ansible configuration file specifying default settings.
- **hosts** - Inventory file listing remote hosts.
- **index.html** - HTML file used as a sample web page.
- **local_vars.yml** - Contains local variables used in the playbooks.
- **my-playbook.yml** - Playbook to create a user and install a web server based on the OS distribution.
- **new_template.txt** - Template file used in Ansible tasks.
- **remote_send_publickey.yml** - Playbook to automate sending the authorized key using a stored password.

## Playbooks

### 1. `my-playbook.yml`
This playbook performs the following tasks:
- Creates a new user on the remote host.
- Installs a web server (Apache or Nginx) based on the OS distribution.
- Deploys a sample `index.html` page.

#### Usage:
```bash
ansible-playbook -i hosts my-playbook.yml --ask-vault-pass
```

### 2. `remote_send_publickey.yml`
This playbook automates the process of sending the authorized SSH key to remote hosts using the stored password.

#### Usage:
```bash
ansible-playbook -i hosts remote_send_publickey.yml --ask-vault-pass
```

## Prerequisites
- Ansible installed on the control machine.
- SSH access to remote hosts.
- Ansible Vault configured for secure credential management.
- Necessary permissions to execute tasks on remote hosts.

## Ansible Vault Handling
To view or edit the encrypted credentials:
```bash
ansible-vault view amir_secret.yml
ansible-vault edit amir_secret.yml
```

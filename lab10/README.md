# Ansible Playbook for Installing Docker, Jenkins, and OpenShift CLI

## Overview
This Ansible project automates the installation of Docker, Jenkins, and OpenShift CLI on remote EC2 instances running Ubuntu. The setup consists of three separate roles:

- **docker_install**: Installs Docker and its dependencies.
- **jenkins_install**: Installs Jenkins and its dependencies.
- **OC_CLI_install**: Installs OpenShift CLI (oc) and kubectl.

A single playbook (`playbook.yml`) orchestrates the execution of these roles on the remote hosts.

## Prerequisites
Ensure you have the following before running the playbook:

- Ansible installed on your local machine.
- SSH access to the target EC2 instances.
- An inventory file (`hosts`) containing the remote hosts.
- The `ansible.cfg` file correctly configured to use the appropriate SSH key and user.

## Directory Structure
```
.
├── ansible.cfg
├── hosts
├── playbook.yml
├── roles
│   ├── docker_install
│   │   ├── tasks
│   │   │   └── main.yml
│   ├── jenkins_install
│   │   ├── tasks
│   │   │   └── main.yml
│   ├── OC_CLI_install
│   │   ├── tasks
│   │   │   └── main.yml
```

## Installation Steps

### 1. Configure the Inventory File (`hosts`)
Modify the `hosts` file to specify the target remote hosts:
```
[servers]
server1 ansible_host=<EC2_PUBLIC_IP_1> ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/<YOUR_PRIVATE_KEY>
server2 ansible_host=<EC2_PUBLIC_IP_2> ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/<YOUR_PRIVATE_KEY>
```

### 2. Run the Playbook
Execute the following command to run the playbook:
```bash
ansible-playbook -i hosts playbook.yml --become
```
This will install Docker, Jenkins, and OpenShift CLI on the remote hosts.

## Role Details

### Docker Installation (`docker_install`)
This role:
- Installs required dependencies (curl, gnupg, etc.).
- Adds the Docker GPG key and repository.
- Installs Docker Engine, CLI, and containerd.
- Ensures the Docker service is running and enabled on boot.

### Jenkins Installation (`jenkins_install`)
This role:
- Installs OpenJDK 17.
- Adds the Jenkins GPG key and repository.
- Installs Jenkins.
- Enables and starts the Jenkins service.

### OpenShift CLI Installation (`OC_CLI_install`)
This role:
- Installs `gpg` if missing.
- Downloads and extracts the OpenShift CLI (`oc`) and `kubectl`.
- Moves the binaries to `/usr/local/bin/`.
- Verifies the installation by checking the `oc version`.




# SSH Key-Based Authentication & Configuration for Easy Access

## Objective
The goal of this task is to generate SSH keys, enable passwordless SSH authentication from your local machine to a remote VM, and configure SSH for seamless access using the command `ssh ivolve` without specifying the username, IP address, or key manually.

## Steps to Achieve This

### 1. Generate SSH Key Pair
Run the following command on your local machine to create an SSH key pair:
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
- Press **Enter** to accept the default location (`~/.ssh/id_rsa`).
- If prompted, set a passphrase (or leave empty for no passphrase).

### 2. Copy the Public Key to the Remote VM
Use the following command to copy the public key to the remote VM:
```bash
ssh-copy-id user@remote-ip
```
If `ssh-copy-id` is not available, manually copy the key:
```bash
cat ~/.ssh/id_rsa.pub | ssh user@remote-ip "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
```

### 3. Test SSH Login Without Password
Now, try logging in without a password:
```bash
ssh user@remote-ip
```
If it works, the SSH key-based authentication is set up correctly.

### 4. Configure SSH for Simplified Access
Edit the SSH config file on your local machine:
```bash
nano ~/.ssh/config
```
Add the following configuration:
```
Host ivolve
    HostName remote-ip
    User user
    IdentityFile ~/.ssh/id_rsa
```
- Replace `remote-ip` with the actual IP of your VM.
- Replace `user` with your actual SSH username.
- Save and exit (`CTRL + X`, then `Y`, then `Enter`).

### 5. Connect Using Short Command
Now, simply run:
```bash
ssh ivolve
```
No need to specify the username, IP, or private key!

## Troubleshooting
- Ensure the SSH service is running on the remote machine:
  ```bash
  sudo systemctl status ssh
  ```
- Verify correct permissions for SSH files:
  ```bash
  chmod 700 ~/.ssh
  chmod 600 ~/.ssh/authorized_keys
  ```
- If issues persist, check SSH logs:
  ```bash
  tail -f /var/log/auth.log  # Ubuntu/Debian
  journalctl -xe | grep ssh  # Red Hat-based distros
  ```


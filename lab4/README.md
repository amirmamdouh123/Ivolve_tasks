# Demonstrating Hosts File vs. DNS for URL Resolution

## **Objective**
This project demonstrates the differences between using the `/etc/hosts` file and a DNS server (BIND9) for resolving domain names. It covers:

- Using the `/etc/hosts` file to map a domain to a specific IP.
- Configuring BIND9 as a DNS solution to resolve wildcard subdomains.
- Verifying resolution using `dig` or `nslookup`.

## **1. Using `/etc/hosts` for Local Name Resolution**
The `/etc/hosts` file allows you to manually define mappings between domain names and IP addresses. This method is **local to the machine** and does not require a DNS server.

### **Steps:**
1. Open the `/etc/hosts` file in a text editor:
   ```bash
   sudo nano /etc/hosts
   ```
2. Add an entry for the domain:
   ```
   192.168.1.10 name-ivolve.com
   ```
3. Save and exit.
4. Verify the resolution:
   ```bash
   ping name-ivolve.com
   ```

## **2. Setting Up BIND9 for DNS Resolution**
Unlike the hosts file, a DNS server like BIND9 can resolve domain names for multiple clients and support wildcard subdomains.

### **Steps:**
### **2.1 Install BIND9**
```bash
sudo apt update && sudo apt install bind9 -y
```

### **2.2 Configure BIND9**
#### **Edit the Local Configuration File**
```bash
sudo nano /etc/bind/named.conf.local
```
Add the following:
```conf
zone "name-ivolve.com" {
    type master;
    file "/etc/bind/zones/db.name-ivolve.com";
};
```

#### **Create the Zone File**
```bash
sudo mkdir -p /etc/bind/zones
sudo nano /etc/bind/zones/db.name-ivolve.com
```
Add:
```conf
$TTL 604800
@   IN  SOA ns1.name-ivolve.com. admin.name-ivolve.com. (
            2  ; Serial
            604800  ; Refresh
            86400  ; Retry
            2419200  ; Expire
            604800 )  ; Negative Cache TTL

@   IN  NS ns1.name-ivolve.com.
ns1 IN  A   192.168.1.10
@   IN  A   192.168.1.10
*   IN  A   192.168.1.10  ; Wildcard Subdomain
```

#### **Restart BIND9**
```bash
sudo systemctl restart bind9
```

#### **Verify BIND9 Configuration**
```bash
sudo named-checkzone name-ivolve.com /etc/bind/zones/db.name-ivolve.com
```

## **3. Testing DNS Resolution**
### **Using `dig` to Query the DNS Server**
```bash
dig name-ivolve.com @localhost
dig sub.name-ivolve.com @localhost  # Testing wildcard subdomain
```

### **Using `nslookup` to Query the DNS Server**
```bash
nslookup name-ivolve.com 127.0.0.1
nslookup sub.name-ivolve.com 127.0.0.1
```

## **Conclusion**
- `/etc/hosts` provides quick, manual mappings but is only local to the machine.
- BIND9 allows centralized DNS resolution and supports wildcard subdomains.
- DNS resolution is more scalable and ideal for managing multiple clients and dynamic subdomains.



# Multi-Tier Application Deployment with Terraform

## Overview
This project automates the deployment of a multi-tier application using Terraform. It sets up the following AWS resources:
- **VPC**: Uses a manually created VPC and fetches its ID using the Terraform `data` block.
- **Subnets**: Creates two subnets (public and private) within the VPC.
- **EC2 Instance**: Deploys a virtual machine for the application.
- **RDS Database**: Configures a managed database instance.
- **Provisioner**: Uses a local provisioner to save the EC2 instance's public IP in `ec2-ip.txt`.

## Project Structure
```
├── main.tf                # Main Terraform configuration file
├── public_subnet.tf       # Configuration for the public subnet
├── private_subnet.tf      # Configuration for the private subnet
├── private_subnet2.tf     # Additional private subnet configuration
├── instances_keys.tf      # EC2 instance and key pair configuration
├── ec2-id.txt             # Stores EC2 instance ID
├── vpc using terraform.doc # Additional documentation
```

## Prerequisites
- Terraform installed on your machine
- AWS credentials configured (`~/.aws/credentials` or environment variables)
- A manually created VPC named `ivolve`

## Deployment Steps
1. **Initialize Terraform**
   ```sh
   terraform init
   ```
2. **Plan the Deployment**
   ```sh
   terraform plan
   ```
3. **Apply the Configuration**
   ```sh
   terraform apply -auto-approve
   ```
4. **Retrieve the EC2 IP**
   The public IP of the EC2 instance will be saved in `ec2-ip.txt` automatically.
   ```sh
   cat ec2-ip.txt
   ```

## Cleanup
To destroy all created resources:
```sh
terraform destroy -auto-approve
```

## Notes
- Ensure the `ivolve` VPC is manually created before running Terraform.
- Modify security groups to restrict access to EC2 and RDS as needed.



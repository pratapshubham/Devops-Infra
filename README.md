# ☁️ Azure DevOps Infrastructure (DevopsInfra)

This repository contains the Infrastructure as Code (IaC) required to provision and manage cloud infrastructure on Microsoft Azure using **Terraform**. The project is designed with a highly modular architecture, ensuring reusability, scalability, and ease of maintenance.

## 🏗️ Architecture Overview

This project provisions a secure and scalable network topology and compute environment. Key features include:
* **Dynamic Resource Creation:** Utilizes advanced Terraform functions like `for_each` to dynamically deploy multiple subnets, VNets, and other resources.
* **Modular Design:** Resources are cleanly separated into individual modules.
* **Secure Access:** Implements Azure Bastion for secure RDP/SSH connectivity to Virtual Machines.

## 📂 Repository Structure

The code is organized into discrete modules for different Azure resources:

DevopsInfra/
├── azure_bastion/          # Provisions Azure Bastion Host for secure VM access
├── azure_resource_group/   # Manages foundational Resource Groups
├── azure_storage_account/  # Provisions scalable Azure Storage Accounts
├── azure_subnet/           # Manages VNet Subnets dynamically
├── azure_virtual_machine/  # Deploys Azure Virtual Machines (Linux/Windows)
├── azure_virtual_network/  # Sets up the primary Virtual Networks
├── azure_vnet_peering/     # Configures peering between different VNets
├── .gitignore              # Standard Terraform ignore file
├── main.tf                 # Root module tying all sub-modules together
├── variables.tf            # Global variable declarations
└── terraform.tfvars        # Values for the defined variables (Not committed to Git)


🛠️ Prerequisites
Before you begin, ensure you have the following installed and configured:

Terraform (v1.0.0 or higher)

Azure CLI

Active Microsoft Azure Subscription with appropriate Contributor/Owner RBAC permissions.

🚀 Deployment Guide
Follow these steps to deploy the infrastructure:

1. Authenticate with Azure
First, log in to your Azure account using the Azure CLI:

Bash
az login
az account set --subscription "<YOUR_SUBSCRIPTION_ID>"

2. Initialize Terraform
Initialize the working directory containing Terraform configuration files. This downloads the required Azure provider plugins.

Bash
terraform init

3. Review the Execution Plan
Generate and show an execution plan to see exactly what infrastructure will be created, updated, or destroyed.

Bash
terraform plan

4. Apply Configuration
Execute the actions proposed in a Terraform plan.

Bash
terraform apply -auto-approve


🔒 State Management
Currently, this repository is configured for local state management (or update this if using remote backend). For production environments, it is highly recommended to configure a Remote Backend using Azure Blob Storage to securely store the terraform.tfstate file and manage state locks.

🤝 Contributing
Fork the repository

Create your feature branch (git checkout -b feature/amazing-feature)

Format your code (terraform fmt)

Validate your configurations (terraform validate)

Commit your changes (git commit -m 'Add some amazing feature')

Push to the branch (git push origin feature/amazing-feature)

Open a Pull Request

# 🌐🐘 Azure PostgreSQL Flexible Server with VNet Integration using Terraform

## 📚 Introduction 

This repository provides Terraform code for deploying an Azure PostgreSQL Flexible Server with full VNet integration for enhanced security and data integrity.

## Architecture Diagram :building_construction:
![Architecture Diagram](./architecture.jpg)

## 🛠️ Prerequisites

- **Azure Subscription**
- **Terraform v0.14 or later**
- **Azure CLI**
- **Git**

## 📋 Instructions for Deployment

### 1. **Clone Repository**

```bash
git clone https://github.com/YourOrg/your_repo.git
cd your_repo
```

### 2. **Initialize Terraform**

```bash
terraform init
```

### 3. **Plan Deployment**

```bash
terraform plan
```

### 4. **Apply Deployment**

```bash
terraform apply
```

## 🧐 Validate Deployment

Check the Azure portal to ensure that the PostgreSQL Flexible Server and associated resources are successfully deployed.

## 🛡️ Using Azure Bastion for Secure Access

Azure Bastion provides seamless RDP and SSH connectivity to your virtual machines directly in the Azure portal over SSL. This means that you can navigate your VMs more securely without exposing them to the public Internet.

### Prerequisites

- An Azure account with an active subscription.
- Virtual Machines deployed through this Terraform script.
- Azure Bastion service configured (also deployed through this Terraform script).
- Azure Key Vault access to retrieve the VM password.

### Steps

#### 1️⃣ Retrieve Password from Azure Key Vault

Before connecting, retrieve your VM password stored in Azure Key Vault. Open Azure Portal and navigate to your Key Vault service, find the secret containing your VM password.

Important: Your AAD user object id (go to Microsoft Entra ID to find this) must have key access policy permissions to Set, List, and Get secrets from Key Vault in order to see the login/pw information. This is already set for you in Terraform key_vault.tf

#### 2️⃣ Navigate to Azure Portal

1. Go to the Azure Portal and sign in.
2. Navigate to **Virtual Machines**.
3. Select the VM you wish to connect to.

#### 3️⃣ Start Azure Bastion Service

1. Under the **Operations** section, click on **Bastion**.
2. Enter your **Username** (usually `adminuser` for Windows VMs deployed through this Terraform script).
3. Paste the **Password** you retrieved from Azure Key Vault.
4. Click **Connect**.

You will now have a secure RDP or SSH session directly in the Azure portal.

#### 4️⃣ Terminate Session

To end your Bastion session, simply log off from your RDP or SSH session. Your Bastion session will automatically terminate.

> **Note**: Always remember to store sensitive information like passwords securely. In this example, the passwords are stored in Azure Key Vault for enhanced security.

## 🤝 Contribute

Feel free to contribute to this project by opening a pull request or submitting an issue.

## ℹ️ Additional Information

For more information on Azure PostgreSQL Flexible Server, see [Azure Documentation](https://docs.microsoft.com/azure/postgresql/flexible-server).

Note: You may need to run ```terraform refresh``` after infrastructure is deployed to refresh state for subnet delegation

## 👩‍💼 Authors

- [Derek Nguyen](mailto:dereknguyen@example.com)

## 📝 License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

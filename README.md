## azure-three-tier-infra

This project demonstrates the design and automated deployment of a three-tier infrastructure on Microsoft Azure using Terraform and Azure DevOps CI/CD pipelines.
The infrastructure is designed using reusable Terraform modules and follows Infrastructure-as-Code (IaC) practices. Infrastructure changes are validated through a Pull Request pipeline before being merged and deployed through the main pipeline.

### Architecture

The infrastructure follows a three-tier architecture where the frontend and backend VMs are deployed in separate subnets and use private IP addresses. For the database, we use Azure SQL Database, which is a PaaS service.

The Application Gateway works as the entry point for the application and forwards incoming traffic to the frontend VMs. The frontend tier communicates with the backend tier through an Internal Load Balancer, which distributes the traffic between the backend VMs.

Azure Bastion is used to securely connect to the private VMs without assigning public IP addresses to them.

### High-Level Design

![Azure Three-Tier Infrastructure HLD](./docs/azure-three-tier-hld.png)

### Terraform Structure

I have created separate Terraform modules for different Azure resources instead of writing all the resources in a single Terraform configuration.

The modules folder contains reusable Terraform modules, while the environments folder contains environment-specific configurations. This allows the same modules to be reused for different environments without writing the same resource code again.

```text
azure-three-tier-infra/
│
├── modules/
│   ├── resource_group/
│   ├── vnet/
│   ├── subnet/
│   ├── nsg/
│   ├── nic/
│   ├── vm/
│   ├── load_balancer/
│   ├── application_gateway/
│   └── bastion/
│
├── environments/
│   ├── dev/
│   ├── qa/
│   └── prod/
│
├── azure-Infra-pr-pipelines.yml
├── azure-pipelines.yml
└── README.md
```
This structure makes the Terraform code easier to manage, reuse and maintain across multiple environments.

### CI/CD Pipeline

I have created separate Azure DevOps pipelines for Pull Request validation and infrastructure deployment.

PR Pipeline

The PR pipeline runs when a Pull Request is created for the main branch. It validates the Terraform changes before the code is merged.

The pipeline includes:

**Terraform format check**
**Terraform validation**
**TFLint**
**tfsec**
**Terraform Plan**
**Infracost**

This helps identify formatting, configuration, security and cost-related issues before merging the code.

Main Pipeline

The main pipeline runs after the changes are merged into the `main` branch.

The pipeline performs Terraform initialization and plan, followed by a manual approval before running `terraform apply`.

```text
Feature Branch
      ↓
Pull Request
      ↓
PR Validation Pipeline
      ↓
Review / Approval
      ↓
Merge to Main
      ↓
Main Pipeline
      ↓
Manual Approval
      ↓
Terraform Apply
```
## Tools & Technologies

| Category                | Tools / Services                                                |
| ----------------------- | --------------------------------------------------------------- |
| Cloud Platform          | Microsoft Azure                                                 |
| Infrastructure as Code  | Terraform                                                       |
| CI/CD                   | Azure DevOps                                                    |
| Version Control         | Git & GitHub                                                    |
| Networking              | VNet, Subnets, NSG, Application Gateway, Internal Load Balancer |
| Secure Access           | Azure Bastion                                                   |
| Secrets Management      | Azure Key Vault                                                 |
| Terraform State         | Azure Storage Account                                           |
| Database                | Azure SQL Database                                              |
| Code Quality & Security | TFLint, tfsec                                                   |
| Cost Estimation         | Infracost                                                       |


## What I Learned From This Project

This project helped me get hands-on experience with Terraform, Azure networking and CI/CD implementation.

Some of the key things I learned while working on this project are:

* Creating reusable **Terraform modules** for Azure resources.
* Managing Terraform state remotely using an **Azure Storage Account**.
* Understanding the traffic flow between **Application Gateway, frontend VMs, Internal Load Balancer and backend VMs**.
* Securing the infrastructure using **NSGs, private IP addresses, Azure Bastion and Key Vault**.
* Creating separate **PR and main pipelines** for validation and infrastructure deployment.
* Integrating **TFLint and tfsec** for code quality and security checks.
* Using **Infracost** to check estimated infrastructure cost before deployment.
* Working with **Pull Requests, approvals and Git-based infrastructure changes**.
* Troubleshooting Terraform, Azure networking and CI/CD pipeline issues during infrastructure deployment.




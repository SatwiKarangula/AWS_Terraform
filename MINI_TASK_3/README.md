# Oracle RDS Provisioning and Secrets Management using Terraform

## Project Overview

This project demonstrates the use of Terraform to provision an Oracle RDS instance on AWS and securely manage database credentials using AWS Secrets Manager.

The objective of the project is to automate database infrastructure deployment, implement secure credential management, and follow Infrastructure as Code (IaC) best practices.

---

# Objectives

## Part 1: Oracle RDS Provisioning

Provision an Oracle RDS instance with:

* Oracle Database Engine
* Instance Type: db.t3.small
* Allocated Storage: 20 GB
* Storage Encryption Enabled
* Backup Retention Period: 0 Days
* Resource Tagging
* Reusable Terraform Module

## Part 2: AWS Secrets Manager Integration

Store Oracle RDS connection details and credentials securely in AWS Secrets Manager.

Stored information includes:

* Endpoint
* Port
* Database Name
* Master Username
* Password

---

# Technologies Used

* Terraform
* AWS RDS
* Oracle Database
* AWS Secrets Manager
* AWS CLI
* Git
* GitHub

---

# Project Structure

```text
terraform-oracle-rds/
│
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── main.tf
├── outputs.tf
├── README.md
│
└── modules/
    └── oracle-rds/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

# Architecture

```text
Terraform
    │
    ▼
Oracle RDS Instance
    │
    ├── Endpoint
    ├── Port
    ├── Database Name
    ├── Username
    └── Password
            │
            ▼
AWS Secrets Manager
```

---

# Resource Tagging

All AWS resources are tagged with:

```text
Name = Satwik
Role = Intern
```

Purpose:

* Resource identification
* Cost tracking
* Resource management
* Governance

---

# Part 1 – Oracle RDS Deployment

## Terraform Module

A reusable Terraform module is created to provision Oracle RDS.

### Configuration

| Parameter        | Value       |
| ---------------- | ----------- |
| Engine           | Oracle SE2  |
| Instance Type    | db.t3.small |
| Storage          | 20 GB       |
| Encryption       | Enabled     |
| Backup Retention | 0 Days      |
| Public Access    | Disabled    |

### Benefits of Using a Module

* Reusability
* Scalability
* Maintainability
* Cleaner project structure

---

# Oracle RDS Resource

The module provisions an Oracle database instance using Terraform.

Features:

* Automated deployment
* Encrypted storage
* Configurable parameters through variables
* Tagged resources
* Output values for integration

---

# Required Outputs

The following outputs are generated after successful deployment:

## Endpoint

Example:

```text
satwik-oracle-rds.xxxxxx.ap-south-1.rds.amazonaws.com
```

## Port

```text
1521
```

## Database Name

```text
ORCL
```

## Instance ID

Example:

```text
satwik-oracle-rds
```

---

# Terraform Outputs

The project exposes:

```hcl
output "oracle_endpoint"
output "oracle_port"
output "oracle_database_name"
output "oracle_instance_id"
```

These outputs can be used by applications, scripts, or AWS Secrets Manager.

---

# Part 2 – AWS Secrets Manager Integration

## Objective

Store Oracle RDS credentials and connection details securely instead of exposing them directly in configuration files.

---

# Secret Information Stored

The following information is stored:

```json
{
  "endpoint": "satwik-oracle-rds.xxxxxx.ap-south-1.rds.amazonaws.com",
  "port": 1521,
  "database_name": "ORCL",
  "master_username": "admin",
  "password": "********"
}
```

---

# Secret Name

A meaningful secret name is used:

```text
satwik/oracle-rds/master-credentials
```

Benefits:

* Easy identification
* Better organization
* Supports future automation

---

# AWS Secrets Manager Resources

Terraform creates:

## Secret Container

Stores metadata about the secret.

## Secret Version

Stores the actual secret values in JSON format.

---

# Security Benefits

Using AWS Secrets Manager provides:

* Secure credential storage
* Encryption at rest
* Centralized secret management
* Reduced credential exposure
* Easier credential rotation

---

# Terraform Workflow

## Step 1: Initialize Terraform

```bash
terraform init
```

Purpose:

* Downloads providers
* Initializes Terraform environment
* Creates .terraform directory

---

## Step 2: Validate Configuration

```bash
terraform validate
```

Purpose:

* Checks Terraform syntax
* Detects configuration issues

---

## Step 3: Generate Execution Plan

```bash
terraform plan
```

Purpose:

* Preview infrastructure changes
* Verify resources before deployment

Example Resources:

```text
+ aws_db_instance.oracle_rds
+ aws_secretsmanager_secret.oracle_rds_secret
+ aws_secretsmanager_secret_version.secret_version
```

---

## Step 4: Apply Infrastructure

```bash
terraform apply
```

Purpose:

* Creates Oracle RDS
* Creates Secrets Manager secret
* Stores connection details

Terraform prompts:

```text
Do you want to perform these actions?
```

Enter:

```text
yes
```

---

## Step 5: Verify Resources

### RDS Verification

Navigate:

```text
AWS Console
→ RDS
→ Databases
```

Verify:

* Database Status = Available
* Endpoint Generated
* Port Generated

### Secrets Manager Verification

Navigate:

```text
AWS Console
→ Secrets Manager
→ Secrets
```

Open:

```text
satwik/oracle-rds/master-credentials
```

Select:

```text
Retrieve Secret Value
```

Verify:

* Endpoint
* Port
* Database Name
* Username
* Password

---

## Step 6: View Terraform Outputs

```bash
terraform output
```

Example:

```text
oracle_endpoint = satwik-oracle-rds.xxxxxx.ap-south-1.rds.amazonaws.com

oracle_port = 1521

oracle_database_name = ORCL

oracle_instance_id = satwik-oracle-rds
```

---

## Step 7: Destroy Infrastructure

```bash
terraform destroy
```

Purpose:

* Remove Oracle RDS
* Remove Secrets Manager resources
* Avoid unnecessary AWS charges

Terraform prompts:

```text
Do you really want to destroy all resources?
```

Enter:

```text
yes
```

---

# Learning Outcomes

Through this project, I gained practical experience in:

* Infrastructure as Code (IaC)
* Terraform Modules
* Oracle RDS Provisioning
* AWS Secrets Manager
* Secure Credential Management
* Resource Tagging
* Terraform Outputs
* Terraform State Management
* AWS Cloud Infrastructure
* Infrastructure Automation
* Terraform Lifecycle Commands

---

# Terraform Lifecycle

```text
Write Terraform Code
          ↓
terraform init
          ↓
terraform validate
          ↓
terraform plan
          ↓
terraform apply
          ↓
Verify Resources
          ↓
terraform output
          ↓
terraform destroy
```

---

# Author

K. Satwik
B.Tech – Computer Science Engineering (AI & ML)
Andhra Loyola Institute of Engineering and Technology

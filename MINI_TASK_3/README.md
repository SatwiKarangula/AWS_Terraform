# Oracle RDS Provisioning, Secrets Management, and User Onboarding using Terraform

## Project Overview

This project demonstrates Infrastructure as Code (IaC) using Terraform to automate the deployment of an Oracle RDS database on AWS, securely manage credentials using AWS Secrets Manager, and automate database user provisioning through Python.

The project follows Terraform best practices, modular design principles, resource tagging standards, and secure credential management.

---

# Objectives

The project is divided into three major parts:

### Part 1 – Oracle RDS Provisioning

* Deploy an Oracle RDS instance using Terraform
* Enable storage encryption
* Configure storage and backup settings
* Apply standard resource tags
* Generate Terraform outputs

### Part 2 – Secrets Manager Integration

* Store Oracle RDS connection details securely
* Store master credentials in AWS Secrets Manager
* Avoid hardcoding sensitive information

### Part 3 – User Provisioning and Secret Onboarding

* Connect to Oracle RDS using master credentials
* Create database users automatically
* Store user credentials in AWS Secrets Manager
* Apply tags based on privilege level

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
    ├── Master Credentials
    │
    ▼
AWS Secrets Manager
    │
    ▼
Python Automation Script
    │
    ├── Create ADMIN User
    ├── Create RWX User
    ├── Create READ User
    │
    ▼
AWS Secrets Manager
    ├── Admin Secret
    ├── RWX Secret
    └── Read Secret
```

---

# Technologies Used

* AWS RDS
* AWS Secrets Manager
* Terraform
* Python
* Oracle Database
* AWS CLI
* Git
* GitHub

---

# Project Structure

```text
oracle-rds-project/
│
├── versions.tf
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── main.tf
├── outputs.tf
├── README.md
│
├── scripts/
│   ├── user_script.py
│   └── verify_users.py
│
└── modules/
    └── oracle-rds/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

# Resource Tagging

All AWS resources are tagged using the following standard:

```text
Name = Satwik
Role = Intern
```

Additional user secrets receive:

```text
AccessLevel = ADMIN
AccessLevel = RWX
AccessLevel = READ
```

---

# Part 1 – Oracle RDS Deployment

## Configuration

| Property         | Value       |
| ---------------- | ----------- |
| Engine           | Oracle SE2  |
| Instance Class   | db.t3.small |
| Storage          | 20 GB       |
| Encryption       | Enabled     |
| Backup Retention | 0 Days      |

---

## Terraform Module

The Oracle RDS instance is deployed using a reusable Terraform module.

Benefits:

* Reusable code
* Modular structure
* Easy maintenance
* Improved scalability

---

## Terraform Commands

### Initialize

```bash
terraform init
```

Downloads required providers and initializes the Terraform project.

---

### Validate

```bash
terraform validate
```

Validates Terraform syntax.

---

### Plan

```bash
terraform plan
```

Shows the infrastructure changes before deployment.

---

### Apply

```bash
terraform apply
```

Creates AWS resources.

---

### Destroy

```bash
terraform destroy
```

Removes all AWS resources.

---

# Terraform Outputs

After successful deployment:

```bash
terraform output
```

Returns:

* Oracle Endpoint
* Oracle Port
* Oracle Instance ID

Example:

```text
oracle_endpoint = xyz.ap-south-1.rds.amazonaws.com
oracle_port = 1521
oracle_instance_id = satwik-oracle-rds
```

---

# Part 2 – AWS Secrets Manager

## Purpose

Store database connection information securely without exposing credentials in code.

---

## Secret Name

```text
satwik/oracle-rds/master-credentials
```

---

## Stored Information

```json
{
  "endpoint": "xyz.ap-south-1.rds.amazonaws.com",
  "port": 1521,
  "database_name": "ORCL",
  "master_username": "admin",
  "password": "********"
}
```

---

## Verification

AWS Console:

```text
Secrets Manager
→ Secrets
→ satwik/oracle-rds/master-credentials
→ Retrieve Secret Value
```

---

# Part 3 – User Provisioning Automation

## Purpose

Automatically create Oracle users and store their credentials securely.

---

## Users Created

| User  | Access Level |
| ----- | ------------ |
| admin | ADMIN        |
| rwx   | Read + Write |
| read  | Read Only    |

---

## Python Script

File:

```text
scripts/user_script.py
```

Functions:

* Retrieve master credentials from Secrets Manager
* Connect to Oracle RDS
* Create users
* Assign privileges
* Store user credentials in Secrets Manager

---

## User Secrets

Generated secrets:

```text
satwik/oracle-rds/admin
satwik/oracle-rds/rwx
satwik/oracle-rds/read
```

---

## Secret Tags

### Admin Secret

```text
Name = Satwik
Role = Intern
AccessLevel = ADMIN
```

### RWX Secret

```text
Name = Satwik
Role = Intern
AccessLevel = RWX
```

### Read Secret

```text
Name = Satwik
Role = Intern
AccessLevel = READ
```

---

# Verification Process

## Verify Oracle Connection

Run:

```bash
python verify_users.py
```

Expected:

```text
Connected Successfully
```

---

## Verify Users

Expected:

```text
Username: ADMIN
Username: RWX
Username: READ
```

---

## Verify Privileges

Expected:

```text
ADMIN → DBA

RWX → CONNECT
RWX → RESOURCE

READ → CONNECT
```

---

## Verify Secrets

Expected:

```text
Secret Found: satwik/oracle-rds/admin
Secret Found: satwik/oracle-rds/rwx
Secret Found: satwik/oracle-rds/read
```

---

# Security Considerations

* Sensitive credentials stored in AWS Secrets Manager
* No credentials hardcoded in Terraform files
* Secrets separated by privilege level
* Resource tagging applied consistently

---

# Terraform Standards Followed

* Modular Terraform design
* Separate variables and outputs
* No hardcoded resource values
* Reusable code structure
* Common tagging strategy
* Version-controlled infrastructure

---

# Learning Outcomes

Through this project, I gained hands-on experience in:

* Terraform Modules
* Infrastructure as Code (IaC)
* Oracle RDS Deployment
* AWS Secrets Manager
* AWS Resource Tagging
* Python Automation
* Oracle User Provisioning
* Secure Credential Management
* Terraform Best Practices
* Cloud Infrastructure Automation

---

# Author

K. Satwik,
B.Tech – Computer Science Engineering (AI & ML),
Andhra Loyola Institute of Engineering and Technology.

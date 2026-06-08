# Terraform AWS Infrastructure Mini Task

## Project Overview

This project demonstrates the use of Terraform to provision AWS infrastructure using Infrastructure as Code (IaC) principles.

The infrastructure created through Terraform includes:

* AWS S3 Bucket
* AWS IAM User
* Resource Tagging
* Variables and Outputs

The purpose of this project is to understand Terraform fundamentals, AWS resource provisioning, state management, and Infrastructure as Code practices.

---

# Technologies Used

* Terraform
* AWS
* S3
* IAM
* Git
* GitHub

---

# Project Objectives

The project provisions the following AWS resources:

### S3 Bucket

Used for object storage and data management.


### IAM User

Used for identity and access management.

### Resource Tagging

All resources are tagged with:

```text
Name = Satwik
Role = Intern
```

---

# Project Structure

```text
terraform-aws-mini-task/
│
├── local.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── .gitignore
├── provider.tf (if needed)
└── README.md

```

---

# File Description

## provider.tf

Defines the AWS provider configuration.

Example:

```hcl
provider "aws" {
  region = var.aws_region
}
```

---

## variables.tf

Contains input variables used throughout the project.

Example:

```hcl
variable "aws_region" {
  default = "ap-south-1"
}

variable "bucket_name" {
  type = string
}
```

---

## terraform.tfvars

Stores actual values for variables.

Example:

```hcl
bucket_name = "satwik-terraform-bucket"
```

---

## main.tf

Contains AWS resources:

* S3 Bucket
* IAM User

and resource tags.

---

## outputs.tf

Displays useful information after deployment.

Example:

```hcl
output "bucket_name" {
  value = aws_s3_bucket.project_bucket.bucket
}
```

---

# AWS Resources Created

## 1. S3 Bucket

Terraform provisions an S3 bucket for object storage.


## 2. IAM User

Terraform provisions an IAM user.


---

# Resource Tagging

All resources are tagged using a common tagging strategy.


# local.tf
Example:

```hcl
tags = {
  Name = "Satwik"
  Role = "Intern"
}
```

Tags help with:

* Resource identification
* Cost management
* Governance
* Resource organization

---

# Prerequisites

Before running the project, ensure the following are installed:

### Terraform

Verify installation:

```bash
terraform --version
```

---

### AWS CLI

Verify installation:

```bash
aws --version
```

---

### AWS Account

An active AWS account with appropriate permissions is required.

---

# AWS CLI Configuration

Configure AWS credentials:

```bash
aws configure
```

Provide:

```text
AWS Access Key ID
AWS Secret Access Key
AWS Region
Output Format
```

Example:

```text
AWS Access Key ID: **************
AWS Secret Access Key: **************
Default region name: ap-south-1
Default output format: json
```

---

# Terraform Workflow

## Step 1: Initialize Terraform

Initialize the working directory.

```bash
terraform init
```

Purpose:

* Downloads AWS provider plugins
* Creates .terraform directory
* Initializes Terraform project

Expected Output:

```text
Terraform has been successfully initialized!
```

---

## Step 2: Validate Configuration

Validate Terraform files.

```bash
terraform validate
```

Expected Output:

```text
Success! The configuration is valid.
```

---

## Step 3: Review Execution Plan

Preview infrastructure changes.

```bash
terraform plan
```

Purpose:

* Shows resources to be created
* Detects configuration issues
* No resources are created yet

Example:

```text
+ aws_s3_bucket.project_bucket
+ aws_dynamodb_table.project_table
+ aws_iam_user.project_user
```

---

## Step 4: Apply Configuration

Provision infrastructure.

```bash
terraform apply
```

Confirm:

```text
yes
```

Terraform creates all resources in AWS.

Expected Output:

```text
Apply complete!
Resources: 3 added.
```

---

## Step 5: Verify Resources

Verify resources in AWS Console.

### S3

AWS Console → S3

Verify bucket creation.

---

### DynamoDB

AWS Console → DynamoDB

Verify table creation.

---

### IAM

AWS Console → IAM → Users

Verify IAM user creation.

---

# Terraform Outputs

View outputs:

```bash
terraform output
```

Example:

```text
bucket_name = terraform-bucket
dynamodb_table = terraform-weather-table
iam_user = terraform-user
```

---

# Destroy Infrastructure

Remove all resources created by Terraform.

```bash
terraform destroy
```

Confirm:

```text
yes
```

Expected Output:

```text
Destroy complete!
Resources: 3 destroyed.
```

Purpose:

* Avoid unnecessary AWS charges
* Clean up infrastructure
* Demonstrate Terraform lifecycle management

---

# Git Workflow

Initialize repository:

```bash
git init
```

Add files:

```bash
git add .
```

Commit changes:

```bash
git commit -m "Initial Terraform AWS infrastructure project"
```

Push to GitHub:

```bash
git push origin main
```

---

# Troubleshooting

## AWS CLI Not Recognized

Error:

```text
'aws' is not recognized as an internal or external command
```

Solution:

* Install AWS CLI
* Restart terminal
* Verify PATH configuration

---

## Terraform Validation Errors

Run:

```bash
terraform validate
```

to identify configuration issues.

---

## AWS Authentication Issues

Verify credentials:

```bash
aws sts get-caller-identity
```

Successful output confirms authentication.

---

# Learning Outcomes

Through this project, the following concepts were learned:

* Infrastructure as Code (IaC)
* Terraform Fundamentals
* AWS Provider Configuration
* Resource Provisioning
* AWS S3
* AWS IAM
* Variables
* Outputs
* Resource Tagging
* Terraform Lifecycle
* AWS CLI Configuration
* Git & GitHub Workflow

---

# Terraform Lifecycle Demonstrated

```text
terraform init
        ↓
terraform validate
        ↓
terraform plan
        ↓
terraform apply
        ↓
terraform output
        ↓
terraform destroy
```

---

# Author

K. Satwik

B.Tech – Computer Science Engineering (Artificial Intelligence and Machine Learning)

Andhra Loyola Institute of Engineering and Technology

Vijayawada, Andhra Pradesh

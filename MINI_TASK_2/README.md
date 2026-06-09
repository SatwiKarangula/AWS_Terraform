# Terraform Dynamic S3 Bucket Creation Project

## Project Overview

The objective of this project is to practice Infrastructure as Code (IaC) using Terraform by dynamically creating multiple AWS S3 buckets from a single input variable and automatically uploading a sample file to each bucket.

The project demonstrates:

* Terraform Variables
* Dynamic Resource Creation
* AWS S3 Bucket Provisioning
* File Upload Automation
* Resource Tagging
* Terraform Best Practices
* Code Reusability
* Infrastructure Lifecycle Management

Instead of manually creating multiple S3 buckets, Terraform automatically provisions three buckets using a single base bucket name and uploads a sample file into each bucket.

---

# Technologies Used

* Terraform
* AWS S3
* AWS CLI
* Git
* GitHub

---

# Project Requirements

The project fulfills the following requirements:

Accept a base bucket name as input

Example:

```text
my-bucket
```

Dynamically create:

```text
my-bucket-1
my-bucket-2
my-bucket-3
```

Upload sample.txt to each bucket

Apply resource tags

```text
Name = Satwik
Role = Intern
```

Follow Terraform best practices

Organize project structure

---

# Project Structure

```text
terraform-s3-buckets/
│
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── main.tf
├── outputs.tf
├── sample.txt
├── README.md
└── .gitignore
```

---

# File Description

## provider.tf

Contains AWS provider configuration.

Purpose:

* Connect Terraform with AWS
* Specify AWS region

Example:

```hcl
provider "aws" {
  region = var.aws_region
}
```

---

## variables.tf

Contains reusable variables.

Purpose:

* Avoid hardcoded values
* Improve code flexibility

Example:

```hcl
variable "aws_region" {
  default = "ap-south-1"
}

variable "base_bucket_name" {
  type = string
}
```

---

## terraform.tfvars

Stores variable values.

Example:

```hcl
base_bucket_name = "my-bucket"
```

Terraform uses this value to generate bucket names dynamically.

---

## sample.txt

A sample file that will be uploaded to every S3 bucket.

Example:

```text
Hello from Terraform!

This file was uploaded automatically to AWS S3.
```

---

## main.tf

Contains all AWS resources.

Responsibilities:

* Create S3 buckets
* Upload sample file
* Apply tags

---

## outputs.tf

Displays useful information after deployment.

Example:

```hcl
output "bucket_names" {
  value = aws_s3_bucket.buckets[*].bucket
}
```

---

# Resource Tagging

All resources must contain the following tags:

```text
Name = Satwik
Role = Intern
```

Implementation:

```hcl
locals {

  common_tags = {
    Name = "Satwik"
    Role = "Intern"
  }

}
```

These tags are reused across all resources.

Benefits:

* Resource identification
* Cost tracking
* Better organization
* Compliance requirements

---

# Dynamic Bucket Creation

The project creates multiple buckets using Terraform's `count` meta-argument.

Example:

```hcl
resource "aws_s3_bucket" "buckets" {

  count = 3

  bucket = "${var.base_bucket_name}-${count.index + 1}"

  tags = local.common_tags

}
```

If:

```text
base_bucket_name = "my-bucket"
```

Terraform creates:

```text
my-bucket-1
my-bucket-2
my-bucket-3
```

automatically.

---

# File Upload Automation

Terraform uploads the same file to every bucket.

Example:

```hcl
resource "aws_s3_object" "sample_file" {

  count = 3

  bucket = aws_s3_bucket.buckets[count.index].id

  key = "sample.txt"

  source = "sample.txt"

  etag = filemd5("sample.txt")

}
```

This uploads:

```text
sample.txt
```

to:

```text
my-bucket-1
my-bucket-2
my-bucket-3
```

---

# Prerequisites

Before running this project ensure:

## Terraform Installed

Verify:

```bash
terraform --version
```

---

## AWS CLI Installed

Verify:

```bash
aws --version
```

---

## AWS Account

An active AWS account with permissions to create:

* S3 Buckets
* S3 Objects

---

# Configure AWS CLI

Run:

```bash
aws configure
```

Provide:

```text
AWS Access Key ID
AWS Secret Access Key
Default Region
Output Format
```

Example:

```text
AWS Access Key ID: ****************
AWS Secret Access Key: ****************
Default Region: ap-south-1
Output Format: json
```

---

# Terraform Workflow

## Step 1: Initialize Terraform

Initialize Terraform working directory.

Command:

```bash
terraform init
```

Purpose:

* Download AWS provider
* Create .terraform directory
* Prepare Terraform environment

Expected Output:

```text
Terraform has been successfully initialized!
```

---

## Step 2: Validate Configuration

Validate Terraform files.

Command:

```bash
terraform validate
```

Purpose:

* Check syntax
* Verify resource definitions

Expected Output:

```text
Success! The configuration is valid.
```

---

## Step 3: Review Execution Plan

Generate execution plan.

Command:

```bash
terraform plan
```

Purpose:

* Preview infrastructure changes
* Verify resources before creation

Expected Output:

```text
+ aws_s3_bucket.buckets[0]
+ aws_s3_bucket.buckets[1]
+ aws_s3_bucket.buckets[2]

+ aws_s3_object.sample_file[0]
+ aws_s3_object.sample_file[1]
+ aws_s3_object.sample_file[2]
```

No resources are created during this stage.

---

## Step 4: Apply Configuration

Create AWS resources.

Command:

```bash
terraform apply
```

Terraform asks:

```text
Do you want to perform these actions?
```

Enter:

```text
yes
```

Purpose:

* Create 3 S3 buckets
* Upload sample.txt
* Apply tags

Expected Output:

```text
Apply complete!
Resources: 6 added.
```

---

## Step 5: Verify Resources in AWS

Login to AWS Console.

Navigate:

```text
AWS Console → S3
```

Verify:

```text
my-bucket-1
my-bucket-2
my-bucket-3
```

Open each bucket and verify:

```text
sample.txt
```

exists inside.

---

## Step 6: View Outputs

Display Terraform outputs.

Command:

```bash
terraform output
```

Example:

```text
bucket_names = [
  "my-bucket-1",
  "my-bucket-2",
  "my-bucket-3"
]
```

---

## Step 7: Destroy Infrastructure

Remove all resources created by Terraform.

Command:

```bash
terraform destroy
```

Terraform asks:

```text
Do you really want to destroy all resources?
```

Enter:

```text
yes
```

Purpose:

* Delete all buckets
* Delete uploaded objects
* Prevent AWS charges

Expected Output:

```text
Destroy complete!
Resources: 6 destroyed.
```

---

# Terraform Workflow Diagram

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

# Code Reusability

This project is reusable because:

Instead of hardcoding bucket names:

```text
project-bucket-1
project-bucket-2
project-bucket-3
```

Terraform uses:

```hcl
base_bucket_name
```

Changing:

```hcl
base_bucket_name = "project-storage"
```

automatically creates:

```text
project-storage-1
project-storage-2
project-storage-3
```

without modifying resource definitions.

This follows Infrastructure as Code best practices.

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

Commit:

```bash
git commit -m "Initial Terraform S3 bucket project"
```

Push:

```bash
git push origin main
```

---

# Learning Outcomes

Through this project, I learned:

* Infrastructure as Code (IaC)
* Terraform Variables
* Terraform count Meta-Argument
* Dynamic Resource Creation
* AWS S3 Bucket Provisioning
* S3 Object Uploads
* Resource Tagging
* Terraform Outputs
* Terraform State Management
* AWS CLI Configuration
* Git and GitHub Workflow
* Terraform Lifecycle Commands

---

# Author

K. Satwik

B.Tech – Computer Science Engineering (Artificial Intelligence and Machine Learning)

Andhra Loyola Institute of Engineering and Technology

Vijayawada, Andhra Pradesh

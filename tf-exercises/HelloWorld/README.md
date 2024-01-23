# Introduction to Terraform CLI and HCL

The core Terraform workflow consists of three main steps after you have written your Terraform configuration:

    **Initialize** prepares your workspace so Terraform can apply your configuration.
    **Plan** allows you to preview the changes Terraform will make before you apply them.
    **Apply** makes the changes defined by your plan to create, update, or destroy resources.

When you initialize a Terraform workspace, Terraform configures the backend, installs all providers and modules referred to in your configuration, and creates a version lock file if one doesn't already exist. In addition, you can use the terraform init command to change your workspace's backend and upgrade your workspace's providers and modules.

## Learning Goals

- Familiarize yourself with the Hashicorp Configuration Language
- Initialize your Terraform workspace
- Plan and apply the resources in your Terraform configuration 
- Inspect the Terraform state file
- Destroy Terraform resources
  
## Introduction

In this exercise, you will be running your first Terraform CLI commands.

## Exercise

### Overview

In this exercise, you will:

- Initialize your workspace
- Create a basic Hello World display on localhost:8000 using Terraform CLI commands
- Destroy the created resource
- Explore further subcommands

### Tasks

**Initialize workspace**

```bash
terraform init
```

💡 Notice the new files generated in the project folder.

**Create resource with Terraform**

Optionally you can run 

```bash
terraform validate
```

```bash
terraform plan
```

```bash
terraform apply
```

**Access the created resource**

Should be available on localhost:8000

**Destroy resource**

```bash
terraform destroy
```

:bulb: **Terraform Best Practice #1**

Always make sure to delete resources you won't need once done with a session. // Use .gitignore to exclude Terraform state files, state directory backups, and core dumps.

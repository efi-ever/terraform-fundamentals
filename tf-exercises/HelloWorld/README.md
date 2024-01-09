# Introduction to Terraform CLI

## Learning Goals

- Initialize your Terraform workspace
- Plan and apply the resources in your Terraform configuration file
- Destroy Terraform resources
- Explore additional subcommands
  
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

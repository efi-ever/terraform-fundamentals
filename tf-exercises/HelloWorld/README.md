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

**Run Terraform init**

```bash
terraform init
```

💡 Notice the new files generated in the project folder.

:bulb: **Terraform Best Practice #1**

Always make sure to delete resources you won't need once done with a session. // Use .gitignore to exclude Terraform state files, state directory backups, and core dumps.

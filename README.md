# terraform-fundamentals

Exercises for the Terraform Fundamentals course by Eficode

💡 **About Terraform**

Terraform serves as an infrastructure as code (IaC) tool designed to automate the provisioning and management of cloud resources. Users define their desired infrastructure configuration using HashiCorp Configuration Language (HCL), allowing for the creation, modification, and scaling of resources across various cloud platforms such as AWS, Azure, and Google Cloud. Its core functionalities include a declarative syntax, modular design with reusable components called modules, and a "plan" execution model that calculates and presents actions needed to achieve the desired state. Terraform enhances collaboration, ensures infrastructure consistency, and supports a version-controlled, collaborative approach to managing cloud environments.

## Learning Goals

   - **Infrastructure as Code Fundamentals**: Understand the principles of Infrastructure as Code (IaC) and the declarative vs. imperative programming paradigm. Learn to express infrastructure configurations using Terraform's HashiCorp Configuration Language (HCL) and grasp the significance of version control for maintaining a version-controlled, collaborative approach.

   - **Terraform Basics and CLI Commands**: Master the essential Terraform commands and their lifecycle, including init, plan, apply, and destroy. Familiarize yourself with the Terraform CLI, its installation, and common commands for initializing working directories, provisioning infrastructure, and managing state.

   - **Managing Terraform Resources**: Gain practical experience in managing Terraform resources by applying pre-baked modules to deploy infrastructure, such as an Azure Function with a web page. Understand the workflow of building, modifying, and destroying resources, ensuring a hands-on understanding of Terraform's core functionalities.

   - **Terraform Variables and State Management**: Explore the use of variables in Terraform, including their definition, usage, and considerations for maintaining clean and modular code. Dive into Terraform state, differentiating between local and remote states, and learn crucial state management commands such as terraform state list and terraform import.

Exercise list in order:

# Setup of training environment, CLI, HCL Syntax
* [Setup your Terraform training environment](setup.md)

* [01 - Terraform CLI](https://github.com/eficode-academy/terraform-fundamentals/tree/noemi/test-exercises/tf-exercises/TerraformCLI/README.md)

* [02 - HCL Syntax](https://github.com/eficode-academy/terraform-fundamentals/tree/noemi/test-exercises/tf-exercises/HCLSyntax/README.md)

* [03 - Introduction to Terraform - Hello World!](https://github.com/eficode-academy/terraform-fundamentals/tree/noemi/test-exercises/tf-exercises/HelloWorld/README.md)

# Terraform State
* [04 - Local vs Remote State](https://github.com/eficode-academy/terraform-fundamentals/tree/noemi/test-exercises/tf-exercises/State/README.md)

# Terraform Providers
* [05 - Providers](https://github.com/eficode-academy/terraform-fundamentals/tree/noemi/test-exercises/tf-exercises/Providers/README.md)

# Modules WIP
* [06 - Modules](https://github.com/eficode-academy/terraform-fundamentals/blob/noemi/test-exercises/tf-exercises/TFModules/README.md)

# Advanced commands: Functions and Expressions
* [07 - Advanced commands: depends on, foreach, count, conditional expressions, dynamic blocks]()

# Terraform Resources
* [08 - Resources](https://github.com/eficode-academy/terraform-fundamentals/tree/noemi/test-exercises/tf-exercises/Resources/README.md)

# Terraform Variables
* [09 - Variables: local, tfvars](https://github.com/eficode-academy/terraform-fundamentals/tree/noemi/test-exercises/tf-exercises/Variables/README.md)

# Best Practices

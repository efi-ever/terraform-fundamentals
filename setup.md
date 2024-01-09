# Setup

💡 **About Terraform**

Terraform serves as an infrastructure as code (IaC) tool designed to automate the provisioning and management of cloud resources. Users define their desired infrastructure configuration using HashiCorp Configuration Language (HCL), allowing for the creation, modification, and scaling of resources across various cloud platforms such as AWS, Azure, and Google Cloud. Its core functionalities include a declarative syntax, modular design with reusable components called modules, and a "plan" execution model that calculates and presents actions needed to achieve the desired state. Terraform enhances collaboration, ensures infrastructure consistency, and supports a version-controlled, collaborative approach to managing cloud environments.

## Learning Goals

   - **Infrastructure as Code Fundamentals**: Understand the principles of Infrastructure as Code (IaC) and the declarative vs. imperative programming paradigm. Learn to express infrastructure configurations using Terraform's HashiCorp Configuration Language (HCL) and grasp the significance of version control for maintaining a version-controlled, collaborative approach.

   - **Terraform Basics and CLI Commands**: Master the essential Terraform commands and their lifecycle, including init, plan, apply, and destroy. Familiarize yourself with the Terraform CLI, its installation, and common commands for initializing working directories, provisioning infrastructure, and managing state.

   - **Managing Terraform Resources**: Gain practical experience in managing Terraform resources by applying pre-baked modules to deploy infrastructure, such as an Azure Function with a web page. Understand the workflow of building, modifying, and destroying resources, ensuring a hands-on understanding of Terraform's core functionalities.

   - **Terraform Variables and State Management**: Explore the use of variables in Terraform, including their definition, usage, and considerations for maintaining clean and modular code. Dive into Terraform state, differentiating between local and remote states, and learn crucial state management commands such as terraform state list and terraform import.

   - **Advanced Terraform Features**: Delve into advanced Terraform features such as depends_on, for_each, count, conditional expressions, and dynamic blocks. Understand how these features contribute to creating more dynamic and flexible infrastructure configurations, aligning with best practices and optimizing code efficiency.

## Exercise

Set up your training environment by installing Terraform and Azure CLI.

### Prerequisites

  - Install Terraform
  - Install Azure CLI
  - Login to Azure CLI
  - Create Service Principal

### Install Terraform

💡 The installation method depends on the operating system you are using.
Find the options on the official Terraform site here: https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli#install-terraform

#### Verify the installation 

Run the following command in your terminal.

``` bash
terraform -help
Usage: terraform [-version] [-help] <command> [args]

The available commands for execution are listed below.
The most common, useful commands are shown first, followed by
less common or more advanced commands. If you're just getting
started with Terraform, stick with the common commands. For the
other commands, please read the help and docs before usage.

#...
```
### Install Azure CLI

Find the installation method most suitable for your operating system on the official Microsoft website:
https://learn.microsoft.com/en-us/cli/azure/install-azure-cli

#### Login to Azure CLI

Terraform must authenticate to Azure to create infrastructure.

In your terminal, use the Azure CLI tool to setup your account permissions locally.

``` bash
az login
```

#### Create Service Principal

A Service Principal is an application within Azure Active Directory with the authentication tokens Terraform needs to perform actions on your behalf. Update the <SUBSCRIPTION_ID> with the subscription ID you specified in the previous step.

``` bash
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"

Creating 'Contributor' role assignment under scope '/subscriptions/35akss-subscription-id'
The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
{
  "appId": "xxxxxx-xxx-xxxx-xxxx-xxxxxxxxxx",
  "displayName": "azure-cli-2022-xxxx",
  "password": "xxxxxx~xxxxxx~xxxxx",
  "tenant": "xxxxx-xxxx-xxxxx-xxxx-xxxxx"
}
```

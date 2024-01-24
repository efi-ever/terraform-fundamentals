# Setup

## Learning Goals

- Set up your training environment by installing Terraform

- Initialize your workspace

- Practice use the CLI
## Exercise

### Prerequisites

  - Install Terraform CLI
  - Install Azure CLI
  - Login to Azure CLI
  - Create Service Principal

### Install Terraform CLI

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

#### Check Terraform version
``` bash
terraform version
```

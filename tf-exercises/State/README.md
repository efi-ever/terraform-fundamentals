## Learning Goals

This track gets you hands-on with Terraform state and how to manipulate it. Throughout this challenge, you learn how further view state, modify it, and understand the concepts and benefits of remote state.

# Introduction to Viewing Terraform State

In this challenge, you will dive into Terraform state and how to work with it. Recall your state is to store bindings between objects in a remote system and resources declared in your Terraform code.

To start, copy the below snippet into the main.tf file and save it.

``` bash
# main.tf

# This generates a random string with 16 characters
resource "random_string" "random" {
  length = 16
}
```

Once saved, run a terraform init and terraform apply to initialize your workspace and generate the random string.

Once done, you will notice a file called terraform.tfstate if you run an ls in your terminal. This file is what Terraform will use to keep track of what has been built.

We can inspect what is in the state file with a simple cat command shown below. You will see information such as terraform version and all of the resources you have provisioned along with their providers.

``` bash
cat terraform.tfstate
```

Terraform provides a more user-friendly way to view what is in state via the state list subcommand which gives you a list resources within a Terraform state file.

Try it out by running the command below:

``` bash
terraform state list
```

You will see a single line that shows the random string you recently provisioned. As you manage more and more resources with Terraform, the list subcommand can become a very handy tool.

What if you want to see more information about a specific resource in your state file? You can do this by passing the resource's name with the state show subcommand.

Give it a try by running the command shown below:

``` bash
terraform state show random_string.random
```

You now get much more information about the particular you previously deployed.

With that, you have successfully completed the state challenge. We have just scratched the surface here with Terraform state. In future labs, you will work with remote state and learn how to do some state recovery.

# Replacing Resources in Terraform

In this challenge, you will replace the current random string resource.

To replace a resource, you must run the apply subcommand and pass it a specific argument -replace that will contain the resource you want to replace. Terraform will only re-create a resource if it detects a change that would cause it to need to be re-created. Sometimes a resource will need to be replaced to apply after-effects. These could be changes to cloud-init scripts or other effects that Terraform cannot readily detect have changed.

Attempting to re-create the resource by running an apply will see no changes, because Terraform has not detected any changes that would require an update to state. You can test this by trying to run an apply command as shown below:

``` bash
terraform apply
```

You will see that Terraform has detected no changes and will not re-create the resource and thus the random string will be the same as it was before. You can confirm this by running the show command as in the previous lab:
``` bash
terraform state show random_string.random
```

To actually replace the resource and get a new random string you will need to run the following command to replace the random string:

``` bash
terraform apply -replace=random_string.random
```

You will be prompted that Terraform will need to destroy the current random string and replace it with a newly created one. You can accept the changes. As expected, Terraform has destroyed and re-created the random string resource. To confirm this run the show command again and confirm it is different from before:

``` bash
terraform state show random_string.random
```

# Moving Resources in Terraform State

In this challenge, you will start to work with Terraform state more closely and begin to further manipulate it.

Currently, in your main.tf you have a resource named random_string.random. Assume you need to rename this resource to random_string.my_random_string in your code, how can you reflect that change in state?

To start, update your main.tf to reflect the following snippet:

``` bash
# main.tf

# This generates a random string with 16 characters
resource "random_string" "my_random_string" {
  length = 16
}
```

Now lets see how this change will affect state by running a plan as shown below:

``` bash
terraform plan
```

If you run a terraform plan now, you will notice that Terraform wants to replace the resource currently deployed with the new one defined. This is because Terraform assumes you want to destroy the current string and redeploy with the new resource name.

To prevent this, you can modify Terraform's state to be updated with the new name using the state mv subcommand as shown below:

``` bash
terraform state mv random_string.random random_string.my_random_string
```

Once updated, you can run an apply now and notice that Terraform no longer needs to make any change. Go ahead and run the apply command as shown below:

``` bash
terraform apply
```

To confirm the newly updated resource name exists in state run the following command:

``` bash
terraform state list
```

You should see that there is no random_string.random in state but rather a random_string.my_random_string with the same value as the previous random string.

# Manually Removing Resources in Terraform State

In this challenge, we will look at the state rm subcommand. This provides a way to remove a specific resource from your state file. Although this should be thought of as a last resort, it can be a useful subcommand to let Terraform know of a change that happened outside of it (ie. a resource was removed/deleted manually outside of Terraform).

To test this out, you will remove your random_string resource from state by running the following command:

``` bash
terraform state rm random_string.my_random_string
```

Once run, Terraform will confirm that you have successfully removed the resource from state. Now if you list out your state as shown below, you will see that it is empty.

``` bash
terraform state list
```

As expected, your resource is no longer present and Terraform is no longer tracking it. Since Terraform uses state to check what it needs to build, it will rebuild your random string if you run an apply. Give it a try!

``` bash
terraform apply
```

You will now be prompted that random_string.my_random_string will be added, since Terraform does not see it in the state. Once accepted, you can run another terraform state list and see the resource listed once again.

# Leveraging Terraform Remote State

Currently in this track, you have been working with local Terraform state, ie. your state is kept in the file terraform.tfstate. When working with a team, using a local file makes collaborating complicated as it requires all users to constantly ensure they have the latest state.

In this challenge, you will migrate your state to Azure Blob Storage to house your state files, thus leveraging remote state.

*This part is to be pre-created and tested*

First, create an Azure Storage Account to use as a backend for Terraform state.

``` bash
# Set your Azure subscription ID
export ARM_SUBSCRIPTION_ID="your_subscription_id"

# Set your Azure resource group name
export ARM_RESOURCE_GROUP_NAME="your_resource_group_name"

# Set a unique storage account name
export ARM_STORAGE_ACCOUNT_NAME="your_storage_account_name"

# Set a unique container name within the storage account
export ARM_CONTAINER_NAME="your_container_name"

# Create the Azure Storage Account
az storage account create --subscription $ARM_SUBSCRIPTION_ID --name $ARM_STORAGE_ACCOUNT_NAME --resource-group $ARM_RESOURCE_GROUP_NAME --sku Standard_LRS
```

Note: Make sure to replace "your_subscription_id," "your_resource_group_name," "your_storage_account_name," and "your_container_name" with your actual Azure subscription details.

💡 Note: Make note of the name generated below as you will need to reference it later.

Once your storage is created, we can create a new snippet that tells Terraform we no longer want to use local state. Open the file state.tf and copy the below snippet:

``` bash
# state.tf

terraform {
  backend "azurerm" {
    storage_account_name = "your_storage_account_name"
    container_name       = "your_container_name"
    key                  = "terraform.tfstate"
  }
}
```

Once copied over, we must re-initialize Terraform to let it know of the change. Run an init as shown below and accept the migration change.

``` bash
terraform init
```

Once done, you will have successfully migrated your Terraform state from local to remote stored in an S3 bucket!

Validate this by removing the state files from your local machine.

``` bash
rm terraform.tfstate*
```

Then run an apply to trigger Terraform moving state to the remote location - the S3 bucket defined within the terraform {} block the state.tf configuration file.

``` bash
terraform apply
```

Observe that the state file is no longer created on the local machine after the apply (because it is stored remotely)
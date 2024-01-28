# Introduction to Advanced Terraform Expressions

## Learning Goals

- Understand resource dependencies in Terraform
- Explore how to use for_each to create multiple instances of a resource
- Learn how to use the count parameter to create a variable number of resources
- Implement conditions based on variables
- Explore dynamic block usage for flexible resource configurations
  
## Introduction

In this exercise, you will run and observe some more advanced expressions in Terraform configuration files.

## Exercise

### Tasks

**Depends On**

In this exercise, you will:

- Create a virtual network and a virtual machine resource.
- Make the virtual machine depend on the virtual network using the depends_on attribute.

**For Each**

- Define a data structure (map) with different regions and corresponding resource configurations.
- Use for_each to iterate over the map and create instances of a virtual machine resource for each region.

**Count**

- Create a module that defines a load balancer resource.
- Use the count parameter to specify the number of instances of the load balancer.

**Conditional Expressions**

- Define a variable for a storage account type (standard or premium).
- Use a conditional expression to create a storage account with the specified type.

**Dynamic Blocks**

- Create a module that defines a virtual machine resource with dynamic block(s) for specifying additional settings.
- Use the module to create virtual machines with different configurations.


# Exploring Terraform's Numeric Functions

In this challenge you will use Terraform's built-in numeric functions with the random_pet resource from the random provider to get used to functions and their syntax. The provider.tf file has already been configured for you so you can focus on the functions in this exercise.

To begin, copy the below snippet into your main.tf file:

``` bash
# main.tf

locals {
  lowest_number = min(10, 24, 4)
}

resource "random_pet" "server_name" {
  length = local.lowest_number
}

output "random_pet" {
  value = random_pet.server_name.id
}
```

The code above sets a local Terraform variable to the minimum value of the numbers passed to it. This value is then used by the random_pet resource as an input to specify the number of words output as the "name".

The output block lets Terraform know to display the result.

Go ahead and run the terraform command below to initialize your directory.

``` bash
terraform init
```

Now you can can run terraform apply to get the output block to display random_pet.server_name.id which should be four names separated by hyphens.

``` bash
terraform apply
```

Next you will try with a different function called the ceil() function. This function returns the closest whole number that is greater than or equal to the given value. Update main.tf to resemble the below snippet:

``` bash
# main.tf

locals {
  ceil_number = ceil(6.4)
}

resource "random_pet" "server_name" {
  length = local.ceil_number
}

output "random_pet" {
  value = random_pet.server_name.id
}
```

We should now expect our random_pet resource to have a length of 7 words. This is because the ceil() function will 'round up' to the next highest if there is any decimal. Run an apply as shown below to confirm this.

``` bash
terraform apply
```

As expected the random_pet has a length of 7!

Next lets try to the pow() function in place of ceil() to see it in action. Go ahead and modify your main.tf file to look lik the below example. The exact numbers aren't important so feel free to try different numbers in your code to see the result.

``` bash
# main.tf

locals {
  pow_number = pow(2, 4)
}

resource "random_pet" "server_name" {
  length = local.pow_number
}

output "random_pet" {
  value = random_pet.server_name.id
}
```

Run an apply just as before to see the new pet name be generated. Once you are done with that feel free to try some of the other functions to see how they work.

When finished run terraform destroy to clean up for the next challenge.

``` bash
terraform destroy
```

# Exploring Terraform's String Functions
Exploring Terraform's Collection Functions with Azure

In this challenge, you will combine two lists into a map of key-value pairs, allowing users to enter a value such as "dev-server" as a command-line variable and match it to a specific Azure Custom Image on the backend.

After initializing your directory with terraform init, proceed to create the output block within your variables.tf file to display the variable name.

``` bash
# variables.tf

output "image_resource_id" {
  value = var.name
}
```
Create the variable name in variables.tf with a description. This step is optional if you've covered variables already.

``` bash
# variables.tf

variable "name" {
  type        = string
  description = "Internal name of the server"
}
```

Now, run terraform apply. You'll be prompted for the value of name. Enter any name you like, and you should see the output line of image_resource_id = with the value you entered.

Create a map within variables.tf to represent common names for servers and their corresponding Azure Custom Image resource IDs.

``` bash
# variables.tf

variable "map_of_images" {
  type = map
  default = {
    dev-server = "/subscriptions/<subscription_id>/resourceGroups/<resource_group>/providers/Microsoft.Compute/images/dev-server-image"
    prd-server = "/subscriptions/<subscription_id>/resourceGroups/<resource_group>/providers/Microsoft.Compute/images/prd-server-image"
    db-server  = "/subscriptions/<subscription_id>/resourceGroups/<resource_group>/providers/Microsoft.Compute/images/db-server-image"
  }
}
```

Replace <subscription_id> and <resource_group> with your Azure subscription ID and the name of the resource group where your custom images are stored.

Re-open variables.tf and modify the body of the output block:

``` bash
# variables.tf

output "image_resource_id" {
  value = lookup(var.map_of_images, lower(var.name))
}
```

The lookup function takes a map as the first argument (var.map_of_images) and the key to look for as the second argument (var.name). The lower function is used to ensure uniformity in the entered key.

Run terraform apply again. When prompted for the value of name, give one of the keys in map_of_images. For example:

``` bash
terraform apply -var="name=Dev-Server"
```

Now, the function is more error-proof as it includes the lower function to ensure there are no errantly capitalized letters.

# Exploring Terraform's Console

In this challenge you will learn how to invoke the Terraform console to evaluate expressions that use Terraform's built-in functions. In earlier sections you used actual functions in Terraform code. This section is mostly to show you how to try functions out, so have some fun with this challenge and feel free to experiment.

To begin, you will start by running the terraform console command. This will bring up the Terraform console prompt and looks like the below block of code:

``` bash
terraform console
>
```

At this point you have now started the Terraform console and can begin to type out commands for Terraform to run. The console is a standard REPL: Read, Evaluate, Print, Loop.

For your first function try the abs() function out.

``` bash
abs(-100)
```

This function is fairly straightforward, it takes the absolute value of any number passed to it. In this example it returns 100.

Try the following commands out in the console and see what the result is.

``` bash
log(27, 3)
pow(3, 3)
```

A fun trick is combining the log() function with the ceil() function to find the minimum number of binary digits required to represent a given number of distinct values.

For example you could do:

``` bash
ceil(log(15, 2))
```

to find how many digits of a base-2 (or binary) number would be needed to handle 15 different values. For example 0001, 0010, 0100, etc.

Perhaps a more commonly used function to look at would be the min() and max() functions. They will take a series of numbers and return the lowest or the highest number respectively. Go ahead and try the following command out:

``` bash
min(06, 03, 27, 01, 18, -100)
max(06, 03, 27, 01, 18, -100)
```

💡 Note: You may have noticed in the previous example that some of the numbers were front-padded with leading 0's. Terraform will ignore leading zeros in numbers and thus treat 01 and 1 as the same number. You can test this with the following expression in the console: 00001 == 1 The console will return true.

It is fairly common to have a list or set of numbers and you want to get either the minimum or the maximum value from that list. If you try to pass a list to the max() function you will get an error though. Go ahead and try the following command:

``` bash
max([12, 54, 3, 27, 04, 87])
```
Terraform will display the following error:

``` bash
Invalid value for "numbers" parameter: number required.
```

Both min() and max() functions can work with a list or set of numbers, but you need to end the list with ... before the function's closing parenthesis. This lets Terraform know that you want to get a value out of the list. Try running the below command and see what the output is now.

``` bash
max([12, 54, 3, 27, 04, 87]...)
```

You should get a single number back, and no error, this time.

This concludes the intro to Terraform functions. To exit the console you can type

``` bash
exit
```
or press CTRL + D to close the console. Once you have exited the Terraform Console Go ahead and click on "check" to finish this lab.

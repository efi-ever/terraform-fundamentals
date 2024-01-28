# HCL Syntax and Validation

In this lab, you will become familiar with HCL and its syntax. HCL is intended to be pleasant to read and write for humans. When writing Terraform, there is the concept of blocks that represents a container of content. The below snippet is an example of a block that has a type (resource) and two labels (random_string & random).

To make our code easier to understand for others who might want to contribute, we may want to add a comment to explain what the resource is doing. You can add a single-line command to the snippet below with a #. Copy the below snippet into a file called main.tf:

``` bash
# main.tf

# This generates a random string with 16 characters
resource "random_string" "random" {
  length = 16
}
```

Finally, Terraform provides a subcommand validate that can used to quickly verify your code has valid syntax. Before we can run the validate command we will need to run an init first. This is because the random provider needs to be downloaded first so that Terraform knows what arguments are valid for a given resource.

``` bash
terraform init
```

Once the provider has been downloaded and initialized, run the command below to verify your code is valid:

``` bash
terraform validate
```

Try adding another argument to the resource. Under the length argument, in main.tf add hello = "world" and run terraform validate again. What happens? Make sure to remove the hello argument before moving onto the next challenge.

Once you validate your Terraform code, you can proceed with the next challenge.

# Introduction to the Terraform Variables

In this lab, you will build off of the Terraform code you currently have and introduce some variables. Variables serve as parameters for your Terraform code, allowing it to be customized without altering the source code.

To begin, create a new file called variables.tf and copy the code snippet below. This snippet declares a variable of type number that represents the length of string to be provisioned.

``` bash
# variables.tf

variable "string_length" {
  type        = number
  description = "The character length of the string."
}
```

Now, update your main.tf file to leverage your newly created variable as shown below:

``` bash
# main.tf

# This generates a random string
resource "random_string" "random" {
  length = var.string_length
}
```

Since we have only defined the variable, and not given it a default value, when you run an apply, you will be prompted to enter in the desired value. Before we can run an apply the diretory will need to be initialized. First run an init and then try it out by running an apply with any number as shown below:

``` bash
terraform init
terraform apply
```

Great, we can now generate a random string with any length without modifying any code. What if now, you wanted to avoid the prompt, which would become quite cumbersome once we start having multiple variables. There are a couple ways to approach this.

First, you can assign a default value to the variable. To do that, edit your variables.tf file to match the snippet below:

``` bash
# variables.tf

variable "string_length" {
  type        = number
  description = "The character length of the string."
  default     = 10
}
```

Now, if you re-run an apply, you will not be prompted for a value and Terraform will assume you want it to be 10.

Terraform also supports variable definition through methods. The first one is via environment variables. You could specify the value as an environment variable by setting TF_VAR_string_length and re-running an apply.

Try by setting the environment variable as shown below:

``` bash
export TF_VAR_string_length=20
```

Now, Terraform will update the string to have the length specified in the environment variable (20). When using this method Terraform looks for environment variables that begin with TF_VAR_ and then the name of variables within Terraform code.

Terraform also has the concept of dedicated variables files that Terraform will inspect for any variable definitions. Copy the snippet below into the file called terraform.tfvars:

``` bash
# terraform.tfvars

string_length = 5
```

Now, when you run an apply, Terraform will automatically pickup the terraform.tfvars file and read in all of the variables. Run an apply to verify this is the case and the string_length variable is set to 5.

``` bash
terraform apply
```

Finally, provide the string_length value at the command line by running:

``` bash
terraform apply -var="string_length=12"
```

Observe the length of the random string is 12 characters long. Even with multiple values set, Terraform takes our last one due to variable definition precedence. A full list of this precedence can be found here.

# Introduction to the Terraform Output and Interpolation

Terraform provides a special block type called output which can act as return values in Terraform.

Let's assume we want to provide an easy way to read the random string anytime after an apply is run. Add the following snippet to your variables.tf

💡 Note: We can access resources by referencing their type and unique name as shown below.

``` bash
#variables.tf

# This outputs the randomly generated string
output "random" {
  value = random_string.random.result
}
```

With that, run an apply as shown below and accept the new changes:

``` bash
terraform apply
```

You should now see a new snippet that shows you the output from your Terraform code. To access that output at anytime, you can leverage the output subcommand as shown below:

``` bash
terraform output
```

This is convenient way of seeing any necessary outputs from your Terraform code, at anytime!

Adding onto this, assume you want to prepend the generated string in the output with "hashicorp-", this can be done through Terraform's string templating functionality. Terraform uses a ${ ... } sequence as an interpolation which evaluates the expression given and generates a final string.

In your variables.tf file, update your output block to match below:

``` bash
# This outputs the randomly generated string
output "random" {
  value = "hashicorp-${random_string.random.result}"
}
```

Once updated, you can run an apply as shown below to make those changes. This time, in your output, you will see your random string prepended with hashicorp-.

``` bash
terraform apply
```

Success, you have now used Terraform's interpolation feature to prepend a string to your output!

# Introducing Terraform Data Sources

Terraform has the concept of data sources which allows us to fetch information about some entity defined outside of Terraform or by a separate Terraform configuration.

For this lab, you will use the local provider managed by HashiCorp to read a file from the local filesystem.

To get started, create a file called hashicorp.txt and copy the below snippet into it.

``` bash
Terraform is an open-source infrastructure as code software tool
that provides a consistent CLI workflow to manage hundreds
of cloud services.
```

Next, you will use a data block to read that content and then output via Terraform. Create a file called data.tf and copy the below snippet into it:

``` bash
# data.tf

data "local_file" "hashicorp_txt" {
  filename = "hashicorp.txt"
}

output "hashicorp_txt" {
  value = data.local_file.hashicorp_txt.content
}
```

Once saved, ensure you run a terraform init since you are using a new Terraform provider (local). Once you have run an init, you can run an apply to get Terraform to fetch the text and output it as shown below.

💡 Note: Terraform effectively consolidates all files with the .tf extension in that current directory as it performs its actions

``` bash
terraform apply
```

Once you run an apply, you will now see the text in your hashicorp.txt file along with your prepended random value.

As a bonus, lets look into why we used the data source instead of the resource. What will happen?

Update your data.tf to look like the snippet below ( changing "local_file" from data to resource ):

``` bash
# data.tf

resource "local_file" "hashicorp_txt" {
  content  = "harmless change."
  filename = "hashicorp.txt"
}

output "hashicorp_txt" {
 value = local_file.hashicorp_txt.content
}
```

Once updated, run an apply, inspect what Terraform will change, and then accept the change.

``` bash
terraform apply
```

Notice now, the output shows what we defined in Terraform. This is because a resource block in Terraform is designed to write infrastructure while a data block is designed to read it.
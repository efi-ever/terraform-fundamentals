## Introduction to Terraform Providers and Version Requirements

In this challenge, you will learn how to require specific versions of Terraform and other providers to be used. This version requirement provides a way to ensure consistency and compatibility across environments.

You will start by defining your Terraform code to require a minimum version of Terraform is used. For now you will set the value to be greater than or equal to 1.1.0.

To define this copy the below snippet into the provider.tf file:

``` bash
# provider.tf

terraform {
  required_version = ">= 1.1.0"
}
```

This informs Terraform that the executable for Terraform must be at least of version 1.1.0 to run the code. If Terraform is an earlier version it will throw an error.

Go ahead and update the required_version line to "=2.0.0" and run terraform init.

``` bash
terraform init
```

What happened when you changed the version requirement?

💡 Note: Make sure the required version is set back to ">=1.1.0" and you have run terraform init again before proceeding with this lab.

At this point you have now stated that Terraform can only run this code if its own version is 1.1.0 or greater. Terraform and providers can both have their versions set through terraform code. In the next step you will use the HTTP provider, and set the provider version in a way that is very similar to how you did for Terraform.

💡 Note: You can always find the latest version of a provider on its registry page at registry.terraform.io.

The first provider you will be using in this lab is the HTTP provider from HashiCorp. This provider allows for similar functionality to wget or curl commands to get data from a specified http resource.

To begin you need to let Terraform know to use the provider through a required_providers block in the provider.tf file as seen below.

``` bash
#provider.tf


terraform {
  required_version = ">= 1.1.0"

  required_providers {
    http = {
      source = "hashicorp/http"
      version = ">= 2.1.0"
    }
  }
}

provider "http" {}
```

This lets Terraform know that you want to use the http provider from HashiCorp, and that you want to make sure the version is at least 2.1.0.

💡 Note: The last line, while not explicitly required in this version of Terraform, is considered a best practice.

Now that you have told Terraform to use this new provider you will have to run the init command. This will cause Terraform to notice the change and download the correct version if it was not already downloaded.

``` bash
terraform init
```

By default Terraform will always pull the latest provider if no version is set. However setting a version provides a way to ensure your Terraform code remains working in the event a newer version introduces a change that would not work with your existing code.

To have more strict controls over the version you may want to require a specific version ( e.g. required_version = "= 1.1.0" ) or use the ~> operator to only allow the right-most version number to increment.

## Exploring Terraform's Providers

In this challenge you will use the HTTP provider set up in the previous example to issue a GET request and display the HTML response as output.

To do this you need to setup a data resource type and give it a URL to point to. In this example you use the Terraform Documentation website, but you can point it to another valid URL you want.

``` bash
#main.tf

data "http" "example" {
  url = "https://developer.hashicorp.com/terraform/language/providers"
}
```

The above block of code creates a resource that will read data into Terraform. The url parameter within the block is used to specify where to get the information from.

💡 Note: Although https URLs can be used, there is currently no mechanism to authenticate the remote server except for general verification of the server certificate's chain of trust. Data retrieved from servers not under your control should be treated as untrustworthy.

To see the data you will need to add on another section that will output the response body. Append the following block of code to the bottom of your outputs.tf file to see the output when Terraform runs.

``` bash
#outputs.tf

output "http" {
  value = data.http.example.response_body
}
```

The above block tells Terraform to output the data from the HTTP request you set up earlier. Whenever a terraform apply or terraform output is run the output will be displayed in the Terminal window for this lab.

You can now run terraform init to make sure Terraform has pulled the HTTP provider from the Terraform Registry, and then run terraform apply

After a few seconds you will see a section called Outputs: and after it is the raw HTML response a web browser would get if you navigated to https://developer.hashicorp.com/terraform/language/providers.

The HTTP provider can also get JSON responses from remote servers. In the next example you will change the url parameter to point to a different URL and get a JSON-formatted payload instead.

To begin you need to point to a different URL that will reply with JSON, and add an ( optional ) argument of an HTTP header to send in the request. You will use it here to help reinforce the best practice of making your Terraform code more readable and explicit in what it is doing.

💡 Note: The optional header arguments only support two types: text/* and application/json. If the URL will only respond with one of those two types you can leave off this parameter.

``` bash
#main.tf

data "http" "example" {
  url = "https://checkpoint-api.hashicorp.com/v1/check/terraform"

  # Optional request header
  request_headers = {
    Accept = "application/json"
  }
}
```

The above block of code changed the URL argument to point to a new location, and the new request header explicitly states that you will want a JSON response from the server.

Now run terraform apply and see that the output has changed.

If you do not want the quotes ( " " ) around the JSON output you can use the terraform output -json command to get the output in a human-readable JSON format. Go ahead and try that before finishing up this exercise.

## The Random Provider

In the previous challenge you built a data resource that would pull the HTML from a website and display it when the terraform apply command was run. This challenge will expand on the previous example but does not rely on any external sites to get information. Instead you will use the random_pet resource to generate a random 'pet name'.

The first thing you need to do is update your provider.tf file to let Terraform know you want to include this new provider. Within the required_providers block add a new block for random and specify the version to be greater-than-or-equal-to 3.1.0.

``` bash
#provider.tf

required_providers {
  random = {
    source  = "hashicorp/random"
    version = ">= 3.1.0"
  }
  http = {
    source  = "hashicorp/http"
    version = ">= 2.1.0"
  }
}
```

This lets Terraform know that you want to use the new random provider and that you require the version to be 3.1.0 or greater. The http provider section should be unchanged from the previous example.

Now that you have declared the new provider in the provider.tf file we still need to tell Terraform what to do with this new provider. Go ahead and open main.tf then add a new resource called pet_name and then in the outputs.tf file a new output block named random_pet as shown below.

``` bash
#main.tf

resource "random_pet" "server_name" {
  length = 5
}

#outputs.tf

output "random_pet" {
  value = random_pet.server_name.id
}
```

💡 When writing Terraform code it is considered best practice to group similar blocks together. If you were not using separate files for outputs it would be considered best practice to place the output block next to the other output block we created in the previous lab.

To see the provider in action you will need to run terraform init first to get Terraform to take a look at the provider.tf file, see the new provider, and download that provider from the registry. Go ahead and run the below command now.

``` bash
terraform init
```

Once Terraform is done updating the required providers you still need to run apply before you can see the new output block we created display a "pet name" based on the value set for the length argument in main.tf.

``` bash
terraform apply
```

The name generated by Terraform will stay the same until Terraform needs to refresh your infrastructure due to a change in the state file. When a change is detected it will trigger Terraform to refresh the random_pet resource and generate a new pet name.

You do not need to hard-code the value for length in your code. You can use a variable to control how long the "pet_name" is generated on each run. To do this you will need to first update variables.tf to include a variable block that will determine the random_pet name length.

``` bash
# variables.tf

variable "length" {
  type = number
}
```

This is letting Terraform know that you are declaring a variable that will be used elsewhere in the Terraform code. Once declared you will need to update random_pet to use this variable.

Go ahead and update the random_pet resource in the same main.tf file to use the length variable you just defined.

💡 Note: If the lectures haven't covered variables yet, what is happening is we are creating a variable that will be a placeholder for the length argument in the random_pet block. The next section will cover how the value of that variable is set.

``` bash
# main.tf

resource "random_pet" "server_name" {
  length = var.length
}
```

Once this is done go ahead and run terraform apply.

``` bash
terraform apply
```

You will notice that this time Terraform will prompt you for a value for var.length. Go ahead and choose a number other than 5 to see what the output looks like.

💡 Note: There are ways to set a default value that will prevent Terraform from prompting you for a value each time, as well as command-line arguments, and files that will all help you set and control variables. you will go over these other methods in another module.

Each time you run terraform apply you will be prompted for a value. Go ahead and give it a try with some different numbers and then click on "check" once you are done to finish this lab.
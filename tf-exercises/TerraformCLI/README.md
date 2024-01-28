## Learning Goals

This track gets you hands-on with Terraform and its Command Line Interface (CLI). Throughout this challenge, you will learn how to use basic functionally of Terraform, including: initialization, plan, apply, and destroy.

You will also dive into some of the additional subcommands offered while working with state and learn how to easily format your code.

# Run Terraform init

In this challenge, you will initialize your Terraform workspace for the first time.

To begin, copy the code snippet below into the file called main.tf. This snippet leverages the random provider, maintained by HashiCorp, to generate a random string.

# main.tf

``` bash
resource "random_string" "random" {
  length = 16
}
```

Once saved, you can return to your shell and run the init command shown below. This tells Terraform to scan your code and download anything it needs, locally.

    💡 Terraform stores all information in a created directory called .terraform.

``` bash
terraform init
```

Once you have initialized your Terraform workspace, you can proceed with the next challenge where you will plan and apply your Terraform code.

# Terraform plan and apply

In the previous challenge, you created a file called main.tf and initialized your Terraform workspace.

In your terminal, you can run a plan as shown below to see the changes required for Terraform to reach your desired state you defined in your code. This is equivalent to running Terraform in a "dry" mode.


``` bash
terraform plan
```

If you review the output, you will see 1 change will be made which is to generate a single random string.

Terraform also has the concept of planning out changes to a file. This is useful to ensure you only apply what has been planned previously. Try running a plan again but this time passing an -out flag as shown below.

``` bash
terraform plan -out my.plan
```

This will create a plan file that Terraform can use during an apply. Run the command below to build your resource with the plan file.

``` bash
terraform apply my.plan
```

Once completed, you will see Terraform has successfully built your random string resource based on what was in your plan file.

Terraform also supports running an apply without a plan file. To try it out, modify your main.tf file to create a random string with a length of 10 instead of 16 as shown below:

# main.tf

``` bash
resource "random_string" "random" {
  length = 10
}
```

Now, run an apply and notice you will now see a similar output to when you ran a terraform plan but you will now be asked if you would like to proceed with those changes.

   💡 Terraform will only proceed if you enter "yes".

   ``` bash
terraform apply
}
```

Once completed, you will have successfully went through your first plan and apply with Terraform!

    💡 Try running the same apply command. What happens? Why does this happen? Make note if this behaviour as we explore it later with Terraform state.

# Terraform destroy

Now that you have something built with Terraform, let's see how you can destroy it. Terraform has the concept of destroying the resources you built from your Terraform code.

Similar to before, you can use a plan to have terraform speculate what it will destroy. Run the command as shown below to run a planned destroy:

``` bash
terraform plan -destroy
```

You will notice that it will create a plan to destroy the previously created resource. You can combine this command with the -out flag to save a plan that will destroy resources.

``` bash
terraform plan -destroy -out destroy.plan
```

To actually destroy the random string you created, you can run a destroy command as shown below, or you can consume the speculative plan created with the -destroy flag.

    Note: Just as when you ran an apply, you will have to proceed by entering "yes". If you consume a plan file e.g. terraform apply destroy.plan Terraform will not prompt you for confirmation of the destroy as Terraform assumes you have reviewed the plan file.

``` bash
terraform destroy
```

Once completed, you will have successfully gone through your first destroy with Terraform!

# Terraform fmt

In this challenge, you will explore additional subcommands that Terraform offers. The following commands can give additional clarity on what Terraform is managing for yourself and other team members.

💡 The show command can be used to view a saved execution plan. If you do not have a valid plan file please go ahead and create one now with the -out flag:

``` bash
terraform plan -out new.plan
```

Once you have created the plan file you can view it with the show subcommand:

``` bash
terraform show new.plan
```

The show subcommand also allows you to view what objects are currently deployed through Terraform. Since we previously destroyed our resources in the last challenge we will need to recreate them for the command to display anything.

Go ahead and consume the plan that was just created by running:

``` bash
terraform apply new.plan
```

This will recreate the random_string resource so now we can run the show subcommand and get visible output. In your terminal, run the following command:

``` bash
terraform show
```

The output of the show command will display the resources created through Terraform. It will look very similar to the information shown in the plan file.

The next command we want to explore is the fmt subcommand. This subcommand allows you to easily format your Terraform code to a canonical format and style based on a subset of Terraform language style conventions. If you are familiar with Go and its fmt tool, it behaves in a very similar way.

Replace the code in main.tf with the following:

``` bash
# main.tf

resource "random_string"    "random"    {
  length =     16
     special = true
  override_special   =    "/@$"
min_numeric   = 6
      min_special =   2
min_upper   = 3
}
```

Notice that the above code has discrepancies in spacing and unaligned equals signs. Although this code is technically valid, it looks messy.

You can confirm this by running an apply command and Terraform will not issue any warnings about the code formatting.

``` bash
terraform apply
```

The apply should remove the previous random string from state and create a new string with the parameters specified. While Terraform has no issue with the code spacing it is a good idea to clean up your code for other people who will be reviewing it. Instead of manually fixing the code, you can use the fmt subcommand to fix it for you.

Run the fmt subcommand as shown below:

``` bash
terraform fmt
```

Looking at the same main.tf file now, you will see the fmt subcommand aligned the equal signs and trimmed the extra spaces. After running the command you can try a terraform apply again and notice that there is no change.

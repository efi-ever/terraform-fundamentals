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

Terraform also has the concept of planning teout changes to a file. This is useful to ensure you only apply what has been planned previously. Try running a plan again but this time passing an -out flag as shown below.

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

terraform plan -destroy

You will notice that it will create a plan to destroy the previously created resource. You can combine this command with the -out flag to save a plan that will destroy resources.

terraform plan -destroy -out destroy.plan

To actually destroy the random string you created, you can run a destroy command as shown below, or you can consume the speculative plan created with the -destroy flag.

    Note: Just as when you ran an apply, you will have to proceed by entering "yes". If you consume a plan file e.g. terraform apply destroy.plan Terraform will not prompt you for confirmation of the destroy as Terraform assumes you have reviewed the plan file.

terraform destroy

Once completed, you will have successfully gone through your first destroy with Terraform!
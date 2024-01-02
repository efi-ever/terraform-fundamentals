    Create a root module
    Create a unique_id input variable
    Create a local variable
    Create a message output variable
        Use string interpolation to return a string composed of:
            Your local variable
            The var.unique_id class variable
            The current terraform workspace ${terraform.workspace}
    Run terraform apply
    Re-run terraform but pass a different value for unique_id

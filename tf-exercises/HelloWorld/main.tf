# this line declares the use of a null provider - meaning it does not interact with any external service
provider "null" {}

# this line declares a new resource of type null_resource with the name hello_world
resource "null_resource" "hello_world" {
# this line declares a provisioner of type local-exec, executing a command on the machine running Terraform, not on the resource
  provisioner "local-exec" {
    command = "echo '<html><body><h1>Welcome to Terraform Fundamentals!</h1></body></html>' > web/index.html && busybox httpd -p 8000 -h web"
    working_dir = "${path.module}"
  }
# this line declares a dependency on the resource create_directory - meaning that Terraform will make sure that the needed folder is created before the hello_world resource
  depends_on = [null_resource.create_directory]
}

# this line declares a new resource, and then runs the command to be executed to create a directory called web
resource "null_resource" "create_directory" {
  provisioner "local-exec" {
    command = "mkdir -p web"
  }
}

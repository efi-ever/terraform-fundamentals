provider "null" {}

resource "null_resource" "hello_world" {
  provisioner "local-exec" {
    command = "echo '<html><body><h1>Hello, World!</h1></body></html>' > web/index.html && busybox httpd -p 8000 -h web"
    working_dir = "${path.module}"
  }

  depends_on = [null_resource.create_directory]
}

resource "null_resource" "create_directory" {
  provisioner "local-exec" {
    command = "mkdir -p web"
  }
}

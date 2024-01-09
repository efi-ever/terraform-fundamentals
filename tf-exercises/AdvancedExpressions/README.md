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

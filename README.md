## How to use terraform-ex1

This example generates a VPC with one private and one public subnet.

### Files

The following files are included in this example:

- `main.tf`: contains the main configuration for the resources to be created
- `vpc.tf`: contains the VPC configuration

### Instructions

To use this example, follow these steps:

1. Clone this repository to your local machine.
2. Initialize the Terraform environment by running `terraform init`.
3. Apply the configuration by running `terraform apply` or `terraform apply -auto-approve` if you trust the configuration.
4. After the resources are created, copy the "public ip" from the terminal.
5. Open the `creds/ec2-ip.txt` file and paste the copied IP address.
6. Move the Private Key PEM file to the `creds` folder and rename it to `vockey.pem`.
7. In the root folder, run the `ec2-connect.sh` script to connect to the EC2 instance.

That's it! By following these steps, you should be able to create a VPC with one private and one public subnet using Terraform.
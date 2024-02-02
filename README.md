Lab 1
Using variables:
- Create VPC with CIDR 10.0.0.0/16
- Create 2 Public Subnets /24 dynamically based on the CIDR value of the VPC.
- Create 2 Private Subnets with Nat Gateway /24 dynamically based on the VPC CIDR value.


- Using count, create an Ubuntu-type EC2 in each private subnet with Nat Gateway, install Nginx and create index.html that shows the following information:
   "Hello. I'm the server <instance id> and I'm in AZ <az id>."
   The value of <instance id> must be fetched through meta-data while AZ, through the template_file in Terraform. 
- Create App Load Balancer on the public subnet and attach the two servers to it.
- EC2 must allow HTTP traffic only from LB. LB must receive HTTP traffic from any source.
- Push to GitHub in a directory called Lab1. tfstate files should not be sent (add to .gitignore)

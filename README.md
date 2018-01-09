# AWS AMIs Terraform module

Terraform module which helps programmatically to find up to date image of particular OS and release.

AMIs available:

 - Debian: stretch
 - Ubuntu: xenial

# Usage

```hcl
module "amis" {
  source = "tegithub.com/stackfeed/terraform-aws-ami"

  platform = "debian"
  release  = "stretch"
}

/* Example of passing calculated ami_id and admin_user to ec2-instance module */
module "ec2_cluster" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name  = "my-cluster"
  count = 5

  ami                    = "${module.amis.ami_id}"
  instance_type          = "t2.micro"
  key_name               = "${module.amis.admin_user}"
  monitoring             = true
  vpc_security_group_ids = ["sg-12345678"]

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
```

# Authors

* Denis Baryshev (<dennybaa@gmail.com>)

# License

Apache 2. See [LICENSE](LICENSE) file for details.

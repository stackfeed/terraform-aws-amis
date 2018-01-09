
variable "platform" {
  description = "OS platform"
}

variable "release" {
  description = "OS release"
}

variable "map_platform_admin" {
  description = "Maps platform"

  default = {
    debian  = "admin"
    ubuntu  = "ubuntu"
  }
}

locals {
  release_date = {
    stretch = "2018-01-06-16218"
    xenial  = "20171208"
  }

  filter_owners = {
    debian = ["379101102735"]
    ubuntu = ["099720109477"] 
  }
}

locals {
  filter_name = {
    ## https://wiki.debian.org/Cloud/AmazonEC2Image/Stretch
    #  stretch 2018-01-06 release
    debian = ["debian-${var.release}-hvm-x86_64-gp2-${local.release_date[var.release]}"]

    ## https://cloud-images.ubuntu.com/locator/ec2/
    #  xenial 2017-12-08 release
    ubuntu = ["ubuntu/images/hvm-ssd/ubuntu-${var.release}-16.04-amd64-server-${local.release_date[var.release]}"]
  }

}

data "aws_ami_ids" "this" {
  owners = "${local.filter_owners[var.platform]}"

  filter {
    name   = "name"
    values = "${local.filter_name[var.platform]}"
  }
}

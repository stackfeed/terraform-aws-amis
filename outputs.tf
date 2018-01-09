output "ami_id" {
  value = "${element(data.aws_ami_ids.this.ids, 0)}"
}

output "admin_user" {
    value = "${map_platform_admin[var.platform]}"
}

# vscode-modelines
# vim: set ft=terraform:

data "aws_ami" "ami" {
  most_recent = true
  owners      = [var.ami_owners]

  filter {
    name   = "name"
    values = ["${var.ami_name}*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

#utput "data_ami" { value = data.aws_ami.ami }

output "data_ami" {
  value = {
    tomap = {
      "id"            = data.aws_ami.ami.id
      "name"          = data.aws_ami.ami.name
      "region"        = data.aws_ami.ami.region
      "owner_id"      = data.aws_ami.ami.owner_id
      "creation_date" = data.aws_ami.ami.creation_date
    }
  }
}


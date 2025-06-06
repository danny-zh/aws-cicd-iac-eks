

resource "aws_instance" "app" {
    
  count = var.instance_count

  ami = var.instance_ami
  instance_type = var.instance_type

  subnet_id              = var.subnet_ids[count.index % length(var.subnet_ids)]
  vpc_security_group_ids = var.security_group_ids


  metadata_options {
    http_tokens = "optional"       # This allows both IMDSv1 and IMDSv2
    http_endpoint = "enabled"      # Enable the instance metadata service
  }

  user_data = file(var.user_data)

  tags = merge(
    {
      Name = "Server-${count.index}"
    },
    var.tags
  )
}

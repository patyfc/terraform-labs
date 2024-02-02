#EC2 nginx
resource "aws_instance" "nginx-server" {
  count         = 2
  instance_type = "t3.micro"
  ami           = data.aws_ami.server_ami.id

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "server-${count.index + 1}"
  }


  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  key_name          = aws_key_pair.auth.id
  vpc_security_group_ids = [aws_security_group.default_rules.id,
    aws_security_group.sg_webserver.id]
  subnet_id = aws_subnet.private[count.index].id
  user_data = templatefile("userdata.tpl",
    {
      AZ         = element(data.aws_availability_zones.available.names[*], count.index)
  })
}
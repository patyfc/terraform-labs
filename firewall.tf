#Security groups
resource "aws_security_group" "default_rules" {
  name        = "allow_outbound_traffic_to_any"
  description = "allow outbound traffic to any"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "sg_alb" {
  name        = "allow_inbound_traffic_from_any"
  description = "allow inbound web traffic from any"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "sg_webserver" {
  name        = "ingress_in_nginx"
  description = "allow http from alb"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_alb.id]
  }

}


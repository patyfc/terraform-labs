#key pair
resource "aws_key_pair" "auth" {
  key_name   = "paty"
  public_key = file("~/.ssh/paty.pub")
}
resource "aws_instance" "first_terraform" {
  ami           = "ami-0f3caa1cf4417e51b"
  instance_type = "t3.micro"
}
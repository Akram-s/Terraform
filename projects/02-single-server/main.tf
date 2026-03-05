resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Allow HTTP and SSH traffic"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }



  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami           = "ami-0f3caa1cf4417e51b"
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = "my-terraform"
  user_data              = <<-EOF
                #!/bin/bash
                sudo dnf update -y
                sudo dnf install nginx -y
                sudo systemctl start nginx
                sudo systemctl enable nginx
                EOF
  tags = {
    Name = "web-server"
  }

}
output "public_ip" {
  value = aws_instance.web_server.public_ip
}

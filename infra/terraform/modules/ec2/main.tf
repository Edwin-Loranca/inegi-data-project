resource "aws_key_pair" "ec2_server_key" {
    key_name   = "ec2-server-key"
    public_key = var.public_key
}

resource "aws_security_group" "ec2_sg" {

  ingress {

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {

    from_port   = 3000
    to_port     = 3000
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

resource "aws_instance" "ec2_server" {
    ami           = "ami-0a59ec92177ec3fad"
    instance_type = var.instance_size
    key_name = aws_key_pair.ec2_server_key.key_name
    
    user_data = <<-EOF
                #!/bin/bash
                # actualizar sistema
                yum update -y
                # instalar docker
                amazon-linux-extras install docker -y
                service docker start
                usermod -a -G docker ec2-user
                # instalar docker compose
                curl -SL https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
                chmod +x /usr/local/bin/docker-compose
                # ir al home del usuario
                cd /home/ec2-user
                # clonar tu repo
                git clone https://github.com/Edwin-Loranca/inegi-data-project.git
                cd dagster-project
                # levantar todo el sistema
                docker-compose up -d --build
                EOF
    
    tags = {
        Name = "${var.tag_prefix}-server"
        }
}
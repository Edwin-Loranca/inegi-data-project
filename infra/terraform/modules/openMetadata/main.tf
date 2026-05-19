resource "aws_security_group" "openmetadata_sg" {

  name = "openmetadata-sg"

  ingress {

    from_port   = 8585
    to_port     = 8585
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {

    from_port       = 8585
    to_port         = 8585
    protocol        = "tcp"
    security_groups = [var.dagster_security_group_id]

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

resource "aws_instance" "ec2_server" {
    ami           = "ami-0a59ec92177ec3fad"
    instance_type = var.instance_size
    key_name = var.ec2_key_name
    vpc_security_group_ids = [aws_security_group.openmetadata_sg.id]
    associate_public_ip_address = true
    root_block_device {
      volume_size = 30
      volume_type = "gp3"
      }
    
    user_data = <<-EOF
                #!/bin/bash
                # actualizar sistema
                dnf update -y
                # instalar docker
                dnf install docker -y
                # iniciar docker
                systemctl start docker
                # habilitar docker al reiniciar
                systemctl enable docker
                # permisos docker
                usermod -aG docker ec2-user
                # instalar docker compose
                curl -SL https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
                chmod +x /usr/local/bin/docker-compose
                # ir al home del usuario
                cd /home/ec2-user
                # crear directorio para open metadata y descargar el docker-compose.yml
                mkdir openmetadata-docker && cd openmetadata-docker
                curl -sL -o docker-compose-postgres.yml https://github.com/open-metadata/OpenMetadata/releases/download/1.12.6-release/docker-compose-postgres.yml
                # levantar el servicio
                docker-compose -f docker-compose-postgres.yml up --detach
                EOF
    
    tags = {
        Name = "${var.tag_prefix}-server"
        }
}
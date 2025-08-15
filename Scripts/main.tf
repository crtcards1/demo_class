
provider "aws" {
  region = "us-east-2" 
}

resource "aws_instance" "defense_vm" {
  ami           = "ami-0d1b5a8c13042c939" # Amazon Machine Image, pulling Ubuntu Server 24.04 LTS (HVM), SSD Volume Type
  instance_type = "t3.micro"              # Free tier eligible
  key_name      = "ubuntu"     # My key pair, make sure it matches the .pem file 
  vpc_security_group_ids = [aws_security_group.ssh_access.id] # Attach the security group to allow SSH access

  tags = {
    Name = "Demo-Class"
  }
  user_data_replace_on_change = true   # Add this line to force recreation when user_data changes

  user_data = base64encode(file("setup.sh")) # This script will run on instance creation
  
}

resource "aws_security_group" "ssh_access" {
  name        = "ssh-rdp- access"
  description = "Allow SSH/RDP access to the instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
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

output "instance_ip" {
  value = aws_instance.defense_vm.public_ip
  description = "Public IP of the EC2 instance"
}

output "ssh_command" {
  value = "ssh -i ubuntu.pem ubuntu@${aws_instance.defense_vm.public_ip}"
  description = "Ready-to-use SSH command"
}

#terraform init
#terraform apply -auto-approve


#Delete the instance
#terraform taint aws_instance.defense_vm 
#terraform apply -auto-approve # Autoapproves
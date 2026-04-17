##Instance (EC2)
resource "aws_instance" "website-server" {
  ami = "ami-0a1b6a02658659c2a"

  instance_type = "t3.micro"

  key_name               = aws_key_pair.site-prod.key_name
  vpc_security_group_ids = [aws_security_group.website_sg.id]
  iam_instance_profile   = "ECR-EC2-Role" ## Nome da role vem da sua preferencia
  tags = {
    Name        = "website-server"
    provisioned = "Terraform"
  }
}

## Key pair
resource "aws_key_pair" "site-prod" {
  key_name   = "site-prod-key"
  public_key = file("/home/edu/chaves/site-prod-key.pub")
}


## Security Group
resource "aws_security_group" "website_sg" {
  name   = "website-sg"
  vpc_id = "vpc-0411a0da9f1f93943"


  tags = {
    Name        = "website-sg"
    provisioned = "Terraform"
  }
}

## Security Group ingress (entrada)
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.website_sg.id

  cidr_ipv4   = "Seu_IP" ## é o seu IP de entrada SSH
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.website_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.website_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

## Security Group egress (Saida)
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.website_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}

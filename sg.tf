resource "aws_security_group" "allow_ssh_http" {
  name        = "allow-ssh-http-ansible"
  description = "Allow SSH(22) and HTTP(8080)"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "allow_ssh_http"
  }
}

 resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
   security_group_id = aws_security_group.allow_ssh_http.id
   from_port         = 8080
   cidr_ipv4         = "0.0.0.0/0"
   ip_protocol       = "tcp"
   to_port           = 8080
 }

 resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv6" {
   security_group_id = aws_security_group.allow_ssh_http.id
   from_port         = 8080
   cidr_ipv6         = "::/0"
   ip_protocol       = "tcp"
  to_port           = 8080
}

# hmm, comment troll claims this piece of code.

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_ssh_http.id
  from_port         = 22
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv6" {
  security_group_id = aws_security_group.allow_ssh_http.id
  from_port         = 22
  cidr_ipv6         = "::/0"
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_ssh_http.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_ssh_http.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
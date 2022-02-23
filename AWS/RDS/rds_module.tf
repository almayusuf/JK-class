# Collect Information 

data "aws_subnet" "us-east-1a" {
  availability_zone = "us-east-1a"
  filter {
    name   = "tag:Name"
    values = ["DEV_Project"]
  }
}
data "aws_subnet" "us-east-1b" {
  availability_zone = "us-east-1b"
  filter {
    name   = "tag:Name"
    values = ["DEV_Project"]
  }
}
data "aws_subnet" "us-east-1c" {
  availability_zone = "us-east-1c"
  filter {
    name   = "tag:Name"
    values = ["DEV_Project"]
  }
}

data "aws_vpc" "foo" {
  tags = {
    Name = "DEV_Project"
  }
}

output "foo" {
  value = data.aws_vpc.foo.id
}

resource "aws_security_group" "db" {
  name        = "db"
  description = "Allow Mysql traffic"
  vpc_id      = data.aws_vpc.foo.id
  ingress {
    description = "Allow mysql"
    from_port   = 3306
    to_port     = 3306
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




resource "aws_db_subnet_group" "db" {
  name = "db"
  subnet_ids = [
    data.aws_subnet.us-east-1a.id,
    data.aws_subnet.us-east-1b.id,
    data.aws_subnet.us-east-1c.id,

  ]
}
resource "random_password" "password" {
  length           = 30
  special          = false
  override_special = "_%@"
}


resource "aws_ssm_parameter" "foo" {
  name  = "foo"
  type  = "SecureString"
  value = random_password.password.result
}



resource "aws_db_instance" "default" {
  identifier             = "dbname"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "mydb"
  username               = "foo"
  password               = random_password.password.result
  publicly_accessible    = true
  db_subnet_group_name   = aws_db_subnet_group.db.name
  skip_final_snapshot    = true #used to delete the repo in the future without this you cant delete. There are bugs reported 
  vpc_security_group_ids = [aws_security_group.db.id]
}

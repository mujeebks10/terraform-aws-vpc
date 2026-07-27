# Web Tier Security Group
resource "aws_security_group" "web" {
  name        = "${var.environment}-web-sg"
  description = "Security group for web tier"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from allowed CIDRs"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${var.environment}-web-sg"
  })
}

# App Tier Security Group
resource "aws_security_group" "app" {
  name        = "${var.environment}-app-sg"
  description = "Security group for app tier"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "App port from web tier"
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  ingress {
    description     = "SSH from web tier"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  ingress {
    description = "App metrics port"
    from_port   = var.metrics_port
    to_port     = var.metrics_port
    protocol    = "tcp"
    cidr_blocks = var.monitoring_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${var.environment}-app-sg"
  })
}

# # DB Tier Security Group
# resource "aws_security_group" "db" {
#   name        = "${var.environment}-db-sg"
#   description = "Security group for database tier"
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     description     = "Database port from app tier"
#     from_port       = var.db_port
#     to_port         = var.db_port
#     protocol        = "tcp"
#     security_groups = [aws_security_group.app.id]
#   }

#   ingress {
#     description     = "Database replication port"
#     from_port       = var.db_replication_port
#     to_port         = var.db_replication_port
#     protocol        = "tcp"
#     security_groups = [aws_security_group.db.id]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = merge(local.common_tags, {
#     Name = "${var.environment}-db-sg"
#   })
# }

resource "aws_security_group" "db" {
  name        = "${var.environment}-db-sg"
  description = "Security group for database tier"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Database port from app tier"
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${var.environment}-db-sg"
  })
}

# Bastion Host Security Group (Optional)
resource "aws_security_group" "bastion" {
  count = var.enable_bastion ? 1 : 0

  name        = "${var.environment}-bastion-sg"
  description = "Security group for bastion host"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from allowed CIDRs"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidrs
  }

  ingress {
    description     = "SSH to app tier"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  ingress {
    description     = "SSH to db tier"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.db.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${var.environment}-bastion-sg"
  })
}

# Additional rule for DB admin access from bastion
resource "aws_security_group_rule" "db_admin_from_bastion" {
  count = var.enable_bastion ? 1 : 0

  type                     = "ingress"
  from_port                = var.db_admin_port
  to_port                  = var.db_admin_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.db.id
  source_security_group_id = aws_security_group.bastion[0].id
  description              = "DB admin from bastion"
}


resource "aws_security_group_rule" "db_replication" {
  type                     = "ingress"
  from_port                = var.db_replication_port
  to_port                  = var.db_replication_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.db.id
  source_security_group_id = aws_security_group.db.id
  description              = "Database replication port"
}

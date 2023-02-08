resource "random_password" "master_password" {
  length           = 16
  min_lower        = 1
  min_upper        = 1
  min_special      = 1
  override_special = "!#$%&?"
}

resource "aws_rds_cluster" "cluster" {
  cluster_identifier      = var.cluster_identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  availability_zones      = var.availability_zones
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = "${random_password.master_password.result}"
  db_subnet_group_name    = var.db_subnet_group_name
  vpc_security_group_ids  = var.vpc_security_group_ids
  skip_final_snapshot     = var.skip_final_snapshot
  backup_retention_period = var.backup_retention_period
  copy_tags_to_snapshot   = var.copy_tags_to_snapshot
  lifecycle {
    ignore_changes = [
      availability_zones
    ]
  }
  tags = {
    "Name"                = var.cluster_identifier
    "Service Role"        = "RDS DB Cluster"
  }
}

resource "aws_rds_cluster_instance" "instance" {
  count                   = var.instance_count
  identifier              = "${var.cluster_identifier}-instance-${format("%02d", count.index + 1)}"
  cluster_identifier      = aws_rds_cluster.cluster.id
  instance_class          = var.instance_class
  engine                  = aws_rds_cluster.cluster.engine
  engine_version          = aws_rds_cluster.cluster.engine_version
  db_subnet_group_name    = aws_rds_cluster.cluster.db_subnet_group_name
  tags = {
    "Name"                = "${var.cluster_identifier}-instance-${format("%02d", count.index + 1)}"
    "Service Role"        = "RDS DB Instance"
  }
}

resource "aws_rds_cluster" "app1-rds-cluster" {
  cluster_identifier        = "app1-rds-cluster"
  backup_retention_period   = 1
  master_username           = var.db_username
  master_password           = var.password
}

resource "aws_rds_cluster" "app2-rds-cluster" {
  cluster_identifier      = "app2-rds-cluster"
  backup_retention_period = 1
  master_username         = var.db_username
  master_password         = var.password
}

resource "aws_rds_cluster" "app3-rds-cluster" {
  cluster_identifier      = "app3-rds-cluster"
  backup_retention_period = 15
  master_username         = var.db_username
  master_password         = var.password
}

resource "aws_rds_cluster" "app4-rds-cluster" {
  cluster_identifier      = "app4-rds-cluster"
  backup_retention_period = 15
  master_username         = var.db_username
  master_password         = var.password
}

resource "aws_rds_cluster" "app5-rds-cluster" {
  cluster_identifier      = "app5-rds-cluster"
  backup_retention_period = 15
  master_username         = var.db_username
  master_password         = var.password
}

resource "aws_rds_cluster" "app6-rds-cluster" {
  cluster_identifier      = "app6-rds-cluster"
  backup_retention_period = 15
  master_username         = var.db_username
  master_password         = var.password
}

resource "aws_rds_cluster" "app7-rds-cluster" {
  cluster_identifier      = "app7-rds-cluster"
  backup_retention_period = 25
  master_username         = var.db_username
  master_password         = var.password
}

resource "aws_db_instance" "mysql-instance"  {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  storage_encrypted    = var.environment == "dev" ? true : false
}

resource "aws_db_instance" "mariadb_svc" {
  allocated_storage    = 10
  engine               = "mariadb"
  instance_class       = "db.t2.micro"
  username             = "mariadbadmin"
  password             = "kX95#VCRdlDg"
  publicly_accessible  = true
}

resource "aws_db_instance" "reports_summary" {
  allocated_storage    = 10
  name                 = "reports_aggregation"
  engine               = "postgres"
  engine_version       = "12.11"
  instance_class       = "db.t2.micro"
  username             = "postgresqladmin"
  password             = "3CSArXCzdJ6g"
  publicly_accessible  = true
}

resource "aws_db_instance" "aggregated_data" {
  allocated_storage    = 10
  name                 = "aggregated_data"
  engine               = "postgres"
  engine_version       = "12.11"
  instance_class       = "db.t2.small"
  username             = "postgresqladmin"
  password             = "3Q64SUDrpv"
  kms_key_id           = aws_kms_key.db_key.arn
  storage_encrypted    = true
  publicly_accessible  = true
}

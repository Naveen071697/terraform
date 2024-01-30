
# RDS
resource "aws_db_instance" "main_db" {
  identifier                   = "listing-db-${var.stage_name}"
  allocated_storage            = 100
  max_allocated_storage        = 1000
  engine                       = var.rds_engine
  engine_version               = var.rds_engine_version
  instance_class               = var.db_instance_size
  db_name                      = var.db_name
  username                     = var.db_username
  password                     = var.db_password
  port                         = var.db_port
  skip_final_snapshot          = true
  db_subnet_group_name         = aws_db_subnet_group.main_subnet_private_group.name
  vpc_security_group_ids       = [aws_security_group.main_sg_db_private.id]
  performance_insights_enabled = true
  deletion_protection          = true
  delete_automated_backups     = true
  publicly_accessible          = false
  multi_az                     = false
  backup_retention_period      = 7
  copy_tags_to_snapshot        = true
  apply_immediately            = true
  monitoring_role_arn          = "arn:aws:iam::${var.aws_acc_no}:role/listing-rds-monitoring-role-${var.stage_name}"
  monitoring_interval          = 60
  depends_on                   = [aws_vpc.main_vpc, aws_db_subnet_group.main_subnet_private_group, aws_security_group.main_sg_private]
}

variable "aws_acc_no" {
  type    = string
  default = ""
}

variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "aws_access_key" {
  type    = string
  default = ""
}

variable "aws_secret_key" {
  type    = string
  default = ""
}

variable "product_name" {
  type    = string
  default = ""
}

variable "stage_name" {
  type    = string
  default = "int"
}

variable "common_branch_name" {
  type    = string
  default = "int_v2"
}

variable "ACM_CERT_ARN" {
  type    = string
  default = "arn:aws:acm:us-east-1:<acc_no>:certificate/49213905-28c2-496d-95ca-fdf8242a2ec0"
}

variable "ACM_CERT_ARN_REGIONAL" {
  type    = string
  default = "arn:aws:acm:ap-south-1:<acc-no>:certificate/e433694a-a7ce-4dfd-862f-10f2ddc10594"
}

variable "LISTING_URL" {
  type    = string
  default = ""
}

variable "api_url" {
  type    = string
  default = ""
}

variable "backend_docker_emi" {
  type    = string
  default = "64bit Amazon Linux 2 v3.5.8 running Docker"
}

# Database
variable "rds_engine" {
  type    = string
  default = "postgres"
}

variable "rds_engine_version" {
  type    = string
  default = "14.4"
}

variable "db_username" {
  type    = string
  default = "postgres"
}

variable "db_password" {
  type    = string
  default = ""
}

variable "db_port" {
  type    = string
  default = "7878"
}

variable "db_name" {
  type    = string
  default = "public_listing"
}

variable "key_pair_name" {
  type    = string
  default = "key_pair-listing-test"
}

variable "ebs_listing_backend_instance_size" {
  type    = string
  default = "t2.micro"
}

variable "cognito_domain" {
  type    = string
  default = "pa-listing-int"
}

variable "db_instance_size" {
  type    = string
  default = "db.t3.small"
}


variable "cluster_identifier" {
  type        = string
  description = " Cluster Identifier"
}

variable "engine" {
  type        = string
  description = "RDS Database Engine"
}

variable "engine_version" {
  type        = string
  description = "RDS Database Engine Version"
  default     = ""
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability Zones"
}

variable "database_name" {
  type        = string
  description = "Database Name"
}

variable "master_username" {
  type        = string
  description = "Database Master Username"
  default     = "root"
}

variable "db_subnet_group_name" {
  type        = string
  description = "Database Subnet Group Name"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "The list of security group ids used by the instance"
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Skip Final Snapshot"
  default     = false
}

variable "backup_retention_period" {
  type        = number
  description = "Backup Retention Period"
  default     = 7
}

variable "copy_tags_to_snapshot" {
  type        = bool
  description = "Copy Tags to Snapshot"
  default     = true
}

variable "instance_count" {
  type        = string
  description = "RDS Cluster Instance Count"
}

variable "instance_class" {
  type        = string
  description = "EC2 Instance Class"
}

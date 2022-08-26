variable "aws_region" {
	default = "ap-south-1"
}

variable "aws_access_key" {
default = ""
}
variable "aws_secret_key" {
default = ""
}

variable "rest_api_name" {
	default = "showdata-api"
}

variable "rest_api_path_part" {
  default = "shows"
}

variable "component_prefix" {
  default = "eticket"
}

variable "component_name" {
  default = "showdata"
}

# store the zip file here
variable "bucket_name" {
	default = "showdata-files"
}

variable "archive_file_type" {
  default = "zip"
}

variable "s3_key" {
  default     = "lambda/showdata.zip"
  description = "Store zip file in this bucket path"
}

variable "lambda_handler" {
  default = "lambda_handler"
}

variable "lambda_runtime" {
  default = "python3.9"
}

variable "lambda_timeout" {
  default = "10"
}

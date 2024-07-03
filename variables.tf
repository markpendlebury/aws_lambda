variable "service_name" {
  type        = string
  description = "The name of the service, used in things such as the name of the lambda function"
}

variable "timeout" {
  type        = number
  description = "The timeout for the lambda function"
  default     = 10
}

variable "memory_size" {
  type        = number
  description = "The memory size for the lambda function"
  default     = 128
}

variable "package_type" {
  type        = string
  description = "The package type for the lambda function, one of Image or Zip"
  default     = "Zip"
}

variable "s3_bucket" {
  type        = string
  description = "The S3 bucket for the lambda function"
  default     = null
}

variable "s3_key" {
  type        = string
  description = "The S3 key for the lambda function"
  default     = null
}

variable "filename" {
  type        = string
  description = "The filename for the lambda function"
  default     = null

}

variable "lambda_handler" {
  type        = string
  description = "The handler for the lambda function"
  default     = null
}

variable "runtime" {
  type        = string
  description = "The runtime for the lambda function"
  default     = "python3.8"

}

variable "environment" {
  type        = map(string)
  description = "The environment variables for the lambda function"
  default     = {}
}


variable "cloudwatch_log_retention" {
  type        = number
  description = "The number of days to retain logs in CloudWatch"
  default     = 30

}

variable "enable_scheduled_event" {
  type        = bool
  description = "Whether to enable a scheduled event to trigger the lambda function"
  default     = false
}

variable "schedule" {
  type        = string
  description = "The schedule expression for the scheduled event"
  default     = "rate(1 hour)"
}

variable "source_code_hash" {
  type        = string
  description = "The hash of the source code for the lambda function"
  default     = null

}

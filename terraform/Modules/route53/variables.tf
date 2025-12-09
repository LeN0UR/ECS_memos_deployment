variable "domain_name" {
  description = "The root domain name (e.g. nordemo.com)"
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name of the ALB to point the domain at"
  type        = string
}

variable "alb_zone_id" {
  description = "Hosted zone ID of the ALB (for alias records)"
  type        = string
}

variable "create_www_record" {
  description = "Whether to create a www.<domain> record aliasing to the ALB"
  type        = bool
  default     = true
}

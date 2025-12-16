output "zone_id" {
  description = "Route 53 hosted zone ID"
  value       = data.aws_route53_zone.this.zone_id
}

output "root_record_fqdn" {
  description = "FQDN of the root A record"
  value       = aws_route53_record.root_a.fqdn
}

output "www_record_fqdn" {
  description = "FQDN of the www A record (if created)"
  value       = var.create_www_record ? aws_route53_record.www_a[0].fqdn : null
}

output "app_url" {
  description = "Public URL of the application"
  value       = "https://www.${var.domain_name}"
}

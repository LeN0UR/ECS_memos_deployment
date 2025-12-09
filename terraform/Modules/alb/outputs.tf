output "alb_name" {
  description = "Name of the ALB"
  value       = aws_lb.memos_alb.name
}

output "aws_lb_target_group_name" {
  description = "Name of the ALB target group"
  value       = aws_lb_target_group.memos_tg.name
}

output "load_balancer_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.memos_alb.arn
}

output "target_group_arn" {
  description = "ARN of the ALB target group"
  value       = aws_lb_target_group.memos_tg.arn
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.memos_alb.dns_name
}

output "alb_zone_id" {
  description = "Hosted zone ID of the ALB (for Route 53 alias)"
  value       = aws_lb.memos_alb.zone_id
}

output "https_listener_arn" {
  description = "ARN of the HTTPS listener"
  value       = aws_lb_listener.https.arn
}

output "http_redirect_listener_arn" {
  description = "ARN of the HTTP → HTTPS redirect listener"
  value       = aws_lb_listener.redirect_http.arn
}




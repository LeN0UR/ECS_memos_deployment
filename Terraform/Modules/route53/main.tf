# Look up existing public hosted zone

data "aws_route53_zone" "this" {
  name         = var.domain_name
  private_zone = false
}

# root A record (nourdemo.com)

resource "aws_route53_record" "root_a" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

# www A record (www.nourdemo.com)

resource "aws_route53_record" "www_a" {
  count = var.create_www_record ? 1 : 0

  zone_id = data.aws_route53_zone.this.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

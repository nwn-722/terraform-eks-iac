
resource "aws_route53_zone" "registered_domain" {
  name = "nemozon.com"
  tags = var.local-tags
}


variable "name" {
    type = string
}
variable "domain_name" {
    type = string
}
variable "subject_alternative_names" {
    type = list(string)
    default = null
}
variable "route53_zone_id" {
    type = string
}
variable "local-tags" {
  type = map(string)
}
   
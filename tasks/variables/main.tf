variable subnet_details {
  type = list(
    object({
      cidr             = string
      subnet_name      = string
      route_table_name = string
    })
  )
  default = [
    {
      cidr             = "10.0.1.0/24"
      subnet_name      = "eu-west-1a"
      route_table_name = "route1"
    },
    {
      cidr             = "10.0.2.0/24"
      subnet_name      = "eu-east-1a"
      route_table_name = "route2"
    },
  ]
}

locals {
  route_tables_all = distinct([for s in var.subnet_details : s.route_table_name])
}

output all_route_tables {
  value = local.route_tables_all
}

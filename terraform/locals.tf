# Controls input values which are not exposed through module

locals {
  traffic_port = 8080
  https_port   = 443
  any_port     = 0
  any_protocol = -1
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]

}

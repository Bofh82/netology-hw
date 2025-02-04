
resource "yandex_lb_target_group" "group1" {
  name = "group1"
  target {
    subnet_id = yandex_vpc_subnet.subnet1.id
    address = yandex_compute_instance.vm[0].network_interface.0.ip_address
  }  

  target {
    subnet_id = yandex_vpc_subnet.subnet1.id
    address = yandex_compute_instance.vm[1].network_interface.0.ip_address
  }  
}

resource "yandex_lb_network_load_balancer" "balancer1" {
    name = "balancer1"
    deletion_protection = "false"
    listener {
      name = "my-lb1"
      port = 80
      external_address_spec {
        ip_version = "ipv4"
      }
    }
    attached_target_group {
      target_group_id = yandex_lb_target_group.group1.id
      healthcheck {
        name = "http"
        http_options {
          port = 80
          path = "/"
        }
      }
    }
}

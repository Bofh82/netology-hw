
# #считываем данные об образе ОС
data "yandex_compute_image" "ubuntu_2204_lts" {
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "vm" {
  count = var.cluster
  name        = "vm${count.index}" 
  hostname    = "vm${count.index}"
  platform_id = "standard-v1"
  zone        = "ru-central1-a" #зона ВМ должна совпадать с зоной subnet!!!

  resources {
    cores         = var.resources.cores
    memory        = var.resources.memory
    core_fraction = var.resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yml")
    serial-port-enable = 1
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet1.id #зона ВМ должна совпадать с зоной subnet!!!
    nat                = true
  }
}

resource "local_file" "inventory" {
  content  = <<-EOF
  [webservers]
  ${yandex_compute_instance.vm[0].network_interface.0.nat_ip_address}
  ${yandex_compute_instance.vm[1].network_interface.0.nat_ip_address}
  EOF
  filename = "./hosts.ini"
}
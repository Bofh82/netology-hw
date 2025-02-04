
variable "cloud_id" {
  type    = string
  default = "b1gd6desdu3mbt7gavsj"
}

variable "folder_id" {
  type    = string
  default = "b1g53g7fu8i25j6196gn"
}

variable "cluster" {
  type = number
  default = 2
}

variable "resources" {
  type = map(number)
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }
}
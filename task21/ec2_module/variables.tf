variable "ami" {
  type = string
}

variable "isPublic" {
  type = bool
}

variable "subnet_id" {
    type = string
}

variable "key_pair" {
  type = string
}

variable "user_data" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}
## Informações de variaveis recebidas via CLI ##
variable "container_image_tag" {
  type        = string
}

variable "environment" {
  type        = string
  default     = "dev"
}

variable "base_configuration" {
  type = object({
    owner   = string
    service = string
    tags    = map(any)
  })
}

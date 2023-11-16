# Common variables

variable "gcp-region" {
  type        = string
  description = "Default region to use"
  sensitive   = true
}

variable "gcp-billing-account-id" {
  type        = string
  description = "The GCP billing account id"
  sensitive   = true
}

variable "gcp-org-id" {
  type        = string
  description = "The GCP organization id"
  sensitive   = true
}

variable "gcp-project-id" {
  type        = string
  description = "The GCP project id"
  sensitive   = true
}

variable "gcp-auth-file" {
  type        = string
  description = "GCP authentication file"
  default     = "secrets/google.json"
}

# variable "dns" {
#   type        = list(string)
#   description = "DNS name"
#   sensitive   = true
#   default = [
#     "dwaves-api-test.tonfrere.fr",
#     "dwaves-api.tonfrere.fr",
#     "dwaves-api-staging.tonfrere.fr"
#   ]
# }
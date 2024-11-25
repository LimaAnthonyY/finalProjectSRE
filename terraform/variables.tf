variable "region" {
  description = "Região da AWS"
  default     = "us-east-1"
}

variable "lambda_runtime" {
  description = "Ambiente de execução do Lambda"
  default     = "python3.9" # Altere conforme sua necessidade
}

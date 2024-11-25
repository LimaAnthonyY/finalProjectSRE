output "api_gateway_url" {
  description = "URL do endpoint do API Gateway"
  value       = aws_api_gateway_deployment.query_api.invoke_url
}

output "sqs_queue_arn" {
  description = "ARN da fila SQS"
  value       = aws_sqs_queue.command_queue.arn
}
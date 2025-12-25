output "alb_controller_role_arn" {
  description = "IAM role ARN for AWS Load Balancer Controller"
  value       = module.iam.alb_controller_role_arn
}

output "repository_url" {
  value = module.ecr.repository_url
}
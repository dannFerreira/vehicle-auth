output "user_pool_id" {
  description = "Cognito User Pool ID"
  value       = aws_cognito_user_pool.vehicle.id
}

output "client_id" {
  description = "Cognito App Client ID"
  value       = aws_cognito_user_pool_client.vehicle.id
}

output "issuer_uri" {
  description = "JWT issuer URI used by the Vehicle API"
  value       = "https://cognito-idp.${var.aws_region}.amazonaws.com/${aws_cognito_user_pool.vehicle.id}"
}
output "role_name" {
  description = "IAM role name"
  value = aws_iam_role.this.name
}

output "role_arn" {
  description = "IAM role ARN"
  value = aws_iam_role.this.arn
}

output "instance_profile_name" {
  description = "Instance profile name"
  value = aws_iam_instance_profile.this.name
}

output "instance_profile_arn" {
  description = "Instance profile ARN"
  value = aws_iam_instance_profile.this.arn
}

output "policy_name" {
  description = "Inline policy name"
  value = aws_iam_role_policy.s3_access.name
}

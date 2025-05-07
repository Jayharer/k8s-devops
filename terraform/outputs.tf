// outputs.tf
output "infrastructure_output" {
  value = {
    aws_account_id = data.aws_caller_identity.current.account_id
    vpc_id         = aws_vpc.dev_vpc.id
    efs_id         = aws_efs_file_system.dev-efs.id
  }
}

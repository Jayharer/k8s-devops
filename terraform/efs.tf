
# efs
resource "aws_efs_file_system" "dev-efs" {
  creation_token   = "dev-efs"
  performance_mode = "generalPurpose"
  tags = {
    Name = "dev-efs"
  }
}

# Mount target us-east1a
resource "aws_efs_mount_target" "efs-mtarget-a" {
  file_system_id  = aws_efs_file_system.dev-efs.id
  subnet_id       = aws_subnet.public_subet_a.id
  security_groups = [aws_security_group.efs-sg.id]
}

# Mount target us-east1b
resource "aws_efs_mount_target" "efs-mtarget-b" {
  file_system_id  = aws_efs_file_system.dev-efs.id
  subnet_id       = aws_subnet.public_subet_b.id
  security_groups = [aws_security_group.efs-sg.id]
}

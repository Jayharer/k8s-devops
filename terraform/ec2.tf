# create ec2 instance master
resource "aws_instance" "first-instance" {
  ami                         = "ami-084568db4383264d4"
  instance_type               = "t3.small" # 2vCpu, 2Gb RAM
  key_name                    = aws_key_pair.ec2-key-pair.key_name
  vpc_security_group_ids      = [aws_security_group.ec2-sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2-instance-profile.name
  subnet_id                   = aws_subnet.public_subet_a.id
  associate_public_ip_address = true
  user_data_base64            = base64encode("${templatefile("${path.module}/data/master-install.sh", {})}")

  root_block_device {
    delete_on_termination = true
    volume_size           = 16
    volume_type           = "gp2"
  }

  tags = {
    Name = "master"
  }

  depends_on = [aws_iam_role.ec2-role]
}

# create ec2 instance node01
resource "aws_instance" "node01" {
  ami                         = "ami-084568db4383264d4"
  instance_type               = "t2.small" # 2vCpu, 2Gb RAM
  key_name                    = aws_key_pair.ec2-key-pair.key_name
  vpc_security_group_ids      = [aws_security_group.ec2-sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2-instance-profile.name
  subnet_id                   = aws_subnet.public_subet_a.id
  associate_public_ip_address = true
  user_data_base64 = base64encode("${templatefile("${path.module}/data/worker-install.sh", {
    EFS_ID = aws_efs_file_system.dev-efs.id
  })}")

  root_block_device {
    delete_on_termination = true
    volume_size           = 8
    volume_type           = "gp2"
  }

  tags = {
    Name = "node01"
  }

  depends_on = [aws_iam_role.ec2-role, aws_efs_file_system.dev-efs]
}

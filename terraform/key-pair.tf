# create key pair 
resource "aws_key_pair" "ec2-key-pair" {
  key_name   = var.ssh_key_name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQOOOgbQ6R8bA/nEfthG5oUH6qyj+jdXI1003okjHgmD/L9uWvPp5DDg+t3cqLNL5tAVoGBXInJpblbGivgnhjxFqHvALOvMLEip4wOZ6FhiEScU2y3tAlBaWWiUxsMwqs5H9yK2fbcwXhs3cHcJo6ohghlT7CKB/sVqHk+JAG296RCW8F7Hh7o8XfOg0CzoL2kTsFVnU6bi4WpSbIiF1jmgfjHpbLczVsmAXj+7EXfPsI7DFc5HoGc3OwgZpkvoTpSU0hTJ3k67SDEasZUuvXcmn2/giJ+bPKm96LwbUFH4JW1NBififCkccPsRrirHEYads1EIun8sxhJ5FVhl8R smart@DESKTOP-3E1QE7F"
}

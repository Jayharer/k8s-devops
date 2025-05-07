terraform {
  backend "s3" {
    bucket = "jayambar-terraform-backend"
    key = "k8s-devops/state.tfstate"
    region = "us-east-1"
    profile = "default"
  }
}
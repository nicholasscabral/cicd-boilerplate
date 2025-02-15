resource "aws_ecr_repository" "iac-ci-repository" {
  name = "iac-ci-repository"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Iac = true
  }
}
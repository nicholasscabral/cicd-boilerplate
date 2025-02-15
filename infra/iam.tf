resource "aws_iam_openid_connect_provider" "default" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["d89e3bd43d5d909b47a18977aa9d5ce36cee184c"]

  tags = {
    Iac = true
  }
}

resource "aws_iam_role" "ecr_role" {
  name = "ecr_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRoleWithWebIdentity",
        Principal = {
          Federated = "arn:aws:iam::665548757588:oidc-provider/token.actions.githubusercontent.com"
        },
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = ["sts.amazonaws.com"],
            "token.actions.githubusercontent.com:sub" = [
              "repo:nicholasscabral/cicd-boilerplate:ref:refs/heads/main"
            ]
          }
        }
      }
    ]
  })

  inline_policy {
    name = "ecr-app-permission"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Sid = "Statement1"
          Action = [
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "ecr:BatchCheckLayerAvailability",
            "ecr:PutImage",
            "ecr:InitiateLayerUpload",
            "ecr:UploadLayerPart",
            "ecr:CompleteLayerUpload",
            "ecr:GetAuthorizationToken"
          ]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }

  tags = {
    Iac = true
  }
}
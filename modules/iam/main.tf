data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ec2_secrets_role" {
  name               = "${var.project}-${var.environment}-ec2-secrets-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = {
    Name        = "${var.project}-${var.environment}-ec2-secrets-role"
    Environment = var.environment
  }
}

data "aws_iam_policy_document" "secrets_read_only" {
  statement {
    effect    = "Allow"
    actions   = ["secretsmanager:GetSecretValue"]
    resources = [var.secret_arn]
  }
}

resource "aws_iam_role_policy" "secrets_read_only" {
  name   = "${var.project}-${var.environment}-secrets-read-only"
  role   = aws_iam_role.ec2_secrets_role.name
  policy = data.aws_iam_policy_document.secrets_read_only.json
}

resource "aws_iam_instance_profile" "ec2_secrets_profile" {
  name = "${var.project}-${var.environment}-ec2-secrets-profile"
  role = aws_iam_role.ec2_secrets_role.name

  tags = {
    Name        = "${var.project}-${var.environment}-ec2-secrets-profile"
    Environment = var.environment
  }
}

resource "aws_iam_role" "this" {
  name = "${var.env}-swarm-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

data "aws_iam_policy_document" "swarm_s3" {

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "${var.bucket_arn}/*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      var.bucket_arn
    ]
  }
}

resource "aws_iam_role_policy" "s3_access" {
  name = "${var.env}-swarm-s3-policy"
  role = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.swarm_s3.json
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.env}-swarm-profile"
  role = aws_iam_role.this.name
}

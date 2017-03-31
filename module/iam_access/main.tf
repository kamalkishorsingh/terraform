resource "aws_iam_access_key" "user" {
  user = "${var.user_access}"
}


output "secret" {
  value = "${aws_iam_access_key.user.encrypted_secret}"
}

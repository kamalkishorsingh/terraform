resource "aws_key_pair" "keys" {
key_name = "${var.key}"
public_key = "${file("${var.public_key_pair}")}"
}

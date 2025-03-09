resource "tls_private_key" "tls_private" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name="key_pair"
  public_key = tls_private_key.tls_private.public_key_openssh
}

resource "local_file" "key_pair_private_key" {

    content = tls_private_key.tls_private.private_key_pem
    filename = "key_pair.pem"
}



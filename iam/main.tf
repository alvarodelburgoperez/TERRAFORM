# Recurso IAM para el primer usuario
resource "aws_iam_user" "user1" {
  name = var.user1_name
}

# Recurso IAM para el segundo usuario
resource "aws_iam_user" "user2" {
  name = var.user2_name
}
output "cluster_name" {
  value = aws_eks_cluster.nike-main-cluster.name
}

output "kubeconfig" {
  value = <<EOT
To configure kubectl, run:

aws eks --region us-east-1 update-kubeconfig --name ${aws_eks_cluster.nike-main-cluster.name}
EOT
}
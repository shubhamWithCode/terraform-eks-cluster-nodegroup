#EKS Cluster Creation

resource "aws_eks_cluster" "nike-main-cluster" {
  name = "nike-main-cluster"
  role_arn = aws_iam_role.nike-eks_cluster_role.arn

  vpc_config {
    subnet_ids = data.aws_subnets.available-subnets.ids
    //subnet_ids = data.aws_subnets.default.ids
  }

  depends_on = [ aws_iam_role_policy_attachment.nike-AmazonEKSClusterPolicy, aws_iam_role_policy_attachment.nike-AmazonEKSServicePolicy ]

}

output "endpoint" {
  value = aws_eks_cluster.nike-main-cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.nike-main-cluster.certificate_authority[0].data
}

#EKS nodegroup creation

resource "aws_eks_node_group" "nike-main-nodegrp" {
  cluster_name = aws_eks_cluster.nike-main-cluster.name
  node_group_name = "nike-nodegrp"
  node_role_arn = aws_iam_role.nike-eks_node_role.arn
  subnet_ids = data.aws_subnets.available-subnets.ids
  //subnet_ids = data.aws_subnets.default.ids
  capacity_type = "ON_DEMAND"
  disk_size = "20"
  instance_types = ["t2.micro"]
  labels = tomap({ env = "dev"})
  scaling_config {
    desired_size = 2
    max_size = 3
    min_size = 1
  }
  update_config {
    max_unavailable = 1
  }
  depends_on = [ aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy, aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy, aws_iam_role_policy_attachment.AmazonSSMFullAccess ]
}
output "cluster_name" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "kubeconfig_command" {
  value = "aws eks --region ${var.aws_region} update-kubeconfig --name ${module.eks.cluster_id}"
}

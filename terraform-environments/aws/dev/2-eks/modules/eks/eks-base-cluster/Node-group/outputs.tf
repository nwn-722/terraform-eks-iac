
output "nodegroup-name" {
  value = [
    aws_eks_node_group.node-group-on-demand,
    aws_eks_node_group.node-group-spot
  ]
}
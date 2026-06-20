# Worker ASG ID
output "worker_asg_name" {
    value = aws_autoscaling_group.worker_asg.name
}
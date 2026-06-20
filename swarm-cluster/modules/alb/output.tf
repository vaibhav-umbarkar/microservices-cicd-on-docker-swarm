# ALB DNS
output "alb_dns_name" {
    value = aws_lb.swarm_alb.dns_name
}
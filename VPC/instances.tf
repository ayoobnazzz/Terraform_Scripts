# Demo Ubuntu Server(t2.medium)
resource "aws_instance" "kubernetes_Server" {
  count                  = 1
  ami                    = var.kubernetes_ami
  instance_type          = var.master_instance_type
  vpc_security_group_ids = [aws_security_group.kubernetes_sg.id]
  subnet_id              = element(aws_subnet.kubernetes_subnets.*.id, count.index)
  key_name               = var.key_name

  tags = {
    Name = "Kubernetes_Servers"
    Type = "kubernetes_Master"
  }

}
# 2 Instance Of Redhat Servers(t2.micro)
resource "aws_instance" "kubernetes_Workers" {
  count                  = 2
  ami                    = var.kubernetes_ami
  instance_type          = var.worker_instance_type
  vpc_security_group_ids = [aws_security_group.kubernetes_sg.id]
  subnet_id              = element(aws_subnet.kubernetes_subnets.*.id, count.index)
  key_name               = var.key_name
  user_data              = file("init_script.sh")
  tags = {
    Name = "Redhat_Server_${count.index + 1}"
  }


}

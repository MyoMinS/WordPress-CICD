# aws_launch_template.CodeDeployDemo-AS-Launch-Template:
resource "aws_launch_template" "CodeDeployDemo-AS-Launch-Template" {
    name                                 = "CodeDeployDemo-AS-Launch-Template"
    block_device_mappings {
        device_name  = "/dev/sda1"

        ebs {
            volume_size                = 8
        }
    }
    disable_api_stop                     = false
    disable_api_termination              = false
    iam_instance_profile {
        name = "CodeDeployDemo-EC2-Instance-Profile"
    }
    image_id                             = "ami-02c7683e4ca3ebf58"
    instance_type                        = "t2.micro"
    key_name                             = "ansible"
    user_data                            = "IyEvYmluL2Jhc2ggLXhlCmZhbGxvY2F0ZSAtbCA1MDBNQiAvc3dhcGZpbGUKY2htb2QgNjAwIC9zd2FwZmlsZQpta3N3YXAgL3N3YXBmaWxlCnN3YXBvbiAvc3dhcGZpbGU="
    vpc_security_group_ids               = [
        "sg-07d5add6563060409",
        "sg-08a2b22ac0642a7ec",
    ]
}


# aws_autoscaling_group.CodeDeployDemo-AS-Group:
resource "aws_autoscaling_group" "CodeDeployDemo-AS-Group" {
    name                      = "CodeDeployDemo-AS-Group"
    max_size                  = var.asg_count
    min_size                  = var.asg_count
    health_check_grace_period = 300
    health_check_type         = "EC2"
    desired_capacity          = var.asg_count
    vpc_zone_identifier       = [
        "subnet-003d7b5eab24e0488",
        "subnet-041ccdaaa56e19704",
        "subnet-0ad3c12fab762b304",
    ]

    launch_template {
        id      = aws_launch_template.CodeDeployDemo-AS-Launch-Template.id
        version = "$Latest"
    }

    tag {
        key                 = "Name"
        propagate_at_launch = true
        value               = "CodeDeployDemo"
    }
}

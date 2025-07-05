# aws_codedeploy_deployment_group.SimpleDemoDG:
resource "aws_codedeploy_app" "SimpleDemo" {
    compute_platform    = "Server"
    name                = "SimpleDemoApp"
}

resource "aws_codedeploy_deployment_group" "SimpleDemoDG" {
    app_name                    = aws_codedeploy_app.SimpleDemo.name
    autoscaling_groups          = [
        "CodeDeployDemo-AS-Group",
    ]
    deployment_config_name      = "CodeDeployDefault.OneAtATime"
    deployment_group_name       = "SimpleDemoDG"
    outdated_instances_strategy = "UPDATE"
    service_role_arn            = "arn:aws:iam::484907514740:role/CodeDeployServiceRole"
    termination_hook_enabled    = true

    deployment_style {
        deployment_option = "WITHOUT_TRAFFIC_CONTROL"
        deployment_type   = "IN_PLACE"
    }
    depends_on = [ var.asg_resource]
}
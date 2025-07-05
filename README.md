# WordPress CI/CD Pipeline 🚀

This repository contains the infrastructure and automation code for deploying a WordPress application using **Terraform**, **GitHub Actions**, and **AWS CodeDeploy**. It enables a full CI/CD workflow to provision infrastructure, deploy application code, and manage updates seamlessly.

---

## 🧰 Technologies Used

- **Terraform**: Infrastructure as Code (IaC) for provisioning AWS resources
- **AWS EC2**: Hosting WordPress instances
- **AWS CodeDeploy**: Automating deployment to EC2 instances
- **GitHub Actions**: CI/CD automation pipeline
- **WordPress**: The CMS being deployed
- **Amazon S3**: (Optional) Hosting static assets or backups
- **Amazon IAM**: Managing permissions and roles securely

---

## 📦 Project Structure
```bash
WordPress-CICD/
├── .github/workflows/ # GitHub Actions CI/CD pipeline
├── codedeploy/ # AppSpec file and deployment scripts
├── terraform/ # Terraform configuration files
├── wp-content/ # Custom WordPress plugins/themes (optional)
└── README.md # Project documentation
```

---

## ⚙️ CI/CD Workflow Overview

1. **Infrastructure Provisioning**  
   Use Terraform to provision an EC2 instance, security groups, and IAM roles required for WordPress and CodeDeploy.

2. **GitHub Actions Workflow**  
   On push to `main` or via PR:
   - Validate Terraform configuration
   - Package and upload app code to S3 (if used)
   - Trigger AWS CodeDeploy deployment

3. **CodeDeploy Execution**  
   CodeDeploy pulls the latest code from GitHub/S3 and:
   - Runs pre-installation and post-installation scripts
   - Syncs WordPress files (excluding core if configured)
   - Restarts services if necessary

---

## 🚀 Quick Start

### 1. Clone the Repo

```bash
git clone https://github.com/MyoMinS/WordPress-CICD.git
cd WordPress-CICD
```

### 2. Configure Terraform

Update `terraform/variables.tf` or provide a `terraform.tfvars` file with:
```bash
aws_region       = "ap-southeast-1"
instance_type    = "t2.micro"
key_name         = "your-key-pair"
wordpress_bucket = "your-s3-bucket-name"

```
Then run
```bash
cd terraform
terraform init
terraform apply
```

### 3. Set GitHub Secrets

In your GitHub repo settings, add these secrets:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `DEPLOYMENT_GROUP`
- `APPLICATION_NAME`
- `S3_BUCKET_NAME`

### 4. Push Changes to Deploy

Any push to the `main` branch will:

- Trigger GitHub Actions
- Sync the `wp-content` or custom plugin code
- Trigger AWS CodeDeploy deployment

 🛠 Deployment Details

- WordPress is deployed to `/var/www/html/WordPress` on the EC2 instance.
- Custom plugins and themes are uploaded via rsync or archive deployment.
- `codedeploy/appspec.yml` handles the lifecycle hooks.

### 🔒 Security Notes

- Use IAM roles and least privilege for CodeDeploy and EC2.
- Avoid storing sensitive data in Git. Use SSM Parameter Store or Secrets Manager.

###  📄 License

This project is licensed under the MIT License. See the LICENSE file for details.

### 🙋‍♂️ Author

Myo Min Soe – [MyoMinS](https://github.com/MyoMinS)

### 📬 Feedback / Issues

If you encounter issues or have suggestions, feel free to open an issue or create a pull request.

---

Would you like me to customize parts of this further—e.g., add real Terraform variables, include specific scripts, or show the actual GitHub Actions `.yml` steps?


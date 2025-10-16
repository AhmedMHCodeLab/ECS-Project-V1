# Threat Composer on ECS

## 📋 Project Overview

This repository contains my implementation of Amazon's Threat Composer Tool hosted on AWS ECS using Terraform infrastructure as code. The project demonstrates a complete DevOps workflow with containerization, infrastructure provisioning, CI/CD, and security best practices.

### �️ Architecture Diagram

![AWS ECS Architecture](Diagram.png)

### 🖼️ Application Screenshots

<div align="center">
  <div style="position: relative; width: 90%; max-width: 800px; margin: 20px auto; overflow: hidden; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
    <div id="carousel" style="display: flex; transition: transform 0.5s ease-in-out; width: 400%;">
      <div style="min-width: 25%; position: relative;">
        <img src="threat-composer.png" alt="Threat Composer Dashboard" style="width: 100%; height: 400px; object-fit: cover;"/>
        <div style="position: absolute; bottom: 0; left: 0; right: 0; background: linear-gradient(transparent, rgba(0,0,0,0.8)); color: white; padding: 20px; text-align: center;">
          <h3 style="margin: 0; font-size: 1.2em;">Insights Dashboard</h3>
          <p style="margin: 5px 0 0; opacity: 0.9;">Threat prioritization and category distribution</p>
        </div>
      </div>
      <div style="min-width: 25%; position: relative;">
        <img src="threat-composer1.png" alt="Threat Composer Interface" style="width: 100%; height: 400px; object-fit: cover;"/>
        <div style="position: absolute; bottom: 0; left: 0; right: 0; background: linear-gradient(transparent, rgba(0,0,0,0.8)); color: white; padding: 20px; text-align: center;">
          <h3 style="margin: 0; font-size: 1.2em;">Threat Modeling Interface</h3>
          <p style="margin: 5px 0 0; opacity: 0.9;">Interactive threat modeling workspace</p>
        </div>
      </div>
      <div style="min-width: 25%; position: relative;">
        <img src="threat-composer 2.png" alt="Data Flow Diagram" style="width: 100%; height: 400px; object-fit: cover;"/>
        <div style="position: absolute; bottom: 0; left: 0; right: 0; background: linear-gradient(transparent, rgba(0,0,0,0.8)); color: white; padding: 20px; text-align: center;">
          <h3 style="margin: 0; font-size: 1.2em;">Data Flow Diagram</h3>
          <p style="margin: 5px 0 0; opacity: 0.9;">Visual threat modeling with diagram editor</p>
        </div>
      </div>
      <div style="min-width: 25%; position: relative;">
        <img src="threat-composer 3.png" alt="Application Features" style="width: 100%; height: 400px; object-fit: cover;"/>
        <div style="position: absolute; bottom: 0; left: 0; right: 0; background: linear-gradient(transparent, rgba(0,0,0,0.8)); color: white; padding: 20px; text-align: center;">
          <h3 style="margin: 0; font-size: 1.2em;">Application Features</h3>
          <p style="margin: 5px 0 0; opacity: 0.9;">Comprehensive threat analysis tools</p>
        </div>
      </div>
    </div>
    
    <!-- Navigation dots -->
    <div style="position: absolute; bottom: 10px; left: 50%; transform: translateX(-50%); display: flex; gap: 8px;">
      <button onclick="currentSlide = 0; updateCarousel()" style="width: 12px; height: 12px; border-radius: 50%; border: 2px solid white; background: rgba(255,255,255,0.8); cursor: pointer;"></button>
      <button onclick="currentSlide = 1; updateCarousel()" style="width: 12px; height: 12px; border-radius: 50%; border: 2px solid white; background: rgba(255,255,255,0.3); cursor: pointer;"></button>
      <button onclick="currentSlide = 2; updateCarousel()" style="width: 12px; height: 12px; border-radius: 50%; border: 2px solid white; background: rgba(255,255,255,0.3); cursor: pointer;"></button>
      <button onclick="currentSlide = 3; updateCarousel()" style="width: 12px; height: 12px; border-radius: 50%; border: 2px solid white; background: rgba(255,255,255,0.3); cursor: pointer;"></button>
    </div>
  </div>

  <script>
    let currentSlide = 0;
    const totalSlides = 4;
    
    function updateCarousel() {
      const carousel = document.getElementById('carousel');
      const dots = document.querySelectorAll('button');
      
      carousel.style.transform = `translateX(-${currentSlide * 25}%)`;
      
      dots.forEach((dot, index) => {
        dot.style.background = index === currentSlide ? 'rgba(255,255,255,0.8)' : 'rgba(255,255,255,0.3)';
      });
    }
    
    function nextSlide() {
      currentSlide = (currentSlide + 1) % totalSlides;
      updateCarousel();
    }
    
    // Auto-advance every 5 seconds
    setInterval(nextSlide, 5000);
    
    // Touch/swipe support
    let startX = 0;
    let isDragging = false;
    
    document.getElementById('carousel').addEventListener('touchstart', (e) => {
      startX = e.touches[0].clientX;
      isDragging = true;
    });
    
    document.getElementById('carousel').addEventListener('touchend', (e) => {
      if (!isDragging) return;
      
      const endX = e.changedTouches[0].clientX;
      const diffX = startX - endX;
      
      if (Math.abs(diffX) > 50) {
        if (diffX > 0 && currentSlide < totalSlides - 1) {
          currentSlide++;
        } else if (diffX < 0 && currentSlide > 0) {
          currentSlide--;
        }
        updateCarousel();
      }
      
      isDragging = false;
    });
  </script>
  
  <p style="margin-top: 15px; color: #666; font-size: 0.9em;">
    <span style="display: inline-block; margin-right: 15px;">🖱️ Click dots to navigate</span>
    <span style="display: inline-block; margin-right: 15px;">📱 Swipe on mobile</span>
    <span style="display: inline-block;">⏰ Auto-advances every 5s</span>
  </p>
</div>

### 🔗 Live Demo

Visit the live application: [https://threatcomposer.ahmedmhcodelab.click/](https://threatcomposer.ahmedmhcodelab.click/)

The infrastructure consists of:

- **Network Layer**
  - VPC with public and private subnets across 2 availability zones
  - Internet Gateway for public access
  - NAT Gateways for private subnet egress
  - Security groups with restricted access

- **Container Orchestration**
  - ECS Fargate cluster (serverless container management)
  - Task definitions with proper resource allocation
  - Auto-scaling based on CPU/memory metrics
  - ECR repository for container images

- **Security & Access**
  - Application Load Balancer with HTTPS listener
  - ACM certificate for TLS/SSL
  - Route 53 DNS configuration
  - AWS Secrets Manager for sensitive configuration

- **CI/CD Pipeline**
  - GitHub Actions workflows for automation
  - Container building and security scanning
  - Terraform validation and deployment
  - Zero-downtime deployment strategy

## 💻 Local Development

### Prerequisites

- Node.js and Yarn
- Docker
- AWS CLI
- Terraform 1.0+

### Running Locally

1. Clone the repository:
   ```bash
   git clone https://github.com/AhmedMHCodeLab/ECS-Project-V1.git
   cd ECS-Project-V1/app
   ```

2. Install dependencies and build:
   ```bash
   yarn install
   yarn build
   ```

3. Run the application:
   ```bash
   yarn global add serve
   serve -s build
   ```

4. Access the application at:
   ```
   http://localhost:3000/workspaces/default/dashboard
   ```

### Building & Testing the Container

```bash
docker build -t threat-composer:local ./app
docker run -p 80:80 threat-composer:local
```

## 🔧 Infrastructure Deployment

### Prerequisites

- AWS account with appropriate permissions
- Terraform 1.0+
- A registered domain name (for HTTPS)

### Deployment Steps

1. Configure your AWS credentials:
   ```bash
   aws configure
   ```

2. Update domain settings in `infra/terraform.tfvars`:
   ```hcl
   domain_name = "your-domain.com"
   environment = "dev"  # or "prod"
   ```

3. Initialize and apply Terraform:
   ```bash
   cd infra
   terraform init
   terraform apply
   ```

4. After deployment, access your application using the URL in the Terraform outputs.

## 📁 Project Structure

```
.
├── app/
│   ├── Dockerfile
│   ├── nginx.conf
│   ├── package.json
│   ├── babel.config.json
│   ├── tsconfig.json
│   ├── public/
│   │   ├── index.html
│   │   ├── manifest.json
│   │   └── robots.txt
│   └── src/
│       ├── index.tsx
│       ├── components/
│       ├── containers/
│       ├── contexts/
│       ├── hooks/
│       ├── configs/
│       └── utils/
├── infra/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── locals.tf
│   ├── route53.tf
│   ├── terraform.tfvars
│   └── modules/
│       ├── vpc/
│       ├── sg/
│       ├── ecr/
│       ├── acm/
│       ├── alb/
│       └── ecs/
├── .github/workflows/
│   ├── terraformworkflow.yml
│   ├── manualterraformapply.yml
│   ├── TerraformDestroy.yml
│   └── imagebuildandpush.yml
├── docs/
│   └── screenshots/
├── Diagram.png
└── README.md
```


## 🔒 Security Features

- Private subnets for ECS tasks
- Security groups with least privilege
- HTTPS with TLS 1.2+
- Secrets management for sensitive configuration
- Container scanning in CI/CD
- Infrastructure security scanning


## 📊 Project Outcomes

- Successfully containerized the Threat Composer application
- Implemented a secure, scalable infrastructure on AWS
- Created automation for both application and infrastructure deployment
- Applied best practices for security, networking, and DevOps

## 🔮 Future Improvements

- Implement AWS WAF for additional security
- Add CloudFront for content caching and better global performance
- Set up cross-region disaster recovery
- Implement canary deployments for safer releases

## 📚 Resources Used

- [Terraform AWS Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform AWS ECS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service)
- [Terraform Documentation](https://www.terraform.io/docs/index.html)
- [ECS Documentation](https://docs.aws.amazon.com/ecs/index.html)
- [Threat Composer Documentation](https://github.com/awslabs/threat-composer)

---

Developed by [AhmedMHCodeLab](https://github.com/AhmedMHCodeLab) 

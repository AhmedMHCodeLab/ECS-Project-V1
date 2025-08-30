
## 1️⃣ What are we working on?

**Project Scope:**

* **Goal:** Deploy an open-source web app (based on Threat Composer) to ECS using Terraform, containerized with Docker, and served over HTTPS.
* **Components:**

  * Terraform modules to provision AWS infrastructure (VPC, subnets, ECS cluster, task definitions, load balancer, security groups, ACM certificate).
  * Docker container image for the app, stored in ECR or DockerHub.
  * CI/CD pipeline to build, test, and deploy the container image automatically.
  * Frontend served at `https://tm.<your-domain>` or `https://tm.labs.<your-domain>`.
  * Architecture diagram for documentation.

**Critical assets:**

* AWS resources (ECS, ECR, ACM certificates, secrets if any).
* CI/CD credentials (GitHub Actions tokens, AWS IAM keys).
* App code and container images.
* User data that might be entered into the app.

---

## 2️⃣ What can go wrong?

Here we identify threats and vulnerabilities in the system.

**Infrastructure-level threats:**

* **Misconfigured IAM roles or permissions:** ECS tasks or CI/CD pipelines with excessive privileges.
* **Public exposure:** ECS services exposed without HTTPS or open to the internet without proper security groups.
* **Terraform drift:** Manual changes outside Terraform may lead to inconsistent state.

**Application-level threats:**

* **Insecure container images:** Unpatched libraries or dependencies in the app container.
* **Secrets exposure:** Hard-coded secrets or environment variables in Terraform or Dockerfiles.
* **HTTP instead of HTTPS:** If SSL certificate provisioning fails.

**CI/CD pipeline threats:**

* **Credential leaks:** AWS keys or DockerHub credentials in logs or repo.
* **Compromised pipeline:** Unauthorized users pushing malicious code.

**Operational threats:**

* **Downtime:** ECS service misconfiguration or task failures.
* **Scaling issues:** ECS cluster cannot handle load if misconfigured.
* **Monitoring gaps:** Lack of alerts for failures, high CPU/memory, or security breaches.

---

## 3️⃣ What are we going to do about it?

**Mitigation strategies:**

**Infrastructure:**

* Use **least privilege IAM roles** for ECS tasks, Terraform, and CI/CD.
* Protect ECS services with **security groups**, allow only HTTPS (port 443).
* Use **Terraform modules** consistently to manage resources; avoid manual changes.

**Application:**

* Use **official base Docker images** and regularly update dependencies.
* Store secrets in **AWS Secrets Manager or Parameter Store**, avoid hard-coding.
* Enforce **HTTPS** with ACM certificates and ALB listener rules.

**CI/CD Pipeline:**

* Use GitHub Actions secrets or AWS Secrets Manager for credentials.
* Enable branch protection to prevent unauthorized code merges.
* Implement automated tests and vulnerability scans before deploy.

**Operational:**

* Enable **CloudWatch alarms** for ECS service health and resource usage.
* Enable **Terraform plan/apply review** to avoid accidental destructive changes.
* Monitor container logs for errors or suspicious activity.

---

## 4️⃣ Did we do a good job?

* **Questions to ask yourself post-deployment:**

  * Are all ECS tasks running under minimal privileges? ✅
  * Is HTTPS enforced everywhere? ✅
  * Are secrets safely stored and never exposed in code? ✅
  * Are Terraform resources fully declarative and reproducible? ✅
  * Does the CI/CD pipeline prevent accidental misconfigurations or malicious code? ✅

**Iterative improvement:** Even if all looks good, revisit the threat model after major changes (like adding new features or exposing new endpoints). Ask: *“Did we do a good enough job to minimize risk?”*


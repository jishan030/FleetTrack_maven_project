# 🚗 FleetTrack – AWS DevOps CI/CD Project

### Automating Cloud Infrastructure and CI/CD with AWS, Terraform, Jenkins & SonarQube

FleetTrack is a full-stack vehicle fleet management application developed to demonstrate practical **AWS Cloud Infrastructure Automation and DevOps CI/CD practices**.

The project combines a React frontend, Java Spring Boot backend, Terraform-based AWS infrastructure and a Jenkins CI/CD pipeline integrated with SonarQube Cloud for code quality analysis.

The primary objective is to understand how application code moves through a structured CI/CD workflow and how cloud infrastructure can be provisioned and managed using Infrastructure as Code (IaC).

---

## 📌 Project Overview

FleetTrack provides a basic fleet management application with the following modules:

- **Dashboard:** Overview of fleet management information.
- **Vehicle Management:** Manage vehicle records.
- **Driver Management:** Manage driver information.
- **Trip Management:** Organize trip records.
- **Maintenance Records:** Maintain vehicle maintenance information.

The main focus of this project is not public application hosting. It is the implementation and understanding of DevOps tools, infrastructure automation and CI/CD workflows.

---

## 🛠️ Technology Stack

| Category | Technologies |
|---|---|
| Frontend | React.js, Vite |
| Backend | Java 21, Spring Boot |
| Build Tool | Maven |
| Version Control | Git, GitHub |
| CI/CD | Jenkins |
| Code Quality | SonarQube Cloud |
| Infrastructure as Code | Terraform |
| Cloud Platform | AWS |
| Cloud Services | EC2, VPC, S3, CloudFront |
| Operating System | Ubuntu Linux |

---

## 🏗️ AWS Infrastructure Architecture

The project uses Terraform to provision and manage AWS infrastructure.

### Infrastructure Components

| AWS Service | Purpose |
|---|---|
| Amazon VPC | Isolated cloud networking |
| Public Subnet | Public network connectivity |
| Internet Gateway | Internet connectivity for the VPC |
| Security Group | Network access control |
| Amazon EC2 | Jenkins and CI/CD environment |
| Amazon S3 | Frontend storage infrastructure |
| Amazon CloudFront | CDN infrastructure |

Infrastructure configuration is maintained using Terraform, making cloud resource provisioning more organized and repeatable.

---

## 🔄 CI/CD Pipeline Workflow

The Jenkins pipeline automates the major build and release preparation activities.

### Pipeline Architecture

```text
              Developer
                  |
                  |
                  v
             GitHub Repo
                  |
                  v
             Jenkins CI/CD
                  |
                  v
             Source Checkout
                  |
          +-------+-------+
          |               |
          v               v
     Backend Build   Frontend Build
       (Maven)        (React/Vite)
          |
          v
    SonarQube Cloud
     Code Analysis
          |
          v
     Build Validation
          |
          v
     Release Packaging
          |
          v
    Archive Artifacts
          |
          v
      Build Complete
```

### Pipeline Stages

**1. Checkout**

Jenkins retrieves the latest source code from the GitHub repository.

**2. Backend Build**

Maven builds the Spring Boot application and generates the JAR artifact.

**3. SonarQube Analysis**

SonarQube Cloud analyzes the backend source code to provide code quality insights.

**4. Frontend Build**

Jenkins installs frontend dependencies and creates a production build using Vite.

**5. Release Packaging**

Jenkins archives the generated backend JAR and frontend build files as pipeline artifacts.

**6. Build Completion**

The pipeline completes after successful build, analysis and artifact archiving.

---

## 🧪 SonarQube Cloud Integration

SonarQube Cloud is integrated into the Jenkins pipeline for automated code quality analysis.

Key implementation details:

- Jenkins credentials integration for secure token access.
- SonarQube Cloud project integration.
- Automated analysis during the pipeline.
- Code quality reporting.

---

## ⚙️ Terraform Infrastructure Automation

Terraform is used to define and manage AWS infrastructure through configuration files.

### Terraform Workflow

```text
Terraform Configuration
          |
          v
    terraform init
          |
          v
    terraform validate
          |
          v
      terraform plan
          |
          v
      terraform apply
          |
          v
   AWS Infrastructure
```

Terraform helps manage infrastructure in a consistent and repeatable way.

---

## 📂 Project Structure

```text
FleetTrack/
│
├── .github/
│
├── backend/
│   ├── src/
│   ├── pom.xml
│   └── ...
│
├── frontend/
│   ├── src/
│   ├── package.json
│   └── ...
│
├── terraform/
│   ├── main.tf
│   └── ...
│
├── Jenkinsfile
├── .gitignore
└── README.md
```

---

## 🚀 Tools and Commands

### Backend Build

```bash
cd backend
mvn clean package -DskipTests
```

### Frontend Build

```bash
cd frontend
npm ci
npm run build
```

### Terraform Commands

```bash
cd terraform

terraform init

terraform validate

terraform plan
```

Review the Terraform plan before applying infrastructure changes.

### Git Commands

```bash
git add .
git commit -m "Update FleetTrack project"
git push origin main
```

---

## 🎯 Key DevOps Learnings

Through this project, I gained practical experience with:

- AWS cloud infrastructure provisioning.
- Terraform Infrastructure as Code.
- Jenkins pipeline configuration.
- CI/CD workflow implementation.
- Java Spring Boot application builds.
- React frontend production builds.
- SonarQube Cloud integration.
- Jenkins credentials management.
- Build artifact archiving.
- AWS infrastructure lifecycle management.
- Troubleshooting Jenkins executor and disk-space issues.

---

## 📌 Project Status

| Component | Status |
|---|---|
| React Frontend | Completed |
| Spring Boot Backend | Completed |
| AWS Infrastructure with Terraform | Implemented |
| Jenkins CI Pipeline | Completed |
| SonarQube Cloud Integration | Completed |
| Release Packaging | Completed |
| GitHub Integration | Completed |
| Public Website Hosting | Not Included |
| Prometheus & Grafana | Not Included |

**Note:** The project demonstrates CI, code quality analysis and release artifact packaging. Public application hosting and production application deployment are outside the project scope.

AWS infrastructure resources are intended to be destroyed after the practical work to avoid unnecessary cloud costs.

---

## 👨‍💻 Author

**Jishan Khan**

Aspiring AWS & DevOps Engineer

- GitHub: [@jishan030](https://github.com/jishan030)
- Project Repository: [FleetTrack](https://github.com/jishan030/FleetTrack_maven_project.git)

---

### ⭐ If you find this project useful, feel free to explore the repository!

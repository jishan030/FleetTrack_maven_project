# 🚗 FleetTrack – Vehicle Fleet Management System

### Java | Spring Boot | Maven | React | AWS | Terraform | Jenkins | SonarQube

FleetTrack is a **Java-based Vehicle Fleet Management System** developed using Spring Boot and Maven, with a React.js frontend.

The application is designed to organize and manage essential fleet operations, including vehicles, drivers, trips, and maintenance records.

Alongside application development, this project demonstrates practical DevOps implementation using AWS, Terraform, Jenkins CI/CD, and SonarQube Cloud for automated build and code quality analysis.

---

## 📌 Project Overview

Managing fleet operations involves maintaining vehicle information, tracking drivers, organizing trips, and keeping maintenance records.

FleetTrack brings these essential management activities together in one application.

### Core Modules

| Module | Description |
|---|---|
| Dashboard | Overview of fleet management information |
| Vehicle Management | Manage vehicle information and records |
| Driver Management | Maintain driver information |
| Trip Management | Organize and manage trip records |
| Maintenance Records | Maintain vehicle maintenance information |

---

## 🛠️ Technology Stack

### Application Development

| Technology | Purpose |
|---|---|
| Java 21 | Backend programming language |
| Spring Boot | Backend application framework |
| Apache Maven | Dependency management and build automation |
| React.js | Frontend development |
| Vite | Frontend build tooling |

### DevOps & Cloud

| Technology | Purpose |
|---|---|
| Git & GitHub | Version control and source code management |
| Jenkins | CI/CD pipeline automation |
| SonarQube Cloud | Automated code quality analysis |
| Terraform | Infrastructure as Code |
| AWS EC2 | Cloud-based Jenkins environment |
| AWS VPC | Cloud networking |
| AWS S3 | Storage infrastructure |
| AWS CloudFront | CDN infrastructure |
| Ubuntu | Server operating system |

---

## 🏗️ Application Architecture

FleetTrack follows a frontend-backend architecture.

```text
          FLEETTRACK APPLICATION
          
       +----------------------+
       |    React Frontend    |
       |                      |
       |      Vite            |
       +----------+-----------+
                  |
                  | REST API
                  |
                  v
       +----------------------+
       |  Spring Boot Backend |
       |                      |
       |       Java 21        |
       +----------+-----------+
                  |
                  v
       +----------------------+
       |   Maven Build System |
       |                      |
       | Dependency Management|
       | Compilation & JAR    |
       +----------------------+
```

The React frontend communicates with the Spring Boot backend through REST APIs.

---

## ☁️ AWS Infrastructure

AWS infrastructure for the project was provisioned using Terraform.

### Infrastructure Components

| AWS Service | Implementation |
|---|---|
| Amazon VPC | Isolated networking environment |
| Public Subnet | Public network connectivity |
| Internet Gateway | Internet connectivity for the VPC |
| Security Group | Network traffic control |
| Amazon EC2 | Jenkins and CI/CD environment |
| Amazon S3 | Frontend storage infrastructure |
| Amazon CloudFront | CDN infrastructure |

Infrastructure resources were managed through Terraform configuration files.

---

## ⚙️ Maven Build Management

Apache Maven is used to manage the Java backend project.

Maven handles:

- Project dependencies.
- Build lifecycle.
- Java compilation.
- Application packaging.
- JAR artifact generation.

### Backend Build

```bash
cd backend

mvn clean package -DskipTests
```

The generated Spring Boot JAR is available inside:

```text
backend/target/
```

---

## 🔄 Jenkins CI/CD Pipeline

Jenkins automates the application build and release packaging workflow.

The pipeline is integrated with GitHub and SonarQube Cloud.

### Pipeline Architecture

```text
             GitHub Repository
                     |
                     v
                Jenkins
                     |
                     v
               Git Checkout
                     |
          +----------+----------+
          |                     |
          v                     |
     Backend Build              |
       (Maven)                  |
          |                     |
          v                     |
    SonarQube Cloud             |
    Code Analysis               |
          |                     |
          +----------+----------+
                     |
                     v
              Frontend Build
               (React/Vite)
                     |
                     v
              Build Completed
                     |
                     v
              Release Packaging
                     |
                     v
              Archive Artifacts
```

### Jenkins Pipeline Stages

**1. Source Code Checkout**

Jenkins fetches the latest source code from the GitHub repository.

**2. Backend Build**

Maven compiles and packages the Spring Boot backend application.

**3. SonarQube Analysis**

SonarQube Cloud performs automated source code quality analysis.

**4. Frontend Build**

Jenkins installs frontend dependencies and generates the production build using Vite.

**5. Release Packaging**

Jenkins archives the generated backend JAR and frontend build files.

**6. Artifact Archiving**

Build artifacts are stored in Jenkins for future reference.

### Jenkinsfile

The pipeline is defined using a declarative Jenkinsfile stored in the root directory of the repository.

---

## 🔍 SonarQube Cloud Integration

SonarQube Cloud is integrated into the Jenkins pipeline to analyze backend source code.

### Implementation

- SonarQube Cloud project integration.
- Jenkins credentials for secure token management.
- Automated Maven-based SonarQube analysis.
- Code quality reporting.
- CI pipeline integration.

This integration helps identify code quality issues during the development workflow.

---

## 🏗️ Terraform – Infrastructure as Code

Terraform is used to provision and manage the AWS infrastructure.

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

### Common Terraform Commands

Initialize the working directory:

```bash
terraform init
```

Validate configuration:

```bash
terraform validate
```

Review infrastructure changes:

```bash
terraform plan
```

Provision infrastructure:

```bash
terraform apply
```

Review the execution plan before applying infrastructure changes.

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
│   └── target/
│
├── frontend/
│   ├── src/
│   ├── public/
│   ├── package.json
│   └── vite.config.js
│
├── terraform/
│   └── main.tf
│
├── Jenkinsfile
│
├── .gitignore
│
└── README.md
```

---

## 🚀 Running the Application Locally

### Prerequisites

Install the following tools:

- Java JDK 21
- Apache Maven
- Node.js and npm
- Git

### 1. Clone the Repository

```bash
git clone https://github.com/jishan030/FleetTrack_maven_project.git
```

```bash
cd FleetTrack_maven_project
```

### 2. Run the Backend

```bash
cd backend
mvn clean package -DskipTests
```

Run the generated JAR:

```bash
java -jar target/fleettrack-backend-0.0.1-SNAPSHOT.jar
```

### 3. Run the Frontend

Open another terminal:

```bash
cd frontend
npm install
npm run dev
```

The frontend development server will display its local address in the terminal.

---

## 🎯 Key Learning Outcomes

This project provided practical experience in:

- Developing a Java-based application using Spring Boot.
- Managing Java dependencies and builds with Maven.
- Understanding Maven build and packaging lifecycle.
- Working with React and Vite.
- Managing source code through Git and GitHub.
- Configuring Jenkins declarative pipelines.
- Integrating SonarQube Cloud with Jenkins.
- Automating backend and frontend builds.
- Archiving release artifacts.
- Provisioning AWS infrastructure using Terraform.
- Managing cloud infrastructure lifecycle.
- Troubleshooting Jenkins build, executor and disk-space issues.

---

## 📊 Project Status

| Component | Status |
|---|---|
| Java Backend | Completed |
| Spring Boot | Implemented |
| Maven Build | Completed |
| React Frontend | Implemented |
| AWS Infrastructure | Provisioned using Terraform |
| Jenkins CI Pipeline | Completed |
| SonarQube Cloud Integration | Completed |
| Frontend Build Automation | Completed |
| Release Artifact Packaging | Completed |
| GitHub Integration | Completed |
| Public Website Hosting | Not Included |
| Production Application Deployment | Not Included |

**Project Scope:** This project focuses on Java application development, Maven build automation, AWS infrastructure provisioning and CI/CD implementation. Release packaging is automated through Jenkins; public production hosting and application deployment are outside the current scope.

---

## 👨‍💻 Author

### Jishan Khan
**Aspiring AWS & DevOps Engineer**

GitHub: [@jishan030](https://github.com/jishan030)

Project Repository:

[ FleetTrack – GitHub Repository](https://github.com/jishan030/FleetTrack_maven_project)

---

### ⭐ Thank You for Visiting!

Feel free to explore the repository and learn from the implementation.

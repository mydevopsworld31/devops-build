# ⚛️ React Application — CI/CD Pipeline with Monitoring

> End-to-end deployment of a production-ready React application using Docker, Jenkins, AWS EC2, and a full Prometheus + Grafana monitoring stack.

<br/>

## 📌 Project Highlights

- 🐳 **Dockerized** React app served via Nginx
- ⚙️ **Jenkins CI/CD** pipeline triggered by GitHub Webhooks
- ☁️ **AWS EC2** deployment (Ubuntu)
- 📊 **Prometheus + Grafana** monitoring with alerting
- 🔔 **Blackbox Exporter** for uptime/downtime detection
- 🤖 **Bash automation** scripts for build and deploy

---

## 🏗️ Architecture

```
GitHub (push)
     │
     ▼
Jenkins (Webhook Trigger)
     │
     ├── Build Docker Image
     ├── Push to Docker Hub
     │
     ▼
AWS EC2 (Ubuntu)
     │
     ├── Pull Latest Image
     ├── Stop Old Container
     └── Deploy New Container
              │
              ▼
     Prometheus + Grafana
     (Metrics · Alerts · Dashboards)
```

**Application Flow:**
```
GitHub → Jenkins → Docker Build → Docker Hub → EC2 Deployment → Monitoring
```

---

## 🛠️ Tech Stack

| Category | Tools |
|---|---|
| **Frontend** | React (Static Build) |
| **Containerization** | Docker, Docker Compose |
| **Web Server** | Nginx |
| **CI/CD** | Jenkins + GitHub Webhooks |
| **Cloud** | AWS EC2 (Ubuntu) |
| **Monitoring** | Prometheus, Grafana, Node Exporter, Blackbox Exporter |
| **Version Control** | Git, GitHub |
| **Automation** | Bash Scripts |

---

## 📁 Project Structure

```
devops-build/
│
├── build/                      # React production build output
├── Dockerfile                  # Container image definition
├── docker-compose.yml          # App service orchestration
├── build.sh                    # Build & push Docker image
├── deploy.sh                   # Pull & deploy latest container
├── .gitignore
├── .dockerignore
│
└── monitoring/
    ├── docker-compose.yml      # Monitoring stack orchestration
    ├── prometheus.yml          # Prometheus scrape config
    └── alert.rules.yml        # Alerting rules (downtime detection)
```

---

## 🐳 Docker Setup

### Build Image
```bash
docker build -t mydockerimage31/dev:latest .
```

### Run Container
```bash
docker run -d -p 80:80 --name react-app mydockerimage31/dev:latest
```

### Run with Docker Compose
```bash
docker-compose up -d
```

---

## 🤖 Bash Automation Scripts

### `build.sh` — Build & Push
```
1. Builds Docker image from Dockerfile
2. Tags image with latest version
3. Pushes image to Docker Hub
```
```bash
chmod 755 build.sh
./build.sh
```

### `deploy.sh` — Deploy to EC2
```
1. Pulls latest image from Docker Hub
2. Stops and removes old running container
3. Starts new container with updated image
```
```bash
chmod 755 deploy.sh
./deploy.sh
```

---

## ☁️ AWS EC2 Configuration

**Instance:** Ubuntu (t2.micro / free tier)

**Security Group — Inbound Rules:**

| Port | Protocol | Purpose | Access |
|------|----------|---------|--------|
| 22 | SSH | Remote server access | My IP only |
| 80 | HTTP | React application | Public |
| 8080 | HTTP | Jenkins dashboard | Public |
| 3000 | HTTP | Grafana dashboard | Public |
| 9090 | HTTP | Prometheus UI | Public |
| 3001 | HTTP | Monitoring service | Public |

---

## ⚙️ CI/CD Pipeline — Jenkins

### Workflow

```
1. Developer pushes code to GitHub
        ↓
2. GitHub Webhook triggers Jenkins job
        ↓
3. Jenkins builds Docker image
        ↓
4. Image pushed to Docker Hub
        ↓
5. Jenkins SSHs into EC2
        ↓
6. deploy.sh pulls & runs new container
        ↓
7. App live at http://<EC2-IP>:80
```

### Jenkins Pipeline Stages

```groovy
pipeline {
    agent any
    stages {
        stage('Build') { ... }      // Docker image build
        stage('Push')  { ... }      // Push to Docker Hub
        stage('Deploy'){ ... }      // Deploy on EC2
    }
}
```

---

## 🐳 Docker Hub

| Repo | Visibility | Purpose |
|------|-----------|---------|
| `mydockerimage31/dev` | 🌐 Public | Development builds |
| `mydockerimage31/prod` | 🔒 Private | Production releases |

---

## 📊 Monitoring Stack

### Tools

| Tool | Purpose |
|------|---------|
| **Prometheus** | Metrics collection & storage |
| **Grafana** | Visualization & dashboards |
| **Node Exporter** | Server metrics (CPU, Memory, Disk) |
| **Blackbox Exporter** | Application uptime monitoring |

### Start Monitoring Stack
```bash
cd monitoring/
docker-compose up -d
```

### What's Monitored

- ✅ **Server health** — CPU usage, memory, disk, network
- ✅ **Application uptime** — HTTP endpoint checked every 30s
- ✅ **Alerting** — notification triggered when app goes DOWN
- ✅ **Grafana dashboards** — visual panels for all metrics

### Alert Rule (prometheus `alert.rules.yml`)
```yaml
- alert: AppDown
  expr: probe_success == 0
  for: 1m
  labels:
    severity: critical
  annotations:
    summary: "Application is DOWN"
```

---

## 🌐 Access URLs

| Service | URL |
|---------|-----|
| **React App** | `http://<EC2-IP>` |
| **Jenkins** | `http://<EC2-IP>:8080` |
| **Grafana** | `http://<EC2-IP>:3000` |
| **Prometheus** | `http://<EC2-IP>:9090` |

> Replace `<EC2-IP>` with your actual AWS EC2 public IP address.

---

## 📝 Project Summary

> *"Deployed a production-ready React application using Docker and Nginx on AWS EC2. Implemented a Jenkins CI/CD pipeline integrated with GitHub Webhooks to fully automate the build and deployment process. Set up a monitoring stack using Prometheus, Grafana, Node Exporter, and Blackbox Exporter to track both system and application health — with alerting configured to detect downtime automatically."*

---

## 🧠 Key Learnings

- How Docker layers work and why `.dockerignore` matters for image size
- Jenkins pipeline stages and how webhooks trigger automated builds
- AWS EC2 security groups — least privilege port configuration
- Difference between Node Exporter (server metrics) and Blackbox Exporter (app uptime)
- Why monitoring and alerting matters in production deployments

---

## 👨‍💻 Author

**Naresh Prasad Yadav**
[![LinkedIn](https://img.shields.io/badge/LinkedIn-%230077B5.svg?style=flat&logo=linkedin&logoColor=white)](https://linkedin.com/in/mrnareshyadav)
[![GitHub](https://img.shields.io/badge/GitHub-%23121011.svg?style=flat&logo=github&logoColor=white)](https://github.com/mydevopsworld31)

---

*⭐ Star this repo if it helped you understand DevOps pipelines!*

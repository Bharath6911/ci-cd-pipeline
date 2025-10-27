# CI/CD-Based Two-Tier Web Application Deployment

## Overview

This project demonstrates a complete CI/CD pipeline for deploying a two-tier containerized web application across **two Azure Ubuntu Virtual Machines** using **Docker** and **GitHub Actions**.
It includes a **frontend (NGINX)** server for user input and a **backend (Flask + SQLite3)** server for data storage.

The goal was to understand real-world deployment workflows, automation, and containerized microservice communication between cloud VMs.

---

## Files structure

ci-cd-pipeline/
├── .github/
│   └── workflows/
│       └── ci-cd.yml
├── frontend/
│   ├── Dockerfile
│   ├── index.html
│   └── nginx.conf
└── backend/
    ├── Dockerfile
    ├── app.py
    └── requirements.txt

---

## Architecture

### Frontend (VM 1)

**Host:** Azure Ubuntu VM (4GB RAM)
**Username:** `Bharath`
**IP Address:** `20.193.156.146`
**Open Ports:** `22 (SSH)`, `80 (HTTP)`

**Purpose:**
Serves an HTML form to users via NGINX running inside a Docker container.
The form submission sends data to the backend API endpoint.

**Files Used:**

* `index.html` – HTML form interface for data submission.
* `nginx.conf` – Configures NGINX to serve static content and proxy requests.
* `Dockerfile` – Builds the NGINX image for container deployment.

---

### Backend (VM 2)

**Host:** Azure Ubuntu VM (4GB RAM)
**Username:** `Bharath2`
**IP Address:** `20.193.152.161`
**Open Ports:** `22 (SSH)`, `8080 (HTTP)`

**Purpose:**
Receives POST requests from the frontend and stores data in a local SQLite3 database inside a container.

**Files Used:**

* `app.py` – Flask application handling `/submit` POST requests.
* `requirements.txt` – Python dependencies for the Flask app.
* `Dockerfile` – Builds the backend image with Flask and SQLite3 installed.

---

## Workflow Automation (CI/CD)

**Pipeline File:** `.github/workflows/main.yaml`

The pipeline performs the following automated tasks:

1. **Build**

   * Builds Docker images for both frontend and backend from their respective directories.

2. **Push**

   * Pushes the images to **Docker Hub** using credentials stored in repository secrets:

     * `DOCKERHUB_USERNAME`
     * `DOCKERHUB_TOKEN`

3. **Deploy**

   * Connects to both Azure VMs using SSH via secrets:

     * `SSH_KEY`
     * `SSH_USER_FRONTEND`
     * `SSH_USER_BACKEND`
     * `FRONTEND_HOST`
     * `BACKEND_HOST`
   * Pulls the latest Docker images and restarts the containers automatically.

This provides **continuous integration and deployment** without manual intervention.
Every push to the `main` branch redeploys both servers automatically.

---

## Security and Network Configuration

**Azure NSG (Network Security Group) rules:**

* **Frontend VM:** Ports 22, 80
* **Backend VM:** Ports 22, 8080

**Access Method:**

* SSH key-based authentication using `azure_key` for both VMs.
* CI/CD pipeline securely deploys through SSH without exposing credentials.

---

## Local Development (Pre-Deployment Testing)

Before deploying on Azure, local testing was done on a **Kali Linux VM**:

* Created a script `script.sh` to automate directory and file setup for CI/CD.
* Built a sample `app.py` Flask file returning:

  ```
  "Hello from CICD FlaskAPP"
  ```
* Validated Docker build and run commands locally.
* Tested a prototype pipeline (`ci-cd.yml`) to simulate GitHub Actions behavior.

This ensured all Docker configurations and pipeline scripts worked before cloud deployment.

---

## Technologies Used

| Category         | Tools              |
| ---------------- | ------------------ |
| Cloud Platform   | Microsoft Azure    |
| Operating System | Ubuntu 22.04 LTS   |
| Frontend         | NGINX (Dockerized) |
| Backend          | Flask (Python)     |
| Database         | SQLite3            |
| Containerization | Docker             |
| CI/CD Automation | GitHub Actions     |
| Version Control  | Git & GitHub       |

---

## Outcome

* Automated **build → push → deploy** workflow using GitHub Actions.
* Fully functional two-tier web application with form submission and persistent storage.
* Secure VM-based deployment using SSH key authentication.
* Demonstrated real-world CI/CD pipeline principles and Docker-based scalability.

---

## Future Improvements

* Add HTTPS using SSL certificates.
* Replace SQLite3 with PostgreSQL or MySQL for multi-user scalability.
* Integrate monitoring (Prometheus + Grafana).
* Extend CI/CD to Kubernetes clusters for high availability.

---

# CI/CD Pipeline for a Containerized Flask Web App

This project demonstrates a complete, automated CI/CD pipeline for a simple Python Flask web application. The pipeline automatically tests the application, builds a Docker image, and pushes it to Docker Hub upon every push to the `main` branch.

This repository serves as a practical example of fundamental DevOps practices and is a key project in my portfolio.

### Live Demo

The latest build of this application is available as a Docker image on Docker Hub: https://hub.docker.com/r/mari25/flask-cicd-portfolio

---

## Tech Stack

*   **Application Framework:** Flask (Python)
*   **Containerization:** Docker
*   **CI/CD Automation:** GitHub Actions
*   **Container Registry:** Docker Hub
*   **Testing:** Pytest

---

## Pipeline Workflow

The CI/CD pipeline is defined in `.github/workflows/main.yml` and executes the following sequence of jobs:

```
Code Push (to main branch)
       │
       ▼
┌──────────────────────┐
│  GitHub Actions Job  │
│    (ubuntu-latest)   │
└──────────────────────┘
       │
       ▼
┌──────────────────────┐
│  1. Checkout Code    │
└──────────────────────┘
       │
       ▼
┌──────────────────────┐
│  2. Set up Python    │
└──────────────────────┘
       │
       ▼
┌──────────────────────┐
│ 3. Install Python    │
│      Dependencies    │
└──────────────────────┘
       │
       ▼
┌──────────────────────┐
│   4. Run Pytests     │
│  (CI Validation Gate)│
└──────────────────────┘
       │
       ▼ (If tests pass & push to main)
┌──────────────────────┐
│ 5. Login to DockerHub│
│ (Using Encrypted     │
│       Secrets)       │
└──────────────────────┘
       │
       ▼
┌──────────────────────┐
│6. Build & Push Image │
│  (CD to Registry)    │
└──────────────────────┘
       │
       ▼
┌──────────────────────┐
│    Final Destination │
│      Docker Hub      │
└──────────────────────┘
```

---

## How to Run Locally

To test and run this application on your local machine, please follow these steps.

**Prerequisites:**
*   Python 3.9+
*   Docker Desktop

**Instructions:**
1.  **Clone the repository:**
    ```sh
    git clone https://github.com/mariiaba/flask-cicd-portfolio.git
    cd flask-cicd-portfolio
    ```

2.  **Create and activate a virtual environment:**
    ```sh
    python3 -m venv venv
    source venv/bin/activate
    ```

3.  **Install the required dependencies:**
    ```sh
    pip install -r requirements.txt
    ```

4.  **Run the automated tests:**
    ```sh
    python -m pytest
    ```

5.  **Build the Docker image:**
    ```sh
    docker build -t my-flask-app .
    ```

6.  **Run the application inside a Docker container:**
    ```sh
    docker run -p 5000:5000 my-flask-app
    ```
7.  Open your web browser and navigate to `http://localhost:5000` to see the application running.

---

## Challenges & Solutions

This project provided valuable hands-on experience in debugging common development and CI issues.

#### 1. Python Path and `ModuleNotFoundError`
*   **Problem:** Initial test runs failed with `ModuleNotFoundError: No module named 'app'`. The test runner couldn't locate the application module from the separate `/tests` directory.
*   **Solution:** I resolved this by changing the test execution command from `pytest` to `python -m pytest`. This ensures the Python interpreter runs pytest as a module, correctly adding the project's root directory to the system path and enabling module discovery. This fix was applied both locally and in the GitHub Actions workflow file.

#### 2. Dependency Conflict and `ImportError`
*   **Problem:** The application failed with an `ImportError: cannot import name 'url_quote' from 'werkzeug.urls'`. This was caused by an incompatible version of `Werkzeug` (a core dependency of Flask) being installed automatically.
*   **Solution:** I identified the version conflict and pinned the dependency to a known stable version (`Werkzeug==2.3.7`) in the `requirements.txt` file. This highlights the critical importance of explicit version management for creating stable, reproducible builds.

#### 3. Local Environment vs. System Python
*   **Problem:** Locally, `pip install` was blocked by an `error: externally-managed-environment`, a safeguard in modern Linux distributions to protect system packages.
*   **Solution:** I followed Python best practices by creating and activating a virtual environment (`venv`). This isolates the project's dependencies, preventing conflicts with system packages and ensuring a clean, encapsulated development environment.

---

## Future Improvements

 Potential next steps to further enhance it include:

*   **Deployment to the Cloud:** Add a final "deploy" job to the pipeline to automatically deploy the container to a cloud service like **AWS ECS**, **Google Cloud Run**, or a **Kubernetes** cluster.
*   **Semantic Versioning:** Implement a step to automatically tag Docker images with semantic version numbers based on Git tags or commit messages.
*   **Linting & Code Quality:** Integrate a linter like `flake8` into the CI pipeline to enforce code quality standards.
*   **Multi-Stage Docker Builds:** Optimize the `Dockerfile` using multi-stage builds to create a smaller, more secure production image.

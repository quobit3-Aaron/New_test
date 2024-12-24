
# Project Name

This is a project to test Docker, Azure Container Instances (ACI), and OneDrive integration.

- Docker image is built and pushed to Azure Container Registry (ACR).
- The image is deployed to Azure Container Instances (ACI).
- The results are saved to OneDrive.

## Files:

- `Dockerfile`: Defines the container image.
- `app.py`: The application code to be executed in the container.
- `save_to_onedrive.py`: Handles saving results to OneDrive.
- `.github/workflows/deploy.yml`: GitHub Actions workflow file for CI/CD.
- `requirements.txt`: Python dependencies for the project.

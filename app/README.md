# FastAPI Backend Application

This repository contains a FastAPI-based backend application designed for containerized deployment in k8s or Docker envs.

## Project Structure

```
app/
├── backend/             # FastAPI backend application
│   ├── app/             # Application code
│   │   ├── alembic/     # Database migrations
│   │   ├── api/         # API endpoints
│   │   ├── core/        # Core functionality
│   │   ├── tests/       # Test suite
│   │   └── main.py      # Application entry point
│   ├── scripts/         # Utility scripts
│   └── Dockerfile       # Container definition
├── .env                 # Environment variables
├── app-buildspec.yml    # AWS CodeBuild specification
└── docker-compose.yml   # Local development setup
```

## Features

- RESTful API built with FastAPI
- PostgreSQL database with SQLModel ORM
- JWT authentication
- Email-based password recovery
- Comprehensive test suite
- Docker containerization
- CI/CD pipeline support (AWS CodeBuild)

## Prerequisites

- Docker and Docker Compose
- Python 3.10+
- uv package manager (recommended)

## Local Development

1. Clone the repository
2. Configure environment variables in `.env` file
3. Start the development environment:

```bash
docker compose up -d
```

The API will be available at http://localhost:8000 with interactive documentation at http://localhost:8000/docs

## Environment Variables

Key environment variables include:

| Variable | Description | Default |
|----------|-------------|---------|
| `POSTGRES_USER` | Database username | `postgres` |
| `POSTGRES_PASSWORD` | Database password | `changethis` |
| `POSTGRES_DB` | Database name | `app` |
| `SECRET_KEY` | JWT secret key | `changethis` |
| `FIRST_SUPERUSER` | Admin email | `admin@example.com` |
| `FIRST_SUPERUSER_PASSWORD` | Admin password | `changethis` |

## Docker Image

The application is containerized using Docker. The image is built using the Dockerfile in the `backend` directory.

```bash
# Build the image locally
docker build -t app/backend:latest ./backend

# Run the container
docker run -p 8000:8000 --env-file .env app/backend:latest
```

## CI/CD Pipeline

The application includes an AWS CodeBuild specification file (`app-buildspec.yml`) for continuous integration and deployment:

1. Authenticates with Amazon ECR
2. Builds the Docker image
3. Tags the image
4. Pushes the image to ECR

Required environment variables for the pipeline:
- `REGION`: AWS region
- `ACCOUNT_ID`: AWS account ID
- `IMAGE_NAME`: ECR repository name
- `TAG`: Image tag

## API Documentation

When running, the API documentation is available at:
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

## Testing

Run the test suite with:

```bash
# In the running container
docker compose exec backend bash scripts/tests-start.sh

# Or using the test script
cd backend
bash ./scripts/test.sh
```

## Database Migrations

Database migrations are managed with Alembic:

```bash
# Inside the backend container
docker compose exec backend bash
alembic revision --autogenerate -m "Description"
alembic upgrade head
```

## Security Notes

- Change all default passwords in the `.env` file before deployment
- Generate a secure `SECRET_KEY` using:
  ```bash
  python -c "import secrets; print(secrets.token_urlsafe(32))"
  ```
- Configure proper CORS settings for production

## Deployment

This application is designed to be deployed to Kubernetes using the Helm chart in the `appchart` directory.
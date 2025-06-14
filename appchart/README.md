# Application Helm Chart

This Helm chart deploys a complete application stack consisting of a backend service and a PostgreSQL database in a k8s environment.

## Overview

This chart deploys:
- A backend application with configurable replicas
- A PostgreSQL database using StatefulSet
- Required Kubernetes resources (Services, ConfigMaps, Secrets)
- Ingress configuration for external access

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- Access to a container registry (ECR configured in values)

## Installation

```bash
# Install with custom values
helm install my-app ./appchart -f custom-values.yaml
```

The customer-values.yaml must be passed with the -f flag to avoid storing sensitive data in k8s manifests. See customization section

## Configuration

The following table lists the configurable parameters of the chart and their default values.

### Namespace Configuration
| Parameter | Description | Default |
|-----------|-------------|---------|
| `namespace.name` | Namespace for all resources | `app` |

### Secret Configuration
| Parameter | Description | Default |
|-----------|-------------|---------|
| `secret.name` | Name of the secret for image pulling | `app-secret` |

### Service Configuration
| Parameter | Description | Default |
|-----------|-------------|---------|
| `service.name` | Name of the backend service | `app-svc` |
| `service.port` | Service port | `8000` |
| `service.targetport` | Container target port | `8000` |

### Deployment Configuration
| Parameter | Description | Default |
|-----------|-------------|---------|
| `deployment.name` | Name of the deployment | `app-deployment` |
| `deployment.replicas` | Number of replicas | `3` |
| `deployment.container.name` | Container name | `backend` |
| `deployment.container.port` | Container port | `8000` |
| `deployment.container.limits.cpu` | CPU limit | `250m` |
| `deployment.container.limits.memory` | Memory limit | `512Mi` |
| `deployment.image.name` | Image name | `app/backend` |
| `deployment.image.tag` | Image tag | `1` |
| `deployment.image.pullPolicy` | Image pull policy | `IfNotPresent` |

### Database Configuration
| Parameter | Description | Default |
|-----------|-------------|---------|
| `sts.name` | Name of the StatefulSet | `app-db` |
| `sts.replicas` | Number of database replicas | `1` |
| `sts.container.name` | Database container name | `db` |
| `sts.container.port` | Database port | `5432` |
| `sts.container.limits.cpu` | CPU limit | `250m` |
| `sts.container.limits.memory` | Memory limit | `512Mi` |
| `db_service.name` | Name of the database service | `db-service` |

### ConfigMap Configuration
| Parameter | Description | Default |
|-----------|-------------|---------|
| `configmap.name` | Name of the ConfigMap | `app-configmap` |
| `configmap.data.db_host` | Database host | `db-service` |
| `configmap.data.db_port` | Database port | `5432` |
| `configmap.data.db_name` | Database name | `app` |

### Ingress Configuration
| Parameter | Description | Default |
|-----------|-------------|---------|
| `ingress.name` | Name of the Ingress | `app-ingress` |
| `ingress.classname` | Ingress class name | `nginx` |

## Architecture

The application consists of:

1. **Backend Service**: A scalable application deployment with health checks
2. **Database**: PostgreSQL database deployed as a StatefulSet
3. **Networking**: Services for internal communication and Ingress for external access
4. **Configuration**: ConfigMaps for application settings

## Features

- Database readiness check in init container
- Health probes for the backend service
- Configurable resource limits
- Internet-facing ALB ingress with health checks
- Scalable backend with configurable replicas

## Notes

- The backend service depends on the database being available
- The init container ensures the database is ready before starting the application
- Environment variables are configured through ConfigMap
- Image pull secrets must be configured for private registries

## Customization

Helm expects to get the following values in `custom-values.yaml`:

```yaml
dockerconfigjson: "YOUR_DOCKER_SECRET" # If testing locally with minikube, no needed with aws
deployment:
  account_id: "YOUR_AWS_ACCOUNT_ID"
db_cred:
  postgres_db: INITIAL_DB_NAME
  postgres_user: TEST_USER
  postgres_password: TEST_PASSWORD
```

Then install or upgrade with:

```bash
helm install my-app ./appchart -f custom-values.yaml
# or
helm upgrade my-app ./appchart -f custom-values.yaml
```
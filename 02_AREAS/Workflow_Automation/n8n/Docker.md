# Docker Primer for n8n

Docker is an open-source platform that automates the deployment, scaling, and management of applications using containerization. For n8n, Docker provides an isolated and consistent environment, making it easy to set up, run, and manage your n8n instance along with its dependencies.

## Why Use Docker for n8n?

*   **Isolation:** n8n runs in its own container, separate from your host system, preventing conflicts with other software.
*   **Portability:** The same Docker setup works consistently across different environments (development, staging, production).
*   **Easy Setup:** Quickly get n8n up and running with minimal configuration.
*   **Scalability:** Easily scale n8n by running multiple containers.
*   **Version Control:** Pin specific versions of n8n and its dependencies.

## Key Docker Concepts

*   **Image:** A lightweight, standalone, executable package that includes everything needed to run a piece of software, including the code, a runtime, libraries, environment variables, and config files. Think of it as a blueprint.
*   **Container:** A runnable instance of an image. You can create, start, stop, move, or delete a container.
*   **Dockerfile:** A text document that contains all the commands a user could call on the command line to assemble an image.
*   **Docker Compose:** A tool for defining and running multi-container Docker applications. It uses a YAML file to configure your application's services.

## Most Common Docker Commands

Here are some essential Docker commands you'll frequently use:

### 1. `docker run` - Run a container

This command creates and starts a new container from an image.

```bash
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
```

*   **Example (basic n8n run):**
    ```bash
    docker run -it --rm \
    -p 5678:5678 \
    -v ~/.n8n:/home/node/.n8n \
    --name n8n \
    n8n/n8n
    
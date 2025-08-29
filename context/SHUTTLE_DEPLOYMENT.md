# Shuttle Deployment Process

This document outlines the deployment process for a Shuttle application, based on an analysis of deployment logs.

## Overview

Shuttle automates the process of packaging and deploying applications by containerizing them using Docker. The process is optimized for speed and efficiency, particularly for Rust applications.

## Key Stages

1.  **Docker Build:**
    *   Shuttle uses a BuildKit builder to construct a Docker image from an auto-generated `Dockerfile`.
    *   The resulting image is pushed to a private Amazon ECR (Elastic Container Registry) with multiple tags (`latest`, a build-specific tag, and a deployment-specific tag).

2.  **Caching:**
    *   To accelerate builds, Shuttle uses the ECR registry to cache Docker layers. This is particularly effective for dependencies that do not change often.

3.  **Rust Project Optimization (Cargo Chef):**
    *   For Rust projects, Shuttle employs `cargo-chef` for dependency management. This is a multi-step process:
        1.  **Planner Stage:** `cargo chef prepare` is run to generate a `recipe.json` file, which lists all project dependencies.
        2.  **Builder Stage:** `cargo chef cook` uses the recipe to download and compile all dependencies into a separate Docker layer. This layer is highly cacheable.
        3.  **Application Code Compilation:** The application's own source code is then copied and compiled. Because the dependencies are already built, this step is very fast if only application code has changed.

4.  **Build & Runtime Hooks:**
    *   Shuttle allows for custom scripts to be run at different stages of the deployment:
        *   `shuttle_prebuild.sh`: Executed before the build process begins.
        *   `shuttle_postbuild.sh`: Executed after the build process completes.
        *   `shuttle_setup_container.sh`: Executed inside the final runtime container, useful for installing runtime-only dependencies (e.g., `libpq-dev`).

5.  **Asset Management:**
    *   Shuttle determines which static files and directories to include in the final image by reading a `Shuttle.toml` file in the project's root.
    *   An `assets` array within this file specifies glob patterns for files and directories to be copied into the `/app` directory of the final container.

6.  **Final Image:**
    *   The process results in a minimal, optimized container image.
    *   The compiled application binary is placed at `/usr/local/bin/runtime`.
    *   All specified assets are copied into the `/app` directory.

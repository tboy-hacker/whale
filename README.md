# Docker and Docker Compose Installation Script

This script automates the installation of Docker and Docker Compose on various Linux distributions including Ubuntu, Debian, CentOS, and Fedora.

## Features

- Detects the Linux distribution and installs the appropriate Docker packages.
- Installs Docker Compose.
- Adds the current user to the Docker group.

## Supported Distributions

- Ubuntu
- Debian
- CentOS
- Fedora

## Prerequisites

- The script must be run with root or sudo privileges.

## Usage

1. Save the script to a file, e.g., `install_docker.sh`.
2. Make the script executable:
    ```bash
    chmod +x install_docker.sh
    ```
3. Run the script:
    ```bash
    sudo ./install_docker.sh
    ```

After running the script, log out and log back in to apply the Docker group changes.

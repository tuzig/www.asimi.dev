# This template is customized by project-init ritual based on the project's language
# and tool set. 

PROJECT_NAME := `git config --get remote.origin.url | sed -E 's/.*[:\/]([^\/]+)\/([^\/]+)\.git$/\1\/\2/'`

list:
    @just --list

# Build the sandbox container
build-sandbox:
    podman machine init --disk-size 30 >/dev/null 2>&1 || true
    podman machine start >/dev/null 2>&1 || true
    podman rmi localhost/asimi/sandbox/{{PROJECT_NAME}}:latest 2>/dev/null || true
    podman build -t localhost/asimi/sandbox/{{PROJECT_NAME}}:latest -f .agents/sandbox/Dockerfile .

# Clean up the sandbox container
clean-sandbox:
    podman rmi localhost/asimi/sandbox/{{PROJECT_NAME}}:latest

# Install project dependencies (language-specific) — customize for your project
install:
    @echo "No external dependencies to install — Hugo themes are vendored."

# Run linter & formatter (language-specific) — customize for your project
lint:
    hugo --logLevel warn

# Run tests (language-specific) — customize for your project
test:
    bash tests/court-section.sh

# Start the program or server — customize for your project
run:
    hugo server --bind 0.0.0.0 --port 1313

# Build the project — customize for your project
build: install
    hugo --minify

# Clean build artifacts and caches — customize for your project
clean:
    rm -rf public resources

# Install system dependencies — customize for your project
bootstrap:
    #!/usr/bin/env bash
    set -euo pipefail
    if ! command -v hugo &>/dev/null; then
        HUGO_VERSION="0.153.4"
        ARCH=$(uname -m)
        case "$ARCH" in
            x86_64) ARCH="amd64" ;;
            aarch64|arm64) ARCH="arm64" ;;
            *) echo "Unsupported arch: $ARCH"; exit 1 ;;
        esac
        OS=$(uname -s | tr '[:upper:]' '[:lower:]')
        curl -fsSL "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_${OS}-${ARCH}.tar.gz" \
            | tar -xz -C /usr/local/bin hugo
    fi
    hugo version

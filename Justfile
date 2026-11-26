# This template is customized by project-init ritual based on the project's language
# and tool set. 
project_name := `user=$(id -un | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//'); url=$(git config --get remote.origin.url 2>/dev/null | sed -E 's/\.git$//; s/\/+$//'); [ -n "$url" ] || url=$PWD; repo=$(basename "$url" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//'); printf '%s/%s' "$user" "$repo"`

list:
    @just --list

# Build the sandbox container
build-sandbox:
    podman machine init --disk-size 30 >/dev/null 2>&1 || true
    podman machine start >/dev/null 2>&1 || true
    podman rmi localhost/asimi/sandbox/{{project_name}}:latest 2>/dev/null || true
    podman build -t localhost/asimi/sandbox/{{project_name}}:latest -f .agents/sandbox/Dockerfile .

# Clean up the sandbox container
clean-sandbox:
    podman rmi localhost/asimi/sandbox/{{project_name}}:latest

# Install project dependencies (language-specific) — customize for your project
install:
    @echo "No external dependencies to install — Hugo themes are vendored."

# Run linter & formatter (language-specific) — customize for your project
lint:
    hugo --logLevel warn

# Tests removed by the Great Tests Purge (Edict 860) — content is the product.
test:
    @echo "No tests — content-dependent suite removed (Great Tests Purge)."

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

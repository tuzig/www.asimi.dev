# Justfile for asimi.dev Hugo site

# List available commands
default:
    @just --list

# Install system dependencies (Hugo)
bootstrap:
    #!/usr/bin/env bash
    if ! command -v hugo &> /dev/null; then
        echo "Installing Hugo..."
        if command -v apt-get &> /dev/null; then
            apt-get update && apt-get install -y hugo
        elif command -v brew &> /dev/null; then
            brew install hugo
        else
            echo "Please install Hugo manually: https://gohugo.io/installation/"
            exit 1
        fi
    else
        echo "Hugo already installed: $(hugo version)"
    fi

# Install project dependencies (themes, etc.)
install:
    @echo "Hugo project initialized. Add themes to themes/ directory if needed."

# Start development server
dev:
    hugo server --buildDrafts --buildFuture

# Start development server (alias)
run: dev

# Build the site for production
build:
    hugo --minify

# Build without minification
build-dev:
    hugo

# Create new post
new-post name:
    hugo new content posts/{{name}}.md

# Create new content
new section name:
    hugo new content {{section}}/{{name}}.md

# Clean build artifacts
clean:
    rm -rf public/ resources/_gen/ .hugo_build.lock

# Validate site (check for errors)
check:
    hugo --printPathWarnings --printUnusedTemplates

# Build the development infrastructure
infrabuild:
    @mkdir -p infra
    @podman machine init --disk-size 30 2>/dev/null || true
    @podman machine start 2>/dev/null || true
    podman build -t asimi-dev:latest -f .asimi/Dockerfile .

# Clean up the development infrastructure
infraclean:
    # podman machine stop
    # podman machine rm
    podman system prune --all --volumes --force

# Run command in container
shell:
    podman run -it --rm -v $(pwd):/workspace -w /workspace asimi-dev:latest bash

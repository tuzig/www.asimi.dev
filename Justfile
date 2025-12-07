PROJECT_NAME := "tuzig-www.asimi.dev"

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

# Run tests (validate site)
test:
    hugo --printPathWarnings --printUnusedTemplates

# Lint/check the site
lint:
    hugo --printPathWarnings --printUnusedTemplates

# Create new post
new-post name:
    hugo new content blog/{{name}}.md

# Create new content
new section name:
    hugo new content {{section}}/{{name}}.md

# Clean build artifacts
clean:
    rm -rf public/ resources/_gen/ .hugo_build.lock

# Validate site (check for errors)
check:
    hugo --printPathWarnings --printUnusedTemplates

# Build the sandbox container
build-sandbox:
    podman machine init --disk-size 30 >/dev/null 2>&1 || true
    podman machine start >/dev/null 2>&1 || true
    podman build -t localhost/asimi-sandbox-{{PROJECT_NAME}}:latest -f .agents/sandbox/Dockerfile .

# Clean up the sandbox container
clean-sandbox:
    podman rmi localhost/asimi-sandbox-{{PROJECT_NAME}}:latest

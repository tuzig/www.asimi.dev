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
    # Hugo has no dependency-install step; themes are vendored in themes/
    @echo "No install step needed for Hugo projects"

# Run linter & formatter (language-specific) — customize for your project
lint:
    hugo --logLevel warn

# Run tests (language-specific) — customize for your project
test:
    hugo --logLevel error

# Start the program or server — customize for your project
run:
    hugo server -D --bind 0.0.0.0 --port 1313 --baseURL http://localhost:1313

# Build the project — customize for your project
build: install
    hugo --minify

# Clean build artifacts and caches — customize for your project
clean:
    rm -rf public resources

# Install system dependencies — customize for your project
bootstrap:
    @echo "Hugo is installed via the Dockerfile; no bootstrap step needed"

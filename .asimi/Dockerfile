# Development container for asimi.dev Hugo site
FROM debian:trixie-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    hugo \
    git \
    curl \
    ripgrep \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install just task runner
RUN curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /usr/local/bin

# Set up environment
ENV HUGO_ENV=development
ENV LANG=C.UTF-8

# Default command
CMD ["bash"]

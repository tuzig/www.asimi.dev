FROM docker.io/debian:trixie-slim

# Install common development tools + Hugo (extended)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ripgrep \
    just \
    ca-certificates \
    && curl -fsSL https://github.com/gohugoio/hugo/releases/download/v0.142.0/hugo_extended_0.142.0_linux-arm64.tar.gz \
       | tar -xz -C /usr/local/bin hugo \
    && rm -rf /var/lib/apt/lists/*

COPY Justfile .
# Runs as root inside the container — bootstrap must NOT use sudo
RUN just bootstrap
# Asimi runtime — appended to /etc/bash.bashrc so the command-wrapper protocol
# (__asimi_run) used by the podman runner is sourced by every interactive bash
# shell BEFORE /root/.bashrc, regardless of user customizations.
COPY .agents/sandbox/asimi_runtime.sh /tmp/asimi_runtime.sh
RUN cat /tmp/asimi_runtime.sh >> /etc/bash.bashrc && rm /tmp/asimi_runtime.sh

COPY .agents/sandbox/bashrc /root/.bashrc

# Default command: start shell (bashrc handles startup tasks)
CMD ["/bin/bash"]

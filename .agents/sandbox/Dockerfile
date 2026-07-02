FROM debian:trixie-slim

# Install common development tools and Hugo
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ripgrep \
    just \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && HUGO_VERSION="0.153.4" \
    && ARCH=$(uname -m) \
    && case "$ARCH" in \
        x86_64) ARCH="amd64" ;; \
        aarch64|arm64) ARCH="arm64" ;; \
        *) echo "Unsupported arch: $ARCH"; exit 1 ;; \
    esac \
    && curl -fsSL "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-${ARCH}.tar.gz" \
       | tar -xz -C /usr/local/bin hugo

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

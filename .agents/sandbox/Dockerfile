# Sandbox container for asimi.dev Hugo site
FROM ghcr.io/hugomods/hugo:debian

# Install common development tools
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ripgrep \
    && rm -rf /var/lib/apt/lists/*

# Install just
RUN curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /usr/local/bin

COPY Justfile .
RUN just bootstrap
COPY .agents/sandbox/bashrc /root/.bashrc
CMD ["just install && /bin/bash"]

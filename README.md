# asimi.dev

This is the Hugo-based website for asimi.dev.

## Quick Start

```bash
# Install dependencies
just bootstrap

# Start development server
just dev

# Create new post
just new-post my-first-post

# Build for production
just build
```

See `AGENTS.md` for detailed development guide and `just --list` for all available commands.

## Prerequisites

- Hugo (Extended version recommended) - installed via `just bootstrap`
- [Just](https://github.com/casey/just) task runner (optional but recommended)

## Development

### Using Just (recommended)

```bash
just dev              # Start dev server with drafts
just build            # Build production site
just new-post <name>  # Create new post
just clean            # Clean build artifacts
```

### Using Hugo directly

```bash
hugo server --buildDrafts  # Start dev server
hugo --minify              # Build production site
```

The dev server will be available at http://localhost:1313/

## Project Structure

- `content/` - Markdown content files
- `layouts/` - HTML templates
- `static/` - Static assets (images, CSS, JS)
- `assets/` - Assets processed by Hugo Pipes
- `themes/` - Hugo themes
- `hugo.toml` - Site configuration

## Container Development

Build and use the development container:

```bash
just infrabuild  # Build container image
just shell       # Run interactive shell in container
```

## Next Steps

1. Install or create a theme in `themes/`
2. Add content with `just new-post <name>`
3. Customize layouts and styling
4. Configure `hugo.toml` for your needs

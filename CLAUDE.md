# Asimi.dev Development Guide

## Languages
- Go templates (Hugo templating)
- TOML (configuration)
- Markdown (content)
- HTML/CSS (layouts and styling)

## Build Commands
- `just install` - Install project dependencies
- `just build` - Build optimized production site
- `just build-dev` - Build without minification
- `just clean` - Remove build artifacts

## Run Commands
- `just run` - Start dev server at http://localhost:1313
- `just dev` - Start dev server with drafts and future posts

## Test Commands
- `just test` - Validate site (check for errors)
- `just lint` - Run linting/validation checks

## Content Commands
- `just new-post my-post` - Create new blog post
- `just new section name` - Create content in section

## Project Structure
- `content/` - Markdown content files
- `layouts/` - HTML templates (overrides theme)
- `static/` - Static assets (copied as-is to public/)
- `assets/` - Assets processed by Hugo Pipes
- `themes/` - Hugo themes
- `hugo.toml` - Hugo configuration

## Code Style
- **Configuration**: Use TOML format (hugo.toml)
- **Front matter**: Use TOML format (+++...+++)
- **Templates**: Follow Go template syntax
- **Partials**: Place in `layouts/partials/`
- **Shortcodes**: Place in `layouts/shortcodes/`
- **Naming**: Use kebab-case for content files

## Conventions
- Draft content: Set `draft = true` in front matter
- Images: Store in `static/images/` or `assets/images/`
- CSS/JS: Use Hugo Pipes in `assets/` for processing
- Blog posts: Create in `content/blog/`

## Container Configuration
Configure the sandbox container image in `.agents/asimi.conf` under `[run_in_shell]` section.

## Sandbox Development Notes
- The sandbox container runs Debian Trixie with Hugo extended installed at `/usr/local/bin/hugo`.
- `just run` starts the Hugo dev server on port 1313, bound to `0.0.0.0` so it is reachable from the host.
- `just build` produces a minified production build in `public/`.
- `just clean` removes `public/` and `resources/` directories.
- `just lint` runs Hugo with `--logLevel warn` to surface template warnings.
- `just test` runs Hugo with `--logLevel error` to catch build-breaking issues.
- No external dependencies need installation — Hugo themes are vendored under `themes/`.

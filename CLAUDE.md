# Asimi.dev Development Guide

## Languages
- Go templates (Hugo templating)
- TOML (configuration)
- Markdown (content)
- HTML/CSS (layouts and styling)

## Build Commands
- `just install` - No-op; Hugo themes are vendored under `themes/`
- `just build` - Build optimized production site (`hugo --minify`)
- `just clean` - Remove build artifacts (`public/` and `resources/`)

## Run Commands
- `just run` - Start dev server at http://localhost:1313 (bound to 0.0.0.0)

## Test Commands
- `just test` - Run `tests/court-section.sh` to validate Court section rendering
- `just lint` - Run Hugo with `--logLevel warn` to surface template warnings

## Project Structure
- `content/` - Markdown content files
- `layouts/` - HTML templates (overrides theme)
- `static/` - Static assets (copied as-is to public/)
- `assets/` - Assets processed by Hugo Pipes
- `themes/` - Hugo themes (vendored, no install needed)
- `hugo.toml` - Hugo configuration
- `tests/` - Shell-based test scripts

## Code Style
- **Content**: Keep content in markdown format NEVER in html
- **Configuration**: Use TOML format (hugo.toml)
- **Front matter**: Use YAML format (---...---) for blog posts
- **Templates**: Follow Go template syntax
- **Partials**: Place in `layouts/partials/`
- **Shortcodes**: Place in `layouts/shortcodes/`
- **Naming**: Use kebab-case for content files

## Conventions
- Draft content: Set `draft = true` in front matter
- Images: Store in `static/images/` or `assets/images/`
- CSS/JS: Use Hugo Pipes in `assets/` for processing
- Blog posts: Create in `content/blog/`

## Sandbox Development Notes
- The sandbox container runs Debian Trixie with Hugo extended installed at `/usr/local/bin/hugo`.
- `just run` starts the Hugo dev server on port 1313, bound to `0.0.0.0` so it is reachable from the host.
- `just build` produces a minified production build in `public/`.
- `just clean` removes `public/` and `resources/` directories.
- `just lint` runs Hugo with `--logLevel warn` to surface template warnings.
- `just test` runs `tests/court-section.sh` which builds the site and verifies Court section content.
- No external dependencies need installation — Hugo themes are vendored under `themes/`.

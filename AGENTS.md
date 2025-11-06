# Asimi.dev Development Guide

## Build Commands
- `hugo` - Build static site to `public/`
- `hugo --minify` - Build optimized production site
- `hugo server` - Start dev server at http://localhost:1313
- `hugo server --buildDrafts` - Include draft content in dev server

## Content Commands
- `hugo new content posts/my-post.md` - Create new post
- `hugo new content <section>/<filename>.md` - Create content in section

## Project Structure
- `content/` - Markdown content files
- `layouts/` - HTML templates (overrides theme)
- `static/` - Static assets (copied as-is to public/)
- `assets/` - Assets processed by Hugo Pipes
- `themes/` - Hugo themes

## Code Style
- Use TOML for configuration (hugo.toml)
- Front matter: Use TOML format (+++...+++)
- Templates: Follow Go template syntax
- Partials: Place in `layouts/partials/`
- Shortcodes: Place in `layouts/shortcodes/`

## Conventions
- Draft content: Set `draft = true` in front matter
- Images: Store in `static/images/` or `assets/images/`
- CSS/JS: Use Hugo Pipes in `assets/` for processing

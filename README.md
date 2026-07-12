# asimi.dev

The official website for [Asimi CLI](https://github.com/afittestide/asimi-cli) — an imperial court that turns users into rulers of their code.

## Development

This site is built with [Hugo](https://gohugo.io/).

### Prerequisites

- Hugo (extended version recommended)

### Local Development

```bash
# Start the development server
hugo server -D

# Build for production
hugo
```

### Structure

```
.
├── content/
│   └── blog/           # Blog posts
├── layouts/
│   ├── index.html      # Homepage
│   ├── 404.html        # 404 page
│   ├── blog/
│   │   ├── list.html   # Blog listing
│   │   └── single.html # Blog post
│   └── _default/
│       └── single.html # Default single page
├── static/             # Static assets
└── hugo.toml           # Hugo configuration
```

### Adding Blog Posts

Create a new markdown file in `content/blog/`:

```bash
hugo new blog/my-new-post.md
```

Or manually create a file with frontmatter:

```markdown
---
title: "My Post Title"
date: 2025-01-15
description: "A brief description"
tags: ["tag1", "tag2"]
---

Your content here...
```

## Deployment

The site is deployed automatically via Netlify when changes are pushed to the main branch.

## License

MIT

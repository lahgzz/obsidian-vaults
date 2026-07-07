# on-obsidian-vaults

This vault exists as a dedicated sandbox for experimenting with and refining a full [Quartz](https://quartz.jzhao.xyz/) publishing setup integrated directly into an [Obsidian](https://obsidian.md/) vault. Rather than treating the build tooling as an external concern, the goal here is to co-locate everything — notes, configuration, plugins, and deployment — in a single repository that can be forked and adapted for other vaults.

The core questions being explored:

- Which Quartz plugins earn their place in a minimal, fast, good-looking site?
- How should the config and layout be structured to be reusable across different vaults?
- What does a clean, predictable workflow look like — from writing in Obsidian to previewing locally to deploying on GitHub Pages?
- Where is the right boundary between what gets published (in `content/`) and what stays private?

This is not a production site. It's the workshop where the production setup gets built.

## Local development

**Prerequisites:** [Docker](https://docs.docker.com/get-docker/) and [just](https://github.com/casey/just).

```sh
just build    # build the Docker image
just serve    # build + serve at http://localhost:8080
just stop     # stop the container
just logs     # tail container logs
just reset    # stop, rebuild, restart
just shell    # open a shell in the running container
```

The Docker image clones [Quartz v5](https://github.com/jackyzha0/quartz), installs dependencies, copies your `content/` and `quartz.config.yaml`, then serves the built site. Any change to content or config requires a rebuild (`just reset`).

## Deployment

Pushes to `main` that modify `content/` or `.github/workflows/deploy.yml` trigger a [GitHub Actions](https://github.com/features/actions) workflow that builds and deploys the site to GitHub Pages.

The workflow clones Quartz v5, installs dependencies, builds the site, and publishes the `public/` directory. Dependency and plugin caches are persisted across runs via `actions/cache`.

**One-time setup:** Enable GitHub Pages in your repo settings (Settings → Pages → Source: **GitHub Actions**).

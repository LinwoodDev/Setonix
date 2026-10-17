# Setonix documentation

The public website and feature documentation use Astro, Starlight, and the Linwood style plugin. Source content lives in `src/content/docs/`; the landing page is `src/content/docs/index.mdx` and the v1 guides are in `src/content/docs/docs/v1/`.

## Develop and build

Run these commands in `docs/` using the Node and pnpm versions supported by `package.json`:

```sh
pnpm install
pnpm dev
pnpm build
pnpm preview
```

`pnpm build` runs Astro diagnostics and builds the static site into `dist/`, including Pagefind search and the documentation service worker. `pnpm preview` serves that build locally.

## Update the docs

- Add a Markdown or MDX page with `title` and `description` frontmatter.
- Register new guides in the sidebar in `astro.config.mjs` and link related pages.
- Keep user-facing behavior aligned with the Flutter UI, API models, server commands, and Luau definitions. Explain sandbox behavior, mode rules, and platform limitations explicitly.
- Store landing-page screenshots in `src/assets/img/homepage/`. The shared `Landing.astro` layout and `LandingFeature.astro` component from `@linwooddev/starlight-style` provide the landing styles, alternating responsive image/copy sections, and optional theme variants. Keep only site colors in `src/styles/custom.scss`.
- Check `pnpm build`, local links, and the landing page in light/dark themes at desktop and mobile widths before sharing changes.

`downloads/selfhosting.md` describes hosting the game app; it is separate from deploying this documentation site.

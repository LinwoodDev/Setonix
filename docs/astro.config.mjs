import { defineConfig } from "astro/config";
import { unified } from "@astrojs/markdown-remark";
import starlight from "@astrojs/starlight";
import linwoodStarlight from "@linwooddev/starlight-style";
import react from "@astrojs/react";
import remarkHeadingID from "remark-heading-id";
import remarkGemoji from "remark-gemoji";
import AstroPWA from "@vite-pwa/astro";
import manifest from "./webmanifest.json";

// https://astro.build/config
export default defineConfig({
  site: "https://setonix.world",
  markdown: {
    processor: unified({ remarkPlugins: [remarkHeadingID, remarkGemoji] }),
  },
  integrations: [
    starlight({
      plugins: [linwoodStarlight()],
      title: "Linwood Setonix",
      customCss: ["./src/styles/custom.scss"],
      social: [
        {
          icon: "mastodon",
          label: "Mastodon",
          href: "https://floss.social/@linwood",
        },
        { icon: "matrix", label: "Matrix", href: "https://linwood.dev/matrix" },
        {
          icon: "discord",
          label: "Discord",
          href: "https://linwood.dev/discord",
        },
        {
          icon: "blueSky",
          label: "Bluesky",
          href: "https://bsky.app/profile/linwood.dev",
        },
        {
          icon: "github",
          label: "GitHub",
          href: "https://github.com/LinwoodDev/Setonix",
        },
      ],
      components: {
        Head: "./src/components/Head.astro",
        Footer: "./src/components/Footer.astro",
      },
      logo: {
        src: "./public/img/logo.svg",
      },
      favicon: "./img/docs.svg",
      sidebar: [
        {
          label: "Guides",
          items: [
            {
              label: "Introduction",
              link: "/docs/v1/intro/"
            },
            {
              label: "Playing",
              items: [
                {
                  label: "Games and templates",
                  link: "/docs/v1/worlds/"
                },
                {
                  label: "Playing at the table",
                  link: "/docs/v1/playing/"
                },
                {
                  label: "Tables and waypoints",
                  link: "/docs/v1/tables/"
                },
                {
                  label: "Teams and visibility",
                  link: "/docs/v1/teams/"
                },
                {
                  label: "Notes, chat, and dialogs",
                  link: "/docs/v1/notes/"
                },
                {
                  label: "Chess",
                  link: "/docs/v1/chess/"
                },
                {
                  label: "Blackjack",
                  link: "/docs/v1/blackjack/"
                }
              ]
            },
            {
              label: "Multiplayer",
              items: [
                {
                  label: "Joining and hosting",
                  link: "/docs/v1/multiplayer/"
                },
                {
                  label: "Accounts and backups",
                  link: "/docs/v1/accounts/"
                }
              ]
            },
            {
              label: "Settings",
              link: "/docs/v1/settings/"
            },
            {
              label: "Creating packs",
              items: [
                {
                  label: "Overview",
                  link: "/docs/v1/packs/overview/"
                },
                {
                  label: "Pack editor",
                  link: "/docs/v1/packs/editor/"
                },
                {
                  label: "Metadata",
                  link: "/docs/v1/packs/meta/"
                },
                {
                  label: "Figures and textures",
                  link: "/docs/v1/packs/figures/"
                },
                {
                  label: "Decks",
                  link: "/docs/v1/packs/decks/"
                },
                {
                  label: "Boards and backgrounds",
                  link: "/docs/v1/packs/boards/"
                },
                {
                  label: "Game modes and scripts",
                  link: "/docs/v1/packs/modes/"
                },
                {
                  label: "Translations",
                  link: "/docs/v1/packs/translations/"
                }
              ]
            },
            {
              label: "Luau scripting API",
              link: "/docs/v1/scripting/luau/"
            },
            {
              label: "Dedicated server",
              items: [
                {
                  label: "Setup",
                  link: "/docs/v1/server/"
                },
                {
                  label: "Configuration",
                  link: "/docs/v1/server/configuration/"
                },
                {
                  label: "Console commands",
                  link: "/docs/v1/server/commands/"
                },
                {
                  label: "Roles and permissions",
                  link: "/docs/v1/server/permissions/"
                },
                {
                  label: "Server lists and thumbnails",
                  link: "/docs/v1/server/directory/"
                }
              ]
            },
            {
              label: "Troubleshooting",
              link: "/docs/v1/troubleshooting/"
            }
          ]
        },
        {
          label: "Downloads",
          link: "/downloads/",
        },
        {
          label: "Community",
          items: [
            {
              label: "Home",
              link: "/community/",
            },
            {
              label: "Branding",
              link: "/community/branding/",
            },
            {
              label: "Changelog",
              link: "/changelog/",
            },
            {
              label: "Contributing",
              link: "/community/contributing/",
            },
            {
              label: "Code of conduct",
              link: "/community/code-of-conduct/",
            },
            {
              label: "FAQ",
              link: "/community/faq/",
            },
            {
              label: "Versions",
              link: "/community/versions/",
            },
            {
              label: "Nightly builds",
              link: "/community/nightly/",
            },
            {
              label: "Privacy policy",
              link: "/privacypolicy/",
            },
          ],
        },
      ],
    }),
    AstroPWA({
      workbox: {
        skipWaiting: true,
        clientsClaim: true,
        navigateFallback: "/404.html",
        ignoreURLParametersMatching: [/./],
        globPatterns: [
          "**/*.{html,js,css,png,svg,json,ttf,pf_fragment,pf_index,pf_meta,pagefind,wasm}",
        ],
      },
      experimental: {
        directoryAndTrailingSlashHandler: true,
      },
      registerType: "autoUpdate",
      manifest,
    }),
    react(),
  ],
});

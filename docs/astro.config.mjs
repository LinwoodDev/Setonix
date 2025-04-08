import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";
import react from "@astrojs/react";
import remarkHeadingID from "remark-heading-id";
import remarkGemoji from "remark-gemoji";
import AstroPWA from "@vite-pwa/astro";
import manifest from "./webmanifest.json";

// https://astro.build/config
export default defineConfig({
  site: "https://setonix.world",
  markdown: {
    remarkPlugins: [remarkHeadingID, remarkGemoji],
  },
  integrations: [
    starlight({
      title: "Linwood Setonix",
      customCss: ["./src/styles/custom.css"],
      social: [
        {icon: "mastodon", label: "Mastodon", href: "https://floss.social/@linwood"},
        {icon: "matrix", label: "Matrix", href: "https://linwood.dev/matrix"},
        {icon: "discord", label: "Discord", href: "https://linwood.dev/discord"},
        {icon: "blueSky", label: "Bluesky", href: "https://bsky.app/profile/linwood.dev"},
        {icon: "github", label: "GitHub", href: "https://github.com/LinwoodDev/Butterfly"},
      ],
      components: {
        Head: "./src/components/Head.astro",
        Footer: "./src/components/Footer.astro",
        ContentPanel: "./src/components/ContentPanel.astro",
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
              link: "/docs/v1/intro",
            },
            {
              label: "Packs",
              items: [
                {
                  label: "Overview",
                  link: "/docs/v1/packs/overview",
                },
                {
                  label: "Metadata",
                  link: "/docs/v1/packs/meta",
                },
              ],
            },
            {
              label: "Server",
              link: "/docs/v1/server",
            },
          ],
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
        navigateFallback: "/404",
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

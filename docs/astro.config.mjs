import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";
import react from "@astrojs/react";
import remarkHeadingID from "remark-heading-id";
import remarkGemoji from "remark-gemoji";

// https://astro.build/config
export default defineConfig({
  site: "https://quokka.linwood.dev",
  markdown: {
    remarkPlugins: [remarkHeadingID, remarkGemoji],
  },
  integrations: [
    starlight({
      title: "Linwood Quokka",
      customCss: ["./src/styles/custom.css"],
      social: {
        github: "https://github.com/withastro/starlight",
      },
      social: {
        mastodon: "https://floss.social/@linwood",
        matrix: "https://linwood.dev/matrix",
        discord: "https://linwood.dev/discord",
        github: "https://github.com/LinwoodDev/Quokka",
      },
      logo: {
        src: "./public/img/logo.svg",
      },
      favicon: "./img/docs.svg",
      components: {
        SocialIcons: "./src/components/CustomSocialIcons.astro",
        Head: "./src/components/Head.astro",
        Footer: "./src/components/Footer.astro",
        ContentPanel: "./src/components/ContentPanel.astro",
      },
      sidebar: [
        {
          label: "Guides",
          items: [
            {
              label: "Introduction",
              link: "/docs/v1/intro",
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
              link: "/community/changelog/",
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
    react(),
  ],
});

// @ts-check
import { defineConfig, envField } from "astro/config";

import node from "@astrojs/node";

// https://astro.build/config
export default defineConfig({
  output: "server",
  prefetch: {
    defaultStrategy: "viewport",
  },

  env: {
    schema: {
      REMOTE_URLS: envField.string({
        context: "server",
        access: "secret",
        optional: true,
      }),
      USE_REMOTE_URLS_STATUS: envField.boolean({
        context: "server",
        access: "secret",
        default: true,
      }),
    },
  },

  adapter: node({
    mode: "standalone",
  }),
});

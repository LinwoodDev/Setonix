import { defineCollection } from "astro:content";
import { i18nLoader } from "@astrojs/starlight/loaders";
import { i18nSchema } from "@astrojs/starlight/schema";
import { collections as styleCollections } from "@linwooddev/starlight-style/content";

export const collections = {
  ...styleCollections,
  i18n: defineCollection({ loader: i18nLoader(), schema: i18nSchema() }),
};

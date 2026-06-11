import NodeCache from "@cacheable/node-cache";
import { buildServerURL, type Server } from "./utils";
import { getRemoteServerStatus } from "./list";
import { USE_REMOTE_URLS_STATUS } from "astro:env/server";

const cache = new NodeCache({ stdTTL: 60 * 10 });
const thumbnailCache = new NodeCache<ServerThumbnail>({ stdTTL: 60 * 10 });
const failedTTL = 60 * 5; // 5 minutes for failed requests
const maxThumbnailSize = 512 * 1024;
const allowedThumbnailContentTypes = new Set([
  "image/png",
  "image/jpeg",
  "image/webp",
]);

export type ServerStatus = {
  description: string;
  hasThumbnail?: boolean;
  maxPlayers?: number;
  currentPlayers: number;
  packsSignature: Record<string, unknown>;
};

export type ServerThumbnail = {
  body: Buffer;
  contentType: string;
};

export async function fetchServerStatus(
  server: Server,
): Promise<ServerStatus | null> {
  if (server.remote && USE_REMOTE_URLS_STATUS) {
    return getRemoteServerStatus(server);
  }
  const cacheKey = `server-status:${server.address}`;
  const cached = cache.get(cacheKey);
  if (cached) {
    return Promise.resolve(cached as ServerStatus);
  }
  const url = buildServerURL(server);
  const response = (await fetch(url, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
      "X-Setonix-Method": "info",
    },
  })
    .then((res) => {
      if (!res.ok) {
        throw new Error(
          `Server ${server.address} returned status ${res.status}`
        );
      }
      return res.json();
    })
    .catch((error) => {
      console.error(
        `Error fetching status for server ${server.address}:`,
        error
      );
      return null;
    })) as ServerStatus | null;
  cache.set(cacheKey, response, response ? undefined : failedTTL);
  if (!response) {
    console.warn(`Invalid response from server ${server.address}:`, response);
    return null;
  }
  return response;
}

export async function fetchServerThumbnail(
  server: Server,
): Promise<ServerThumbnail | null> {
  const cacheKey = `server-thumbnail:${server.address}`;
  const cached = thumbnailCache.get(cacheKey);
  if (cached) return cached;
  const url = buildServerURL(server);
  const response = await fetch(url, {
    method: "GET",
    headers: {
      "X-Setonix-Method": "thumbnail",
    },
  }).catch((error) => {
    console.error(
      `Error fetching thumbnail for server ${server.address}:`,
      error,
    );
    return null;
  });
  if (!response || !response.ok) return null;
  const contentType = response.headers.get("Content-Type")?.split(";")[0];
  if (!contentType || !allowedThumbnailContentTypes.has(contentType)) {
    return null;
  }
  const contentLength = Number(response.headers.get("Content-Length") || 0);
  if (contentLength > maxThumbnailSize) return null;
  const buffer = Buffer.from(await response.arrayBuffer());
  if (buffer.length > maxThumbnailSize) return null;
  const thumbnail = { body: buffer, contentType };
  thumbnailCache.set(cacheKey, thumbnail);
  return thumbnail;
}

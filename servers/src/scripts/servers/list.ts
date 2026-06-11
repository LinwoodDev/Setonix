import { NodeCache } from "@cacheable/node-cache";
import type { Server } from "./utils";
import { REMOTE_URLS } from "astro:env/server";
import type { ServerStatus } from "./info";
import localServers from "../../data/servers.json";

// Cache with 10 minutes TTL
const cache = new NodeCache<Server[]>({ stdTTL: 60 * 10 });

export async function getRemoteServerStatus(server: Server) {
  return ((server as any)["status"] as ServerStatus) || null;
}

async function fetchRemoteServers(url: string): Promise<Server[]> {
  const cacheKey = `servers:${url}`;
  const cached = cache.get(cacheKey);
  if (cached) return cached;

  const res = await fetch(url);
  console.log(`Fetching remote servers from ${url}`);
  if (!res.ok) {
    console.warn(`Fetch from ${url} failed: ${res.status}`);
    return [];
  }

  const data = await res.json();
  if (!("servers" in data)) {
    console.warn(`Invalid data format from ${url}:`, data);
    return [];
  }

  const servers = data["servers"].map((e: any) => ({
    remote: true,
    ...e,
  })) as Server[];
  cache.set(cacheKey, servers);
  return servers;
}

export async function loadServers(remoteUrls: string[] = []): Promise<Server[]> {
  const remoteLists = await Promise.all(remoteUrls.map(fetchRemoteServers));

  return [...localServers, ...remoteLists.flat()];
}

export async function loadServersFromConfig() {
  const remotes = REMOTE_URLS?.split(",");
  return await loadServers(remotes?.filter((url) => url.trim() !== "") || []);
}

import {NodeCache} from '@cacheable/node-cache';
import { promises as fs } from 'fs';
import type { Server } from './utils';
import { REMOTE_URLS } from "astro:env/server";

// Cache with 5 minutes TTL
const cache = new NodeCache({ stdTTL: 60 * 10 });
// Cache for local servers list
let localCache: Server[] | null = null;

/**
 * Loads the local servers.json and merges it with all remote lists.
 */
 export async function loadServers(
   localPath: string,
   remoteUrls: string[] = []
 ): Promise<Server[]> {
  if (!localCache) {
    const localData = await fs.readFile(localPath, 'utf-8');
    localCache = JSON.parse(localData);
  }
  const local = localCache!;

   async function fetchRemote(url: string): Promise<Server[]> {
    const cacheKey = `servers:${url}`;
    const cached = cache.get<Server[]>(cacheKey);
    if (cached) return cached;

    const res = await fetch(url);
    console.log(`Fetching remote servers from ${url}`);
    if (!res.ok) {
      console.warn(`Fetch from ${url} failed: ${res.status}`);
      return [];
    }

    const data = await res.json();
    if (!('servers' in data)) {
      console.warn(`Invalid data format from ${url}:`, data);
      return [];
    }
    const servers = data['servers'] as Server[];
    cache.set(cacheKey, servers);
    return servers;
  }

  const remoteLists = await Promise.all(remoteUrls.map(fetchRemote));

  return [...local, ...remoteLists.flat()];
}

export async function loadServersFromConfig() {
  const localPath = 'src/data/servers.json';
  const remotes = REMOTE_URLS?.split(',');
  return await loadServers(
    localPath,
    remotes?.filter(url => url.trim() !== '') || []
  );
}

import NodeCache from "@cacheable/node-cache";
import { buildServerHttpUrl, type Server } from "./utils";

const cache = new NodeCache({ stdTTL: 300 });

export type ServerStatus = {
  description: string;
  maxPlayers?: number;
  currentPlayers: number;
  packsSignature: Record<string, unknown>;
}

export async function fetchServerStatus(server: Server) : Promise<ServerStatus | null> {
  const cacheKey = `server-status:${server.address}`;
  const cached = cache.get(cacheKey);
  if (cached) {
    return Promise.resolve(cached as ServerStatus);
  }
  const url = buildServerHttpUrl(server);
  const response = await fetch(url, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
      "X-Setonix-Method": "info"
    },
  })
    .then((res) => {
      if (!res.ok) {
        throw new Error(`Server ${server.address} returned status ${res.status}`);
      }
      return res.json();
    })
    .catch((error) => {
      console.error(`Error fetching status for server ${server.address}:`, error);
      return null;
    }) as ServerStatus | null;
  if (!response) {
    console.warn(`Invalid response from server ${server.address}:`, response);
    return null;
  }
  cache.set(cacheKey, response);
  return response;
}

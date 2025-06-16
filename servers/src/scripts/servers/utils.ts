import { z } from "astro:content";

export const ServerObject = z.object({
  address: z.string().url(),
  secure: z.boolean().optional(),
  highlighted: z.boolean().optional(),
});

export type Server = z.infer<typeof ServerObject>;

export function buildServerURL(server: Server, webSocket?: boolean): string {
  const protocol = (webSocket ? "ws": "http") + (server.secure ? "s" : "");
  const [hostPort, ...segments] = server.address.split("/");
  const path = segments.length ? `/${segments.join("/")}` : "";
  const hostWithPort = hostPort.includes(":") ? hostPort : `${hostPort}:28006`;
  return `${protocol}://${hostWithPort}${path}`;
}

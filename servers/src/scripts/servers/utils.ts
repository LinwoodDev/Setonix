import { z } from 'astro/zod'

const ThumbnailPath = z.union([
  z.url(),
  z.string().regex(/^\/thumbnails\/.+/, "Expected a /thumbnails/ asset path"),
]);

export const ServerObject = z.object({
  address: z.url(),
  thumbnail: ThumbnailPath.optional(),
  secure: z.boolean().optional(),
  highlighted: z.boolean().optional(),
  remote: z.boolean().optional(),
});

export type Server = z.infer<typeof ServerObject>;

export function buildServerURL(server: Server, webSocket?: boolean): string {
  const isSecure = server.secure !== false;
  const protocol = (webSocket ? "ws": "http") + (isSecure ? "s" : "");
  const [hostPort, ...segments] = server.address.split("/");
  const path = segments.length ? `/${segments.join("/")}` : "";
  const hostWithPort = hostPort.includes(":") ? hostPort : `${hostPort}:28006`;
  return `${protocol}://${hostWithPort}${path}`;
}

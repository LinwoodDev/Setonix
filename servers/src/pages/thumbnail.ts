import type { APIRoute } from "astro";
import { fetchServerThumbnail } from "../scripts/servers/info";
import { loadServersFromConfig } from "../scripts/servers/list";

export const GET: APIRoute = async ({ url }) => {
  const address = url.searchParams.get("address");
  const secure = url.searchParams.get("secure") !== "false";
  if (!address) {
    return new Response(null, { status: 400 });
  }
  const servers = await loadServersFromConfig();
  const server = servers.find(
    (server) => server.address === address && (server.secure !== false) === secure,
  );
  if (!server) {
    return new Response(null, { status: 404 });
  }
  const thumbnail = await fetchServerThumbnail(server);
  if (!thumbnail) {
    return new Response(null, { status: 404 });
  }
  return new Response(thumbnail.body, {
    status: 200,
    headers: {
      "Content-Type": thumbnail.contentType,
      "Content-Length": thumbnail.body.length.toString(),
      "Cache-Control": "public, max-age=600",
    },
  });
};

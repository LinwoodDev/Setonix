import type { APIRoute } from "astro";
import { loadServersFromConfig } from "../scripts/servers/list";

export async function GET() {
  const servers = await loadServersFromConfig();
  return new Response(JSON.stringify({ servers }), {
    status: 200,
    headers: {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*",
    },
  });
}

export const OPTIONS: APIRoute = async () => {
  return new Response(null, {
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET",
      "Access-Control-Allow-Headers": "Content-Type",
      "Access-Control-Max-Age": "21600", // 6 h cache
    },
  });
};

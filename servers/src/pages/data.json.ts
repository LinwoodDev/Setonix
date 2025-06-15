import type { APIRoute } from 'astro';
import { loadServersFromConfig } from '../scripts/servers/list';

export async function GET() {
  const servers = await loadServersFromConfig();
  return new Response(JSON.stringify(servers), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  });
};
const CORS_HEADERS = {
  "Access-Control-Allow-Origin": "*",         // or your specific frontend origin
  "Access-Control-Allow-Methods": "GET,POST,OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type"
};

// src/index.js
export default {
  async fetch(request, env) {
    if (request.method === "OPTIONS") {
      return new Response(null, {
        status: 204,        // No Content
        headers: CORS_HEADERS
      });
    }
    const url = new URL(request.url);
    if (request.method === 'GET' && url.pathname === '/counts') {
      // List all keys under a namespace prefix?
      const list = await env.DOWNLOAD_COUNTS.list();
      const result = {};
      await Promise.all(
        list.keys.map(async ({ name }) => {
          result[name] = parseInt(await env.DOWNLOAD_COUNTS.get(name)) || 0;
        })
      );
      return new Response(JSON.stringify(result), { headers: { 'Content-Type': 'application/json', ...CORS_HEADERS } });
    }

    if (request.method === 'GET' && url.pathname === '/count') {
      const name = url.searchParams.get('name');
      if (!name) {
        return new Response(JSON.stringify({ error: 'Missing name parameter' }), { status: 400, headers: { 'Content-Type': 'application/json', ...CORS_HEADERS } });
      }
      let count = 0;
      try {
        const raw = await env.DOWNLOAD_COUNTS.get(name);
        count = raw !== null ? parseInt(raw) : 0;
        if (isNaN(count)) count = 0;
      } catch (e) {
        count = 0;
      }
      return new Response(JSON.stringify({ name, count }), { headers: { 'Content-Type': 'application/json', ...CORS_HEADERS } });
    }

    if (request.method === 'POST' && url.pathname === '/increment') {
      const { name } = await request.json();
      // Atomically increment
      await env.DOWNLOAD_COUNTS.put(name, (BigInt(await env.DOWNLOAD_COUNTS.get(name) || 0) + 1n).toString());
      const newCount = await env.DOWNLOAD_COUNTS.get(name);
      return new Response(JSON.stringify({ name, count: parseInt(newCount) }), { headers: { 'Content-Type': 'application/json', ...CORS_HEADERS } });
    }

    return new Response('Not found', { status: 404, headers: { ...CORS_HEADERS } });
  }
};

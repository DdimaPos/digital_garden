#!/bin/sh
deno run --allow-read=. --allow-write=html\
  https://deno.land/x/macana@v0.2.0/cli.ts\
  --shortest-path-when-possible\
  --out html \
  --name "Digital Garden" \
  --copyright "© `date +%Y` Programming Cave"\
  src/


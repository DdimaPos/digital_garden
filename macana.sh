#!/bin/sh
deno run --allow-read=. --allow-write=html \
  https://deno.land/x/macana@v0.2.0/cli.ts \
  --shortest-path-when-possible \
  --markdown-frontmatter \
  --out html \
  --name "Digital Garden" \
  --copyright "© `date +%Y` Programming Cave" \
  src/

# --markdown-downlevel-headings \
# --base-url "http://localhost:8080/notes/" \ <-- the actual url that the website will have


// Regenerates catalog.json from packs/. Run: node gen-catalog.mjs
import { readdirSync, readFileSync, statSync, writeFileSync } from "node:fs";
import { join } from "node:path";

const BASE = "https://raw.githubusercontent.com/Oleafly/template-packs/main";
const PACK_META = {
  "venue-classes": {
    label: "Journal & conference classes",
    description: "REVTeX, ACS achemso, Elsevier, ACM sigconf, and Typst journal starters.",
    category: "Journals & Conferences",
  },
  "resume-plus": {
    label: "Resume & CV expansion",
    description: "Two-column tech resume, minimal resume, long-form academic CV, cover letter, and a Typst CV.",
    category: "CVs & Resumes",
  },
  "slides-posters": {
    label: "Slides & posters",
    description: "Metropolis beamer deck, tikzposter portrait and landscape, and a better-poster layout.",
    category: "Presentations",
  },
};

const catalog = [];
for (const packId of readdirSync("packs").sort()) {
  const packDir = join("packs", packId);
  if (!statSync(packDir).isDirectory()) continue;
  const files = [];
  let bytes = 0;
  let count = 0;
  const licenses = new Set();
  for (const tplId of readdirSync(packDir).sort()) {
    const tplDir = join(packDir, tplId);
    if (!statSync(tplDir).isDirectory()) continue;
    count++;
    const manifest = JSON.parse(readFileSync(join(tplDir, "template.json"), "utf8"));
    if (manifest.license?.spdx) licenses.add(manifest.license.spdx);
    for (const f of readdirSync(tplDir).sort()) {
      const p = join(tplDir, f);
      if (!statSync(p).isFile()) continue;
      bytes += statSync(p).size;
      files.push({ name: `${tplId}/${f}`, url: `${BASE}/${packDir}/${tplId}/${f}` });
    }
  }
  const meta = PACK_META[packId] ?? { label: packId, description: "", category: "" };
  catalog.push({
    id: packId,
    label: meta.label,
    description: meta.description,
    category: meta.category,
    approx_bytes: bytes,
    count,
    license_summary: [...licenses].sort().join(", "),
    files,
  });
}
writeFileSync("catalog.json", `${JSON.stringify(catalog, null, 2)}\n`);
console.log(`catalog.json: ${catalog.length} packs, ${catalog.reduce((n, p) => n + p.count, 0)} templates`);

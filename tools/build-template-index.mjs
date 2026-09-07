import { existsSync, mkdirSync, readFileSync, readdirSync, writeFileSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const ROOT = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const ENGINES = [["latex", "LaTeX"], ["typst", "Typst"], ["markdown", "Markdown"]];
const urlPath = (value) => value.split("/").map((part) => encodeURIComponent(part).replace(/[!'()*]/g, (character) => `%${character.charCodeAt(0).toString(16).toUpperCase()}`)).join("/");

export function escapeCell(value) {
  return String(value).replace(/\s+/g, " ").trim()
    .replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
    .replaceAll("\\", "\\\\").replaceAll("|", "\\|")
    .replaceAll("[", "\\[").replaceAll("]", "\\]")
    .replaceAll("*", "\\*").replaceAll("_", "\\_").replaceAll("`", "\\`");
}

export function readTemplates(root = ROOT) {
  const templates = [];
  for (const pack of readdirSync(join(root, "packs"), { withFileTypes: true })) {
    if (!pack.isDirectory()) continue;
    for (const folder of readdirSync(join(root, "packs", pack.name), { withFileTypes: true })) {
      if (!folder.isDirectory()) continue;
      const path = `packs/${pack.name}/${folder.name}`;
      const manifest = JSON.parse(readFileSync(join(root, path, "template.json"), "utf8"));
      if (!["xetex", "pdflatex", "latex", "xelatex", "lualatex", "typst", "markdown"].includes(manifest.engine)) throw new Error(`Unknown engine: ${path}`);
      const engine = manifest.engine === "typst" ? "typst" : manifest.engine === "markdown" ? "markdown" : "latex";
      if (!existsSync(join(root, path, manifest.main_doc))) throw new Error(`Missing source: ${path}/${manifest.main_doc}`);
      templates.push({ ...manifest, group: engine, pack: pack.name, path, preview: existsSync(join(root, path, "preview.png")) });
    }
  }
  return templates.sort((a, b) => a.name.localeCompare(b.name, "en") || a.id.localeCompare(b.id, "en"));
}

export function table(templates, gallery, prefix = "") {
  const rows = templates.map((template) => {
    const path = prefix + urlPath(template.path);
    const main = urlPath(template.main_doc);
    const preview = template.preview ? `[Preview](${path}/preview.png)` : "Not included";
    const website = gallery.has(template.id) ? `[View](https://oleafly.com/templates/${encodeURIComponent(template.id)}/)` : "Not listed";
    return `| [${escapeCell(template.name)}](${path}/${main}) | [Files](${path}/) | ${preview} | ${website} |`;
  });
  return ["| Template source | All files | Preview | Website |", "| --- | --- | --- | --- |", ...rows].join("\n");
}

export function buildDocuments(templates, gallery) {
  const files = new Map();
  const summary = ENGINES.map(([key, label]) => {
    const group = templates.filter((template) => template.group === key);
    return `| [${label}](docs/templates-${key}.md) | ${group.length.toLocaleString("en-US")} | ${group.filter((template) => template.preview).length} |`;
  });
  const blocks = [
    "## Template index",
    `This collection contains **${templates.length.toLocaleString("en-US")} templates**. Choose an engine for the full index, or open a starter table below.`,
    ["| Engine | Templates | With previews |", "| --- | ---: | ---: |", ...summary].join("\n"),
    "Template names open the main source file. **All files** opens the complete folder, including any supporting files. **Website** links go to published gallery pages. Community imports and newly added templates may not be listed there yet.",
  ];
  for (const [key, label] of ENGINES) {
    const group = templates.filter((template) => template.group === key);
    const starters = group.filter((template) => template.preview && !template.pack.startsWith("open-"));
    blocks.push(`<details>\n<summary>${label}: ${starters.length} starters with previews</summary>\n\n${table(starters, gallery)}\n\n[Browse all ${group.length.toLocaleString("en-US")} ${label} templates](docs/templates-${key}.md).\n\n</details>`);
    files.set(`docs/templates-${key}.md`, [
      `# ${label} templates`,
      `[Back to the collection](../README.md#template-index) · [Browse the website gallery](https://oleafly.com/templates/)`,
      `${group.length.toLocaleString("en-US")} templates. Click a name to read the main source, or **Files** to get the complete template. Check its manifest and any upstream instructions for the license, packages, fonts, and compiler it needs. Imported entries can include package examples as well as complete documents.`,
      "Previews are linked where the repository includes a rendered image. Website links appear only for published gallery pages; **Not listed** means that this entry is available here as source, without a gallery page.",
      table(group, gallery, "../"),
      "Regenerate this index with `node tools/build-template-index.mjs` from the repository root.",
    ].join("\n\n") + "\n");
  }
  files.set("readme-index", blocks.join("\n\n") + "\n\n");
  return files;
}

async function refreshGallery() {
  const index = await fetch("https://oleafly.com/sitemap-index.xml", { signal: AbortSignal.timeout(20_000) });
  if (!index.ok) throw new Error(`Sitemap index: HTTP ${index.status}`);
  const ids = new Set();
  const sitemapUrls = [...(await index.text()).matchAll(/<loc>(https:\/\/oleafly\.com\/[^<]+)<\/loc>/g)].map((match) => match[1]);
  if (!sitemapUrls.length) throw new Error("No sitemaps found");
  for (const url of sitemapUrls) {
    const response = await fetch(url, { signal: AbortSignal.timeout(20_000) });
    if (!response.ok) throw new Error(`Sitemap: HTTP ${response.status}`);
    for (const match of (await response.text()).matchAll(/<loc>https:\/\/oleafly\.com\/templates\/([a-z0-9-]+)\/<\/loc>/g)) ids.add(match[1]);
  }
  if (!ids.size) throw new Error("No template gallery pages found; keeping the previous list");
  writeFileSync(join(ROOT, "tools/website-template-ids.json"), JSON.stringify([...ids].sort(), null, 2) + "\n");
}

async function main() {
  if (process.argv.includes("--refresh-gallery")) await refreshGallery();
  const gallery = new Set(JSON.parse(readFileSync(join(ROOT, "tools/website-template-ids.json"), "utf8")));
  const documents = buildDocuments(readTemplates(), gallery);
  const readmePath = join(ROOT, "README.md");
  const readme = readFileSync(readmePath, "utf8");
  const start = readme.indexOf("## Template index\n");
  const end = readme.indexOf("## Use a template\n", start);
  if (start < 0 || end < start) throw new Error("README index headings are missing");
  writeFileSync(readmePath, readme.slice(0, start) + documents.get("readme-index") + readme.slice(end));
  documents.delete("readme-index");
  for (const [path, content] of documents) {
    mkdirSync(dirname(join(ROOT, path)), { recursive: true });
    writeFileSync(join(ROOT, path), content);
  }
  console.log("Updated README starter tables and all three engine indexes.");
}

if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) await main();

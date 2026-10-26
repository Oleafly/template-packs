import { existsSync, mkdirSync, readFileSync, readdirSync, writeFileSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const ROOT = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const ENGINES = [["latex", "LaTeX"], ["typst", "Typst"], ["markdown", "Markdown"]];
const TRANSLATIONS_DIR = "docs/readme-translations";
const LOCALES_FILE = "tools/readme-locales.json";
export const EN_STRINGS = {
  numberLocale: "en-US",
  indexHeading: "Template index",
  nextHeading: "Use a template",
  intro: "This collection contains **{count} templates**. Choose an engine for the full index, or open a starter table below.",
  engineColumns: ["Engine", "Templates", "With previews"],
  legend: "Template names open the main source file. **All files** opens the complete folder, including any supporting files. **Website** links go to published gallery pages. Community imports and newly added templates may not be listed there yet.",
  starters: "{engine}: {count} starters with previews",
  browseAll: "Browse all {count} {engine} templates",
  columns: ["Template source", "All files", "Preview", "Website"],
  files: "Files",
  preview: "Preview",
  noPreview: "Not included",
  view: "View",
  notListed: "Not listed",
  period: ".",
};
const fill = (text, values) => text.replace(/\{(\w+)\}/g, (match, key) => key in values ? values[key] : match);
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
  const directoryPacksFile = join(root, "tools", "directory-packs.json");
  const directoryPacks = new Set(existsSync(directoryPacksFile) ? Object.keys(JSON.parse(readFileSync(directoryPacksFile, "utf8"))) : []);
  for (const pack of readdirSync(join(root, "packs"), { withFileTypes: true })) {
    if (!pack.isDirectory()) continue;
    for (const folder of readdirSync(join(root, "packs", pack.name), { withFileTypes: true })) {
      if (!folder.isDirectory()) continue;
      const path = `packs/${pack.name}/${folder.name}`;
      const manifest = JSON.parse(readFileSync(join(root, path, "template.json"), "utf8"));
      if (!["xetex", "pdflatex", "latex", "xelatex", "lualatex", "latexmk", "typst", "markdown"].includes(manifest.engine)) throw new Error(`Unknown engine: ${path}`);
      const engine = manifest.engine === "typst" ? "typst" : manifest.engine === "markdown" ? "markdown" : "latex";
      if (!existsSync(join(root, path, manifest.main_doc))) throw new Error(`Missing source: ${path}/${manifest.main_doc}`);
      const sharedPreview = `previews/${pack.name}/${folder.name}/page-1.webp`;
      const preview = existsSync(join(root, path, "preview.png")) ? `${path}/preview.png` : existsSync(join(root, sharedPreview)) ? sharedPreview : null;
      templates.push({ ...manifest, group: engine, pack: pack.name, path, preview, directory: directoryPacks.has(pack.name) });
    }
  }
  return templates.sort((a, b) => a.name.localeCompare(b.name, "en") || a.id.localeCompare(b.id, "en"));
}

export function table(templates, gallery, prefix = "", strings = EN_STRINGS) {
  const rows = templates.map((template) => {
    const path = prefix + urlPath(template.path);
    const main = urlPath(template.main_doc);
    const preview = template.preview ? `[${strings.preview}](${prefix}${urlPath(template.preview)})` : strings.noPreview;
    const website = gallery.has(template.id) ? `[${strings.view}](https://oleafly.com/templates/${encodeURIComponent(template.id)}/)` : strings.notListed;
    return `| [${escapeCell(template.name)}](${path}/${main}) | [${strings.files}](${path}/) | ${preview} | ${website} |`;
  });
  return [`| ${strings.columns.join(" | ")} |`, "| --- | --- | --- | --- |", ...rows].join("\n");
}

// The README's template index section. Translated READMEs pass their own strings
// and a prefix that leads from docs/readme-translations/ back to the repository root.
export function buildReadmeIndex(templates, gallery, strings = EN_STRINGS, prefix = "") {
  const number = (value) => value.toLocaleString(strings.numberLocale);
  const summary = ENGINES.map(([key, label]) => {
    const group = templates.filter((template) => template.group === key);
    return `| [${label}](${prefix}docs/templates-${key}.md) | ${number(group.length)} | ${number(group.filter((template) => template.preview).length)} |`;
  });
  const blocks = [
    `## ${strings.indexHeading}`,
    fill(strings.intro, { count: number(templates.length) }),
    [`| ${strings.engineColumns.join(" | ")} |`, "| --- | ---: | ---: |", ...summary].join("\n"),
    strings.legend,
  ];
  for (const [key, label] of ENGINES) {
    const group = templates.filter((template) => template.group === key);
    const starters = group.filter((template) => template.preview && !template.pack.startsWith("open-") && !template.directory);
    const summaryLine = fill(strings.starters, { engine: label, count: number(starters.length) });
    const browseAll = fill(strings.browseAll, { engine: label, count: number(group.length) });
    blocks.push(`<details>\n<summary>${summaryLine}</summary>\n\n${table(starters, gallery, prefix, strings)}\n\n[${browseAll}](${prefix}docs/templates-${key}.md)${strings.period}\n\n</details>`);
  }
  return blocks.join("\n\n") + "\n\n";
}

export function replaceReadmeIndex(readme, index, strings = EN_STRINGS) {
  const start = readme.indexOf(`## ${strings.indexHeading}\n`);
  const end = readme.indexOf(`## ${strings.nextHeading}\n`, start);
  if (start < 0 || end < start) throw new Error(`README index headings are missing: "${strings.indexHeading}", "${strings.nextHeading}"`);
  return readme.slice(0, start) + index + readme.slice(end);
}

// Translated READMEs that carry a generated index, with their table strings.
export function readmeTranslations(root = ROOT) {
  const locales = JSON.parse(readFileSync(join(root, LOCALES_FILE), "utf8"));
  return Object.entries(locales).map(([code, strings]) => ({
    code,
    path: `${TRANSLATIONS_DIR}/README.${code}.md`,
    strings: { ...EN_STRINGS, ...strings },
  }));
}

export function buildDocuments(templates, gallery) {
  const files = new Map();
  for (const [key, label] of ENGINES) {
    const group = templates.filter((template) => template.group === key);
    files.set(`docs/templates-${key}.md`, [
      `# ${label} templates`,
      `[Back to the collection](../README.md#template-index) · [Browse the website gallery](https://oleafly.com/templates/)`,
      `${group.length.toLocaleString("en-US")} templates. Click a name to read the main source, or **Files** to get the complete template. Check its manifest and any upstream instructions for the license, packages, fonts, and compiler it needs. Imported entries can include package examples as well as complete documents.`,
      "Previews are linked where the repository includes a rendered image. Website links appear only for published gallery pages; **Not listed** means that this entry is available here as source, without a gallery page.",
      table(group, gallery, "../"),
      "Regenerate this index with `node tools/build-template-index.mjs` from the repository root.",
    ].join("\n\n") + "\n");
  }
  files.set("readme-index", buildReadmeIndex(templates, gallery));
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
  const templates = readTemplates();
  const documents = buildDocuments(templates, gallery);
  const readmePath = join(ROOT, "README.md");
  writeFileSync(readmePath, replaceReadmeIndex(readFileSync(readmePath, "utf8"), documents.get("readme-index")));
  documents.delete("readme-index");
  for (const { path, strings } of readmeTranslations()) {
    const index = buildReadmeIndex(templates, gallery, strings, "../../");
    writeFileSync(join(ROOT, path), replaceReadmeIndex(readFileSync(join(ROOT, path), "utf8"), index, strings));
  }
  for (const [path, content] of documents) {
    mkdirSync(dirname(join(ROOT, path)), { recursive: true });
    writeFileSync(join(ROOT, path), content);
  }
  console.log("Updated the README starter tables, their translations, and all three engine indexes.");
}

if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) await main();

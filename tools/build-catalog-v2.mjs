#!/usr/bin/env node
import { existsSync, mkdirSync, readFileSync, readdirSync, rmSync, statSync, writeFileSync } from "node:fs";
import { dirname, join, relative, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const ROOT = resolve(dirname(fileURLToPath(import.meta.url)), "..");
export const BASE = "https://raw.githubusercontent.com/Oleafly/template-packs/main";
const COVERS = 4;
const SKIPPED_FILES = new Set([".DS_Store", ".git"]);

export function encodePath(path) {
  return path
    .split("/")
    .map((part) => encodeURIComponent(part).replace(/[!'()*]/g, (character) => `%${character.charCodeAt(0).toString(16).toUpperCase()}`))
    .join("/");
}

export function listFiles(dir, base = dir) {
  const files = [];
  for (const name of readdirSync(dir).sort()) {
    if (SKIPPED_FILES.has(name)) continue;
    const path = join(dir, name);
    const stat = statSync(path);
    if (stat.isDirectory()) files.push(...listFiles(path, base));
    else if (stat.isFile()) files.push({ path: relative(base, path).split("\\").join("/"), bytes: stat.size });
  }
  return files;
}

function readJson(path, fallback = null) {
  return existsSync(path) ? JSON.parse(readFileSync(path, "utf8")) : fallback;
}

export const MIRROR = "https://mirrors.oleafly.com/template-files/";

export function remoteFiles(manifest) {
  return (manifest.remote_files ?? []).filter(
    (file) =>
      typeof file.path === "string" &&
      !file.path.split("/").some((part) => part === "" || part === "." || part === "..") &&
      typeof file.url === "string" &&
      file.url.startsWith(MIRROR) &&
      /^[0-9a-f]{64}$/.test(file.sha256 ?? ""),
  );
}

export function licenseOf(manifest) {
  const spdx = manifest.license?.spdx ?? null;
  return { spdx, label: spdx ?? manifest.license?.label ?? "Unlicensed (no license stated)" };
}

export function templateEntry({ root, pack, template, base = BASE }) {
  const dir = join(root, "packs", pack, template);
  const manifest = readJson(join(dir, "template.json"));
  const source = readJson(join(dir, "SOURCE.json"), {});
  const files = listFiles(dir);
  const previews = join(root, "previews", pack, template);
  const url = (path) => `${base}/${encodePath(path)}`;
  const entry = {
    id: manifest.id ?? template,
    name: manifest.name ?? template,
    description: manifest.description ?? "",
    category: manifest.category ?? "",
    engine: manifest.engine,
    main_doc: manifest.main_doc,
    license: licenseOf(manifest),
    bytes: files.reduce((sum, file) => sum + file.bytes, 0) + remoteFiles(manifest).reduce((sum, file) => sum + file.bytes, 0),
    files: [
      ...files.map((file) => ({ name: `${template}/${file.path}`, url: url(`packs/${pack}/${template}/${file.path}`) })),
      ...remoteFiles(manifest).map((file) => ({ name: `${template}/${file.path}`, url: file.url, sha256: file.sha256 })),
    ].sort((a, b) => (a.name < b.name ? -1 : a.name > b.name ? 1 : 0)),
  };
  for (const key of ["kind", "languages", "country", "institution"]) {
    if (manifest[key] !== undefined && manifest[key] !== null) entry[key] = manifest[key];
  }
  if (manifest.requires?.engine === "latexmk") entry.tex_flavor = manifest.requires.tex_flavor ?? null;
  if (source.source_url) entry.credit = { url: source.source_url, author: source.original_author ?? null };
  if (existsSync(join(previews, "thumb.webp"))) entry.thumb_url = url(`previews/${pack}/${template}/thumb.webp`);
  if (existsSync(join(previews, "page-1.webp"))) entry.preview_url = url(`previews/${pack}/${template}/page-1.webp`);
  return entry;
}

export function packMeta(root) {
  const meta = {};
  for (const pack of readJson(join(root, "catalog.json"), [])) {
    meta[pack.id] = { label: pack.label, description: pack.description, category: pack.category, group: pack.id.startsWith("open-") ? "community" : "curated" };
  }
  Object.assign(meta, readJson(join(root, "tools", "directory-packs.json"), {}));
  return meta;
}

export function buildCatalog(root = ROOT, base = BASE) {
  const meta = packMeta(root);
  const packs = [];
  const indexes = {};
  for (const pack of readdirSync(join(root, "packs")).sort()) {
    const packDir = join(root, "packs", pack);
    if (!statSync(packDir).isDirectory()) continue;
    const templates = readdirSync(packDir)
      .sort()
      .filter((template) => existsSync(join(packDir, template, "template.json")))
      .map((template) => templateEntry({ root, pack, template, base }));
    if (templates.length === 0) continue;
    const info = meta[pack] ?? { label: pack, description: "", category: "", group: "curated" };
    const licenses = new Set(templates.map((template) => template.license.spdx ?? "Unlicensed"));
    packs.push({
      id: pack,
      label: info.label,
      description: info.description,
      category: info.category,
      group: info.group ?? "curated",
      count: templates.length,
      bytes: templates.reduce((sum, template) => sum + template.bytes, 0),
      license_summary: [...licenses].sort().join(", "),
      index_url: `${base}/indexes/${encodePath(pack)}.json`,
      covers: templates.filter((template) => template.thumb_url).slice(0, COVERS).map((template) => template.thumb_url),
    });
    indexes[pack] = { version: 2, id: pack, templates };
  }
  return { catalog: { version: 2, packs }, indexes };
}

function main() {
  const { catalog, indexes } = buildCatalog();
  rmSync(join(ROOT, "indexes"), { recursive: true, force: true });
  mkdirSync(join(ROOT, "indexes"), { recursive: true });
  for (const [pack, index] of Object.entries(indexes)) {
    writeFileSync(join(ROOT, "indexes", `${pack}.json`), `${JSON.stringify(index)}\n`);
  }
  writeFileSync(join(ROOT, "catalog-v2.json"), `${JSON.stringify(catalog, null, 1)}\n`);
  const templates = catalog.packs.reduce((sum, pack) => sum + pack.count, 0);
  const previews = Object.values(indexes).reduce((sum, index) => sum + index.templates.filter((t) => t.thumb_url).length, 0);
  console.log(`catalog-v2.json: ${catalog.packs.length} packs, ${templates} templates, ${previews} with previews`);
}

if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  main();
}

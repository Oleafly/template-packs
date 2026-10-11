#!/usr/bin/env node
import { createHash } from "node:crypto";
import { existsSync, readFileSync, readdirSync, writeFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const repoRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..", "..");
const dataDir = path.join(repoRoot, "universities");

function readJsonl(file) {
  if (!existsSync(file)) return [];
  return readFileSync(file, "utf8")
    .split("\n")
    .filter((line) => line.trim())
    .map((line) => JSON.parse(line));
}

export function recordId(repo, mainFile) {
  return createHash("sha1").update(`${repo}|${mainFile}`).digest("hex").slice(0, 12);
}

const PACKS_RAW = "https://raw.githubusercontent.com/Oleafly/template-packs/main";
const PACKS_TREE = "https://github.com/Oleafly/template-packs/tree/main";

function encodePath(value) {
  return value.split("/").map((part) => encodeURIComponent(part)).join("/");
}

export function hostedLinks(place, hasPreview) {
  const links = { pack: place.pack, template: place.template, folder_url: `${PACKS_TREE}/${encodePath(`packs/${place.pack}/${place.template}`)}` };
  if (hasPreview(place.pack, place.template)) {
    const previews = `${PACKS_RAW}/previews/${encodePath(place.pack)}/${encodePath(place.template)}`;
    links.thumb_url = `${previews}/thumb.webp`;
    links.preview_url = `${previews}/page-1.webp`;
  }
  return links;
}

export function compilesAsIs(results) {
  if (!results) return null;
  const clean = (value) => value?.ok && (value.steps ?? []).length === 0;
  for (const engine of ["typst", "tectonic"]) {
    if (clean(results[engine])) return { compiles: "builtin", engine: engine === "typst" ? "typst" : "xelatex" };
  }
  for (const [engine, value] of Object.entries(results)) {
    if (engine.startsWith("latexmk:") && clean(value)) {
      return { compiles: "system", engine: engine.slice("latexmk:".length) };
    }
  }
  return null;
}

export function buildIndex({ inventories, results, rechecks, checked, hosted = null, hasPreview = () => false }) {
  const merged = new Map(results.filter((row) => row.results).map((row) => [row._id, { ...row.results }]));
  for (const row of rechecks) {
    if (merged.has(row._id)) Object.assign(merged.get(row._id), row.results);
  }
  const entries = [];
  const seen = new Set();
  for (const record of inventories) {
    const repo = String(record.repo ?? "");
    const mainFile = String(record.main_file ?? "");
    if (!/^https?:\/\//.test(repo) || !/\.(tex|typ)$/.test(mainFile)) continue;
    if (!record.university || /^generic\b/i.test(record.university)) continue;
    const id = recordId(repo, mainFile);
    if (seen.has(id)) continue;
    const place = hosted?.[id];
    if (hosted && !place) continue;
    const outcome = compilesAsIs(merged.get(id)) ?? (place?.compiles ? { compiles: place.compiles, engine: place.engine } : null);
    if (!outcome) continue;
    seen.add(id);
    entries.push({
      id,
      country: record.country,
      university: record.university,
      university_local: record.university_local || null,
      faculty: record.faculty || null,
      kind: record.kind || "thesis",
      degrees: Array.isArray(record.degrees) ? record.degrees : [],
      format: record.format === "typst" ? "typst" : "latex",
      engine: outcome.engine,
      compiles: outcome.compiles,
      credit_url: repo,
      main_file: place?.main_doc ?? mainFile,
      ...(place ? hostedLinks(place, hasPreview) : {}),
      license: ["NOASSERTION", "OTHER"].includes(record.license_spdx) ? null : record.license_spdx || null,
      official: record.official === "yes" ? true : record.official === "no" ? false : null,
      stars: Number.isFinite(record.stars) ? record.stars : null,
      last_commit: record.last_commit || null,
    });
  }
  entries.sort(
    (a, b) =>
      a.country.localeCompare(b.country) ||
      a.university.localeCompare(b.university) ||
      (b.stars ?? 0) - (a.stars ?? 0),
  );
  return {
    version: 1,
    checked,
    hosted: Boolean(hosted),
    universities: new Set(entries.map((entry) => `${entry.country}|${entry.university}`)).size,
    countries: [...new Set(entries.map((entry) => entry.country))].sort(),
    entries,
  };
}

function main() {
  const inventoryDir = path.join(dataDir, "inventory");
  const inventories = readdirSync(inventoryDir)
    .filter((name) => name.endsWith(".jsonl"))
    .sort()
    .flatMap((name) => readJsonl(path.join(inventoryDir, name)));
  const index = buildIndex({
    inventories,
    results: readJsonl(path.join(dataDir, "compile", "results.jsonl")),
    rechecks: readJsonl(path.join(dataDir, "compile", "recheck.jsonl")),
    checked: process.argv[2] || new Date().toISOString().slice(0, 10),
    hosted: existsSync(path.join(dataDir, "hosted.json")) ? JSON.parse(readFileSync(path.join(dataDir, "hosted.json"), "utf8")) : null,
    hasPreview: (pack, template) => existsSync(path.join(repoRoot, "previews", pack, template, "thumb.webp")),
  });
  writeFileSync(path.join(dataDir, "index.json"), `${JSON.stringify(index, null, 1)}\n`);
  console.log(
    `universities: ${index.entries.length} templates from ${index.universities} universities in ${index.countries.length} countries`,
  );
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  main();
}

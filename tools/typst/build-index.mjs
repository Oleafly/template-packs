#!/usr/bin/env node
import { existsSync, readFileSync, writeFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const repoRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..", "..");
const dataDir = path.join(repoRoot, "typst");
const EXCLUDED_WORDS = ["overleaf"];
const UNKNOWN_LICENSES = ["NOASSERTION", "OTHER"];
const KINDS = ["thesis", "paper", "report", "homework", "notes", "book", "slides", "poster", "cv", "letter"];
const UNIVERSE_KINDS = {
  thesis: "thesis",
  paper: "paper",
  report: "report",
  book: "book",
  presentation: "slides",
  poster: "poster",
  flyer: "poster",
  cv: "cv",
  office: "letter",
};
const HOSTS = { "github.com": "github", "gitlab.com": "gitlab", "codeberg.org": "codeberg" };

function readJsonl(file) {
  if (!existsSync(file)) return [];
  return readFileSync(file, "utf8")
    .split("\n")
    .filter((line) => line.trim())
    .map((line) => JSON.parse(line));
}

function readJson(file, fallback) {
  return existsSync(file) ? JSON.parse(readFileSync(file, "utf8")) : fallback;
}

export function familyToPack(fontPacks) {
  const map = new Map();
  for (const pack of fontPacks) {
    for (const file of pack.files ?? []) {
      for (const family of file.families ?? []) {
        const key = family.trim().toLowerCase();
        if (!map.has(key)) map.set(key, pack.id);
      }
    }
  }
  return map;
}

export function cleanDescription(text) {
  const value = String(text ?? "").trim();
  if (!value) return null;
  return EXCLUDED_WORDS.some((word) => value.toLowerCase().includes(word)) ? null : value;
}

export function repoKey(url) {
  if (typeof url !== "string") return null;
  const match = /^https?:\/\/(?:www\.)?([^/]+)\/([^/]+)\/([^/#?]+)/i.exec(url.trim());
  if (!match) return null;
  return `${match[1]}/${match[2]}/${match[3].replace(/\.git$/i, "")}`.toLowerCase();
}

export function universeKind(categories) {
  const kinds = (categories ?? []).map((category) => UNIVERSE_KINDS[category]).filter(Boolean);
  return KINDS.find((kind) => kinds.includes(kind)) ?? "other";
}

const LANGUAGE_WORDS = [
  ["zh", /\bchinese\b/i],
  ["ja", /\bjapanese\b/i],
  ["ko", /\bkorean\b/i],
  ["de", /\b(german|deutsch)\b/i],
  ["fr", /\b(french|fran[cç]ais)\b/i],
  ["es", /\b(spanish|espa[nñ]ol)\b/i],
  ["pt", /\b(portuguese|portugu[eê]s|brazil(ian)?)\b/i],
  ["it", /\b(italian|italiano)\b/i],
  ["ru", /\brussian\b/i],
  ["uk", /\bukrainian\b/i],
  ["cs", /\b(czech|česk)/i],
  ["pl", /\bpolish\b/i],
  ["tr", /\bturkish\b/i],
  ["vi", /\bvietnamese\b/i],
  ["nl", /\bdutch\b/i],
];

export function guessLanguages(text) {
  const value = String(text ?? "");
  const found = new Set();
  if (/[\u3040-\u30ff]/.test(value)) found.add("ja");
  else if (/[\u4e00-\u9fff]/.test(value)) found.add("zh");
  if (/[\uac00-\ud7af]/.test(value)) found.add("ko");
  if (/[іїєґІЇЄҐ]/.test(value)) found.add("uk");
  else if (/[\u0400-\u04ff]/.test(value)) found.add("ru");
  for (const [code, pattern] of LANGUAGE_WORDS) {
    if (pattern.test(value)) found.add(code);
  }
  return [...found].sort();
}

function license(value) {
  return !value || UNKNOWN_LICENSES.includes(value) ? null : value;
}

function fontsAndPacks(warnings, packs) {
  const missing = [...new Set((warnings ?? []).map((name) => name.trim().replace(/^"|"$/g, "")).filter(Boolean))];
  const covered = [...new Set(missing.map((name) => packs.get(name.toLowerCase())).filter(Boolean))].sort();
  return { missing_fonts: missing.sort(), font_packs: covered };
}

export function universeEntry(result, packs) {
  const { name, version } = result;
  return {
    id: `universe:${name}`,
    source: "universe",
    name,
    version,
    description: cleanDescription(result.description),
    kind: universeKind(result.categories),
    languages: guessLanguages(`${name} ${result.description ?? ""}`),
    categories: result.categories ?? [],
    disciplines: result.disciplines ?? [],
    license: license(result.license),
    repository: result.repository ?? null,
    page_url: `https://typst.app/universe/package/${name}`,
    init_spec: `@preview/${name}:${version}`,
    thumbnail_url: `https://packages.typst.org/preview/thumbnails/${name}-${version}-small.webp`,
    ...fontsAndPacks(result.font_warnings, packs),
  };
}

export function sourceLinks(repo, commit, mainFile) {
  const url = repo.replace(/\/+$/, "");
  const host = new URL(url).hostname;
  const name = url.split("/").pop();
  if (host === "gitlab.com") {
    return {
      source_url: `${url}/-/blob/${commit}/${mainFile}`,
      zip_url: `${url}/-/archive/${commit}/${name}-${commit}.zip`,
    };
  }
  if (host === "codeberg.org") {
    return { source_url: `${url}/src/commit/${commit}/${mainFile}`, zip_url: `${url}/archive/${commit}.zip` };
  }
  return { source_url: `${url}/blob/${commit}/${mainFile}`, zip_url: `${url}/archive/${commit}.zip` };
}

export function repositoryEntry(record, result, meta, packs) {
  const url = record.repo.replace(/\/+$/, "");
  const host = new URL(url).hostname;
  const name = url.split("/").slice(3, 5).join("/");
  return {
    id: `${HOSTS[host]}:${name.toLowerCase()}`,
    source: HOSTS[host],
    name,
    description: cleanDescription(meta?.description),
    kind: KINDS.includes(record.kind) ? record.kind : "other",
    languages: record.language ?? [],
    institution: record.institution ?? null,
    country: record.country ?? null,
    license: license(record.license_spdx),
    stars: meta?.stars ?? record.stars ?? 0,
    updated: record.last_commit ?? null,
    page_url: url,
    main_file: record.main_file,
    commit: result.commit,
    ...sourceLinks(url, result.commit, record.main_file),
    ...fontsAndPacks(result.font_warnings, packs),
  };
}

function listable(record) {
  const key = repoKey(record.repo);
  return Boolean(key && HOSTS[key.split("/")[0]]) && !EXCLUDED_WORDS.some((word) => key.includes(word));
}

export function buildIndex({ universe, github = [], inventory = [], descriptions = {}, fontPacks, checked }) {
  const packs = familyToPack(fontPacks);
  const universeEntries = universe
    .filter((result) => result.ok && typeof result.name === "string" && typeof result.version === "string")
    .map((result) => universeEntry(result, packs));
  const universeRepos = new Set(universeEntries.map((entry) => repoKey(entry.repository)).filter(Boolean));
  const results = new Map(github.map((result) => [result.repo, result]));
  const candidates = inventory.filter(listable).filter((record) => !universeRepos.has(repoKey(record.repo)));
  const repositoryEntries = candidates
    .map((record) => [record, results.get(record.repo)])
    .filter(([, result]) => result?.ok && typeof result.commit === "string")
    .map(([record, result]) => repositoryEntry(record, result, descriptions[record.repo], packs));
  const entries = [...universeEntries, ...repositoryEntries].sort((a, b) => a.id.localeCompare(b.id));
  const checkedRepos = candidates.filter((record) => results.has(record.repo)).length;
  return {
    version: 1,
    checked,
    checked_compiler: "0.15.1",
    templates: entries.length,
    sources: {
      universe: { listed: universeEntries.length, failing: universe.filter((result) => !result.ok).length },
      repositories: { listed: repositoryEntries.length, failing: checkedRepos - repositoryEntries.length },
    },
    entries,
  };
}

function main() {
  const index = buildIndex({
    universe: readJsonl(path.join(dataDir, "compile", "universe.jsonl")),
    github: readJsonl(path.join(dataDir, "compile", "repositories.jsonl")),
    inventory: readJsonl(path.join(dataDir, "inventory", "repositories.jsonl")),
    descriptions: readJson(path.join(dataDir, "inventory", "descriptions.json"), {}),
    fontPacks: readJson(path.join(dataDir, "font-packs.json"), []),
    checked: process.argv[2] || new Date().toISOString().slice(0, 10),
  });
  writeFileSync(path.join(dataDir, "index.json"), `${JSON.stringify(index, null, 1)}\n`);
  const { universe, repositories } = index.sources;
  console.log(
    `typst: ${index.templates} templates compile (Universe ${universe.listed}, repositories ${repositories.listed}); ` +
      `${universe.failing + repositories.failing} do not`,
  );
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  main();
}

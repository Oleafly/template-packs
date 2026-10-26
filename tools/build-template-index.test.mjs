import assert from "node:assert/strict";
import { existsSync, mkdtempSync, mkdirSync, readFileSync, readdirSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import test from "node:test";
import { buildDocuments, buildReadmeIndex, EN_STRINGS, escapeCell, readmeTranslations, readTemplates, replaceReadmeIndex, table } from "./build-template-index.mjs";

const root = resolve(dirname(fileURLToPath(import.meta.url)), "..");

test("template labels cannot introduce table columns, links, or HTML", () => {
  assert.equal(escapeCell("[label]|<b>\nnext"), "\\[label\\]\\|&lt;b&gt; next");
  assert.equal(escapeCell("a_b *c* `d`"), "a\\_b \\*c\\* \\`d\\`");
});

test("only published entries receive website links", () => {
  const templates = [
    { name: "Published", id: "published", path: "packs/a/published", main_doc: "main.tex", preview: "packs/a/published/preview.png" },
    { name: "New", id: "new", path: "packs/b/new", main_doc: "main.md", preview: null },
    { name: "Shared", id: "shared", path: "packs/c/shared", main_doc: "main.typ", preview: "previews/c/shared/page-1.webp" },
  ];
  const result = table(templates, new Set(["published"]), "../");
  assert.match(result, /https:\/\/oleafly.com\/templates\/published\//);
  assert.doesNotMatch(result, /https:\/\/oleafly.com\/templates\/new\//);
  assert.match(result, /\[Preview\]\(\.\.\/packs\/a\/published\/preview.png\)/);
  assert.match(result, /\[Preview\]\(\.\.\/previews\/c\/shared\/page-1.webp\)/);
  assert.match(result, /\[New\]\(\.\.\/packs\/b\/new\/main.md\).*Not included.*Not listed/);
});

test("template discovery rejects missing sources and unknown engines", () => {
  const dir = mkdtempSync(join(tmpdir(), "template-index-test-"));
  const templateDir = join(dir, "packs", "sample", "sample");
  mkdirSync(templateDir, { recursive: true });
  const manifest = { id: "sample", name: "Sample", main_doc: "main.md", engine: "markdown" };
  try {
    writeFileSync(join(templateDir, "template.json"), JSON.stringify(manifest));
    assert.throws(() => readTemplates(dir), /Missing source/);
    writeFileSync(join(templateDir, "main.md"), "# A document");
    assert.equal(readTemplates(dir)[0].group, "markdown");
    writeFileSync(join(templateDir, "template.json"), JSON.stringify({ ...manifest, engine: "unknown" }));
    assert.throws(() => readTemplates(dir), /Unknown engine/);
  } finally {
    rmSync(dir, { recursive: true });
  }
});

test("source filenames with spaces and parentheses remain clickable", () => {
  const result = table([{ name: "Sample", id: "sample", path: "packs/example/sample", main_doc: "draft (2).tex", preview: null }], new Set());
  assert.match(result, /draft%20%282%29\.tex/);
});

test("each repository template appears once in its engine index", () => {
  const templates = readTemplates(root);
  const gallery = new Set(JSON.parse(readFileSync(join(root, "tools/website-template-ids.json"), "utf8")));
  const documents = buildDocuments(templates, gallery);
  for (const template of templates) {
    const source = `../${template.path}/${template.main_doc}`;
    const matchingIndexes = [...documents].filter(([name, content]) => name.startsWith("docs/") && [...content.matchAll(/\]\(([^)]+)\)/g)].some((match) => decodeURIComponent(match[1]) === source));
    assert.equal(matchingIndexes.length, 1, template.id);
    assert.equal(matchingIndexes[0][0], `docs/templates-${template.group}.md`);
  }
});

test("checked-in indexes and README counts match the manifests", () => {
  const gallery = new Set(JSON.parse(readFileSync(join(root, "tools/website-template-ids.json"), "utf8")));
  const documents = buildDocuments(readTemplates(root), gallery);
  const readme = readFileSync(join(root, "README.md"), "utf8");
  assert.equal(replaceReadmeIndex(readme, documents.get("readme-index")), readme);
  for (const [path, content] of documents) {
    if (path.startsWith("docs/")) assert.equal(readFileSync(join(root, path), "utf8"), content, path);
  }
});

test("translated index tables use their own strings and lead back to the repository root", () => {
  const templates = [
    { name: "Paper", id: "paper", group: "latex", pack: "papers", path: "packs/papers/paper", main_doc: "main.tex", preview: "packs/papers/paper/preview.png" },
  ];
  const strings = { ...EN_STRINGS, numberLocale: "de-DE", indexHeading: "Vorlagen", intro: "**{count}** Vorlagen.", files: "Dateien", view: "Ansehen", browseAll: "Alle {count} {engine}-Vorlagen" };
  const index = buildReadmeIndex(templates, new Set(["paper"]), strings, "../../");
  assert.match(index, /^## Vorlagen\n\n\*\*1\*\* Vorlagen\./);
  assert.match(index, /\[Paper\]\(\.\.\/\.\.\/packs\/papers\/paper\/main\.tex\) \| \[Dateien\]\(\.\.\/\.\.\/packs\/papers\/paper\/\) \| \[Preview\]\(\.\.\/\.\.\/packs\/papers\/paper\/preview\.png\) \| \[Ansehen\]/);
  assert.match(index, /\[Alle 1 LaTeX-Vorlagen\]\(\.\.\/\.\.\/docs\/templates-latex\.md\)/);
  assert.throws(() => replaceReadmeIndex("# Title\n", index, strings), /index headings are missing/);
});

test("every translated README has table strings and an up-to-date index", () => {
  const gallery = new Set(JSON.parse(readFileSync(join(root, "tools/website-template-ids.json"), "utf8")));
  const templates = readTemplates(root);
  const translations = readmeTranslations(root);
  const files = readdirSync(join(root, "docs/readme-translations")).filter((name) => /^README\.[^.]+\.md$/.test(name)).sort();
  assert.deepEqual(translations.map(({ path }) => path.split("/").pop()).sort(), files);
  const locales = JSON.parse(readFileSync(join(root, "tools/readme-locales.json"), "utf8"));
  for (const { code, path, strings } of translations) {
    assert.deepEqual(Object.keys(locales[code]).sort(), Object.keys(EN_STRINGS).sort(), `${code} must translate every string`);
    assert.ok(existsSync(join(root, path)), path);
    const readme = readFileSync(join(root, path), "utf8");
    assert.equal(replaceReadmeIndex(readme, buildReadmeIndex(templates, gallery, strings, "../../"), strings), readme, path);
  }
});

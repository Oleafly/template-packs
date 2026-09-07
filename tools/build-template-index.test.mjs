import assert from "node:assert/strict";
import { mkdtempSync, mkdirSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import test from "node:test";
import { buildDocuments, escapeCell, readTemplates, table } from "./build-template-index.mjs";

const root = resolve(dirname(fileURLToPath(import.meta.url)), "..");

test("template labels cannot introduce table columns, links, or HTML", () => {
  assert.equal(escapeCell("[label]|<b>\nnext"), "\\[label\\]\\|&lt;b&gt; next");
  assert.equal(escapeCell("a_b *c* `d`"), "a\\_b \\*c\\* \\`d\\`");
});

test("only published entries receive website links", () => {
  const templates = [
    { name: "Published", id: "published", path: "packs/a/published", main_doc: "main.tex", preview: true },
    { name: "New", id: "new", path: "packs/b/new", main_doc: "main.md", preview: false },
  ];
  const result = table(templates, new Set(["published"]), "../");
  assert.match(result, /https:\/\/oleafly.com\/templates\/published\//);
  assert.doesNotMatch(result, /https:\/\/oleafly.com\/templates\/new\//);
  assert.match(result, /\[Preview\]\(\.\.\/packs\/a\/published\/preview.png\)/);
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
  const result = table([{ name: "Sample", id: "sample", path: "packs/example/sample", main_doc: "draft (2).tex", preview: false }], new Set());
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
  const start = readme.indexOf("## Template index\n");
  const end = readme.indexOf("## Use a template\n", start);
  assert.equal(readme.slice(start, end), documents.get("readme-index"));
  for (const [path, content] of documents) {
    if (path.startsWith("docs/")) assert.equal(readFileSync(join(root, path), "utf8"), content, path);
  }
});

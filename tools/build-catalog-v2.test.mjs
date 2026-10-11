import assert from "node:assert/strict";
import { mkdirSync, mkdtempSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import test from "node:test";
import { buildCatalog, encodePath, licenseOf } from "./build-catalog-v2.mjs";

function write(path, content) {
  mkdirSync(join(path, ".."), { recursive: true });
  writeFileSync(path, typeof content === "string" ? content : JSON.stringify(content));
}

function fixture() {
  const root = mkdtempSync(join(tmpdir(), "catalog-v2-"));
  write(join(root, "catalog.json"), [{ id: "open-cv", label: "Open CVs", description: "CVs", category: "CVs & Resumes" }]);
  write(join(root, "tools", "directory-packs.json"), {
    "typst-thesis": { label: "Typst theses", description: "Theses", category: "Theses & Reports", group: "typst" },
  });
  const cv = join(root, "packs", "open-cv", "plain-cv");
  write(join(cv, "template.json"), { id: "plain-cv", name: "Plain CV", engine: "pdflatex", main_doc: "cv.tex", license: { spdx: "MIT" } });
  write(join(cv, "cv.tex"), "x");
  const thesis = join(root, "packs", "typst-thesis", "github-a-thesis");
  write(join(thesis, "template.json"), {
    id: "github-a-thesis",
    name: "a/thesis",
    engine: "typst",
    main_doc: "src/main.typ",
    license: { spdx: null, label: "Unlicensed (no license stated)" },
    kind: "thesis",
    languages: ["zh"],
    country: "CN",
    remote_files: [
      { path: "fonts/Junicode.ttf", sha256: "a".repeat(64), bytes: 1000, url: `https://mirrors.oleafly.com/template-files/${"a".repeat(64)}.ttf` },
      { path: "../escape.ttf", sha256: "b".repeat(64), bytes: 5, url: `https://mirrors.oleafly.com/template-files/${"b".repeat(64)}.ttf` },
      { path: "evil.ttf", sha256: "c".repeat(64), bytes: 5, url: "https://example.org/evil.ttf" },
    ],
  });
  write(join(thesis, "SOURCE.json"), { source_url: "https://github.com/a/thesis", original_author: "a" });
  write(join(thesis, "src", "main.typ"), "y");
  write(join(thesis, "图片", "cover image.png"), "zz");
  write(join(thesis, ".DS_Store"), "junk");
  write(join(root, "previews", "typst-thesis", "github-a-thesis", "thumb.webp"), "t");
  write(join(root, "previews", "typst-thesis", "github-a-thesis", "page-1.webp"), "p");
  return root;
}

test("paths are percent-encoded one segment at a time", () => {
  assert.equal(encodePath("packs/x/图片/cover image (1).png"), "packs/x/%E5%9B%BE%E7%89%87/cover%20image%20%281%29.png");
});

test("templates without a license say so instead of claiming one", () => {
  assert.deepEqual(licenseOf({ license: { spdx: "MIT" } }), { spdx: "MIT", label: "MIT" });
  assert.deepEqual(licenseOf({ license: { spdx: null } }), { spdx: null, label: "Unlicensed (no license stated)" });
  assert.deepEqual(licenseOf({}), { spdx: null, label: "Unlicensed (no license stated)" });
});

test("the catalog lists packs with counts and covers, and each index lists every file", () => {
  const root = fixture();
  try {
    const { catalog, indexes } = buildCatalog(root, "https://cdn.test");
    assert.equal(catalog.version, 2);
    assert.deepEqual(catalog.packs.map((pack) => [pack.id, pack.group, pack.count]), [
      ["open-cv", "community", 1],
      ["typst-thesis", "typst", 1],
    ]);
    const typst = catalog.packs[1];
    assert.equal(typst.index_url, "https://cdn.test/indexes/typst-thesis.json");
    assert.equal(typst.license_summary, "Unlicensed");
    assert.deepEqual(typst.covers, ["https://cdn.test/previews/typst-thesis/github-a-thesis/thumb.webp"]);
    assert.equal(catalog.packs[0].covers.length, 0);
    const [template] = indexes["typst-thesis"].templates;
    assert.deepEqual(
      template.files.map((file) => file.name),
      [
        "github-a-thesis/SOURCE.json",
        "github-a-thesis/fonts/Junicode.ttf",
        "github-a-thesis/src/main.typ",
        "github-a-thesis/template.json",
        "github-a-thesis/图片/cover image.png",
      ],
    );
    assert.ok(template.files[4].url.endsWith("/github-a-thesis/%E5%9B%BE%E7%89%87/cover%20image.png"));
    assert.deepEqual(template.files[1], {
      name: "github-a-thesis/fonts/Junicode.ttf",
      url: `https://mirrors.oleafly.com/template-files/${"a".repeat(64)}.ttf`,
      sha256: "a".repeat(64),
    });
    assert.equal(template.preview_url, "https://cdn.test/previews/typst-thesis/github-a-thesis/page-1.webp");
    assert.deepEqual(template.credit, { url: "https://github.com/a/thesis", author: "a" });
    assert.deepEqual([template.kind, template.languages, template.country], ["thesis", ["zh"], "CN"]);
    assert.equal(indexes["open-cv"].templates[0].thumb_url, undefined);
  } finally {
    rmSync(root, { recursive: true, force: true });
  }
});

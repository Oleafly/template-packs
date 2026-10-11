import assert from "node:assert/strict";
import test from "node:test";
import {
  buildIndex,
  cleanDescription,
  familyToPack,
  guessLanguages,
  repoKey,
  sourceLinks,
  universeKind,
} from "./build-index.mjs";

const fontPacks = [
  { id: "typst-text", files: [{ families: ["Liberation Sans", "TeX Gyre Termes"] }] },
  { id: "typst-cjk", files: [{ families: ["Noto Serif CJK SC"] }] },
];

test("font families map to the pack that ships them, ignoring case", () => {
  const map = familyToPack(fontPacks);
  assert.equal(map.get("liberation sans"), "typst-text");
  assert.equal(map.get("noto serif cjk sc"), "typst-cjk");
  assert.equal(map.get("simsun"), undefined);
});

test("descriptions that name another editor are dropped", () => {
  assert.equal(cleanDescription("A thesis template for Typst."), "A thesis template for Typst.");
  assert.equal(cleanDescription("Port of an Overleaf template"), null);
  assert.equal(cleanDescription("  "), null);
});

test("Universe categories become one kind, in a fixed order", () => {
  assert.equal(universeKind(["presentation"]), "slides");
  assert.equal(universeKind(["office"]), "letter");
  assert.equal(universeKind(["flyer", "layout"]), "poster");
  assert.equal(universeKind(["cv", "thesis"]), "thesis");
  assert.equal(universeKind(["layout"]), "other");
  assert.equal(universeKind(undefined), "other");
});

test("Universe languages come from the script or a language name", () => {
  assert.deepEqual(guessLanguages("modern-nju-thesis 南京大学学位论文模板"), ["zh"]);
  assert.deepEqual(guessLanguages("卒業論文のテンプレート"), ["ja"]);
  assert.deepEqual(guessLanguages("한국어 이력서"), ["ko"]);
  assert.deepEqual(guessLanguages("Шаблон дипломної роботи"), ["uk"]);
  assert.deepEqual(guessLanguages("Шаблон дипломной работы"), ["ru"]);
  assert.deepEqual(guessLanguages("Thesis template for German and English theses"), ["de"]);
  assert.deepEqual(guessLanguages("A clean CV"), []);
});

test("repository URLs compare without case, slashes or .git", () => {
  assert.equal(repoKey("https://github.com/Owner/Repo.git/"), "github.com/owner/repo");
  assert.equal(repoKey("https://github.com/owner/repo/tree/main/template"), "github.com/owner/repo");
  assert.equal(repoKey("not a url"), null);
  assert.equal(repoKey(null), null);
});

test("source and download links pin the checked commit on each host", () => {
  assert.deepEqual(sourceLinks("https://github.com/a/b", "c0ffee", "src/main.typ"), {
    source_url: "https://github.com/a/b/blob/c0ffee/src/main.typ",
    zip_url: "https://github.com/a/b/archive/c0ffee.zip",
  });
  assert.deepEqual(sourceLinks("https://gitlab.com/a/b/", "c0ffee", "main.typ"), {
    source_url: "https://gitlab.com/a/b/-/blob/c0ffee/main.typ",
    zip_url: "https://gitlab.com/a/b/-/archive/c0ffee/b-c0ffee.zip",
  });
  assert.deepEqual(sourceLinks("https://codeberg.org/a/b", "c0ffee", "main.typ"), {
    source_url: "https://codeberg.org/a/b/src/commit/c0ffee/main.typ",
    zip_url: "https://codeberg.org/a/b/archive/c0ffee.zip",
  });
});

test("only compiling templates are listed, with links, init spec and font packs", () => {
  const index = buildIndex({
    universe: [
      {
        name: "zeta-thesis",
        version: "1.2.0",
        ok: true,
        description: "Thesis",
        categories: ["thesis"],
        license: "MIT",
        font_warnings: ["liberation sans", "simsun", "noto serif cjk sc"],
      },
      { name: "alpha-cv", version: "0.1.0", ok: true, categories: ["cv"], license: "NOASSERTION" },
      { name: "broken", version: "0.0.1", ok: false },
    ],
    fontPacks,
    checked: "2026-10-10",
  });
  assert.equal(index.templates, 2);
  assert.deepEqual(index.sources.universe, { listed: 2, failing: 1 });
  assert.deepEqual(index.entries.map((entry) => entry.name), ["alpha-cv", "zeta-thesis"]);
  const [cv, thesis] = index.entries;
  assert.equal(cv.license, null);
  assert.equal(cv.kind, "cv");
  assert.equal(thesis.init_spec, "@preview/zeta-thesis:1.2.0");
  assert.equal(thesis.page_url, "https://typst.app/universe/package/zeta-thesis");
  assert.equal(
    thesis.thumbnail_url,
    "https://packages.typst.org/preview/thumbnails/zeta-thesis-1.2.0-small.webp",
  );
  assert.deepEqual(thesis.missing_fonts, ["liberation sans", "noto serif cjk sc", "simsun"]);
  assert.deepEqual(thesis.font_packs, ["typst-cjk", "typst-text"]);
  assert.deepEqual(cv.missing_fonts, []);
});

test("repository templates join when they compile, and never twice", () => {
  const record = (repo, extra = {}) => ({
    repo,
    main_file: "main.typ",
    kind: "thesis",
    language: ["de"],
    institution: "TU Example",
    country: "DE",
    stars: 3,
    last_commit: "2026-01-02",
    license_spdx: null,
    ...extra,
  });
  const index = buildIndex({
    universe: [{ name: "pkg", version: "1.0.0", ok: true, repository: "https://github.com/Up/Pkg" }],
    github: [
      { repo: "https://github.com/a/thesis", ok: true, commit: "abc", font_warnings: ["SimSun"] },
      { repo: "https://github.com/a/broken", ok: false, stage: "compile" },
      { repo: "https://github.com/up/pkg", ok: true, commit: "def" },
      { repo: "https://gitlab.com/g/slides", ok: true, commit: "123" },
    ],
    inventory: [
      record("https://github.com/a/thesis"),
      record("https://github.com/a/broken"),
      record("https://github.com/up/pkg"),
      record("https://gitlab.com/g/slides", { kind: "talk", license_spdx: "OTHER" }),
      record("https://github.com/a/unchecked"),
      record("https://example.org/a/elsewhere"),
    ],
    descriptions: {
      "https://github.com/a/thesis": { description: "TU thesis", stars: 40 },
      "https://gitlab.com/g/slides": { description: "Moved from Overleaf" },
    },
    fontPacks,
    checked: "2026-10-10",
  });
  assert.deepEqual(
    index.entries.map((entry) => entry.id),
    ["github:a/thesis", "gitlab:g/slides", "universe:pkg"],
  );
  assert.deepEqual(index.sources.repositories, { listed: 2, failing: 1 });
  const thesis = index.entries[0];
  assert.equal(thesis.source, "github");
  assert.equal(thesis.name, "a/thesis");
  assert.equal(thesis.description, "TU thesis");
  assert.equal(thesis.stars, 40);
  assert.equal(thesis.institution, "TU Example");
  assert.equal(thesis.source_url, "https://github.com/a/thesis/blob/abc/main.typ");
  assert.deepEqual(thesis.missing_fonts, ["SimSun"]);
  const slides = index.entries[1];
  assert.equal(slides.kind, "other");
  assert.equal(slides.license, null);
  assert.equal(slides.description, null);
  assert.equal(slides.stars, 3);
});

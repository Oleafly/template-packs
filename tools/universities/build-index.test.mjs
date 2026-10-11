import assert from "node:assert/strict";
import test from "node:test";
import { buildIndex, compilesAsIs, hostedLinks, recordId } from "./build-index.mjs";

const record = (overrides = {}) => ({
  country: "JP",
  university: "Example University",
  university_local: "例大学",
  kind: "thesis",
  degrees: ["master"],
  format: "latex",
  repo: "https://github.com/example/thesis",
  main_file: "src/main.tex",
  license_spdx: "MIT",
  official: "no",
  stars: 12,
  last_commit: "2026-09-01",
  ...overrides,
});

const result = (repo, mainFile, results) => ({ _id: recordId(repo, mainFile), results });

test("ids match the compile harness", () => {
  assert.equal(recordId("https://github.com/a/b", "main.tex").length, 12);
  assert.equal(recordId("https://github.com/a/b", "main.tex"), recordId("https://github.com/a/b", "main.tex"));
  assert.notEqual(recordId("https://github.com/a/b", "main.tex"), recordId("https://github.com/a/b", "x.tex"));
});

test("only a clean compile with no setup steps counts", () => {
  assert.deepEqual(compilesAsIs({ tectonic: { ok: true, steps: [] } }), { compiles: "builtin", engine: "xelatex" });
  assert.deepEqual(compilesAsIs({ typst: { ok: true } }), { compiles: "builtin", engine: "typst" });
  assert.deepEqual(
    compilesAsIs({ tectonic: { ok: false }, "latexmk:uplatex": { ok: true, steps: [] } }),
    { compiles: "system", engine: "uplatex" },
  );
  assert.equal(compilesAsIs({ tectonic: { ok: true, steps: ["generated x.cls from x.ins"] } }), null);
  assert.equal(compilesAsIs({ tectonic: { ok: false, partial: true } }), null);
  assert.equal(compilesAsIs(undefined), null);
});

test("the index keeps templates that compile as downloaded and drops the rest", () => {
  const ok = record();
  const failing = record({ repo: "https://github.com/example/broken" });
  const named = record({ repo: "https://github.com/example/thesis-overleaf-template", university: "Named University" });
  const generic = record({ repo: "https://github.com/example/generic", university: "Generic (not university-specific)" });
  const rechecked = record({
    repo: "https://github.com/example/flaky",
    country: "CN",
    university: "A University",
    license_spdx: "NOASSERTION",
  });
  const index = buildIndex({
    inventories: [ok, failing, named, generic, rechecked, ok],
    results: [
      result(ok.repo, ok.main_file, { tectonic: { ok: true, steps: [] } }),
      result(failing.repo, failing.main_file, { tectonic: { ok: false } }),
      result(named.repo, named.main_file, { tectonic: { ok: true, steps: [] } }),
      result(generic.repo, generic.main_file, { tectonic: { ok: true, steps: [] } }),
      result(rechecked.repo, rechecked.main_file, { tectonic: { ok: false }, "latexmk:xelatex": { ok: false, partial: true } }),
    ],
    rechecks: [result(rechecked.repo, rechecked.main_file, { "latexmk:xelatex": { ok: true, steps: [] } })],
    checked: "2026-10-10",
  });
  assert.deepEqual(
    index.entries.map((entry) => [entry.country, entry.credit_url, entry.compiles, entry.engine]),
    [
      ["CN", "https://github.com/example/flaky", "system", "xelatex"],
      ["JP", "https://github.com/example/thesis", "builtin", "xelatex"],
      ["JP", "https://github.com/example/thesis-overleaf-template", "builtin", "xelatex"],
    ],
  );
  assert.equal(index.universities, 3);
  assert.equal(index.entries[0].license, null);
  assert.deepEqual(index.countries, ["CN", "JP"]);
  const [, japanese] = index.entries;
  assert.equal(japanese.official, false);
  assert.equal(japanese.folder_url, undefined);
  assert.equal(japanese.license, "MIT");
});

test("once templates are hosted, only hosted ones are listed and they point at template-packs", () => {
  const ok = record();
  const gallery = record({ repo: "https://www.overleaf.com/latex/templates/x/abc", main_file: "main.tex", university: "Gallery University" });
  const notHosted = record({ repo: "https://github.com/example/other" });
  const hosted = {
    [recordId(ok.repo, ok.main_file)]: { pack: "university-jp", template: "uni-jp-example-thesis", main_doc: "src/main.tex" },
    [recordId(gallery.repo, gallery.main_file)]: { pack: "university-jp", template: "uni-jp-x", main_doc: "thesis.tex", compiles: "builtin", engine: "pdflatex" },
  };
  const index = buildIndex({
    inventories: [ok, gallery, notHosted],
    results: [
      result(ok.repo, ok.main_file, { tectonic: { ok: true, steps: [] } }),
      result(notHosted.repo, notHosted.main_file, { tectonic: { ok: true, steps: [] } }),
    ],
    rechecks: [],
    checked: "2026-10-10",
    hosted,
    hasPreview: (pack, template) => template === "uni-jp-example-thesis",
  });
  assert.equal(index.hosted, true);
  assert.deepEqual(
    index.entries.map((entry) => [entry.template, entry.compiles, entry.engine, entry.main_file]),
    [
      ["uni-jp-example-thesis", "builtin", "xelatex", "src/main.tex"],
      ["uni-jp-x", "builtin", "pdflatex", "thesis.tex"],
    ],
  );
  const [first, second] = index.entries;
  assert.equal(first.folder_url, "https://github.com/Oleafly/template-packs/tree/main/packs/university-jp/uni-jp-example-thesis");
  assert.equal(first.thumb_url, "https://raw.githubusercontent.com/Oleafly/template-packs/main/previews/university-jp/uni-jp-example-thesis/thumb.webp");
  assert.equal(second.thumb_url, undefined);
  assert.equal(second.credit_url, "https://www.overleaf.com/latex/templates/x/abc");
});

test("hosted links encode each path segment", () => {
  assert.deepEqual(hostedLinks({ pack: "university-cn", template: "uni cn" }, () => false), {
    pack: "university-cn",
    template: "uni cn",
    folder_url: "https://github.com/Oleafly/template-packs/tree/main/packs/university-cn/uni%20cn",
  });
});

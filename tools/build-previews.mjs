// Compiles every pack template and renders a 600px-wide page-1 preview.png.
// Usage: node tools/build-previews.mjs [packs/<pack>/<template> ...]
// With no args, processes every template under packs/. Requires pdftoppm,
// plus the relevant compiler. Set TECTONIC, TYPST, or PANDOC to override paths.
import { execFileSync } from "node:child_process";
import { cpSync, existsSync, mkdtempSync, readFileSync, readdirSync, rmSync, statSync } from "node:fs";
import { tmpdir } from "node:os";
import { join, resolve } from "node:path";

const LOCALEAF = resolve(process.env.LOCALEAF_DIR ?? "../localeaf");
const tectonicSidecar = join(LOCALEAF, "src-tauri/binaries/tectonic-aarch64-apple-darwin");
const typstSidecar = join(LOCALEAF, "src-tauri/binaries/typst-aarch64-apple-darwin");
const TECTONIC = process.env.TECTONIC ?? (existsSync(tectonicSidecar) ? tectonicSidecar : "tectonic");
const TYPST = process.env.TYPST ?? (existsSync(typstSidecar) ? typstSidecar : "typst");
const PANDOC = process.env.PANDOC ?? "pandoc";

function templateDirs() {
  if (process.argv.length > 2) return process.argv.slice(2).map((p) => p.replace(/\/$/, ""));
  const dirs = [];
  for (const pack of readdirSync("packs").sort()) {
    const packDir = join("packs", pack);
    if (!statSync(packDir).isDirectory()) continue;
    for (const tpl of readdirSync(packDir).sort()) {
      const tplDir = join(packDir, tpl);
      if (statSync(tplDir).isDirectory()) dirs.push(tplDir);
    }
  }
  return dirs;
}

let failures = 0;
for (const dir of templateDirs()) {
  const manifestPath = join(dir, "template.json");
  if (!existsSync(manifestPath)) {
    console.error(`SKIP ${dir}: no template.json`);
    continue;
  }
  const manifest = JSON.parse(readFileSync(manifestPath, "utf8"));
  const main = manifest.main_doc;
  const work = mkdtempSync(join(tmpdir(), "tpl-preview-"));
  try {
    cpSync(dir, work, { recursive: true });
    const pdf = join(work, main.replace(/\.(tex|typ|md)$/, ".pdf"));
    if (manifest.engine === "typst") {
      execFileSync(TYPST, ["compile", join(work, main), pdf], { stdio: "pipe", timeout: 120_000 });
    } else if (manifest.engine === "markdown") {
      execFileSync(PANDOC, [main, "--standalone", "--citeproc", `--pdf-engine=${TECTONIC}`, "--output", pdf], {
        stdio: "pipe",
        timeout: 300_000,
        cwd: work,
      });
    } else {
      execFileSync(TECTONIC, ["--outdir", work, join(work, main)], {
        stdio: "pipe",
        timeout: 300_000,
        cwd: work,
      });
    }
    if (!existsSync(pdf)) throw new Error(`no PDF produced at ${pdf}`);
    execFileSync("pdftoppm", ["-png", "-f", "1", "-l", "1", "-scale-to-x", "600", "-scale-to-y", "-1", pdf, join(work, "preview")], { stdio: "pipe" });
    const page = join(work, "preview-1.png");
    if (!existsSync(page)) throw new Error("pdftoppm produced no page image");
    cpSync(page, join(dir, "preview.png"));
    console.log(`OK   ${dir}`);
  } catch (e) {
    failures++;
    const msg = (e.stderr?.toString() || e.message || String(e)).split("\n").filter(Boolean).slice(-6).join("\n  ");
    console.error(`FAIL ${dir}\n  ${msg}`);
  } finally {
    rmSync(work, { recursive: true, force: true });
  }
}
if (failures) {
  console.error(`\n${failures} template(s) failed`);
  process.exit(1);
}

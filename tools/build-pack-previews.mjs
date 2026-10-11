#!/usr/bin/env node
import { execFile } from "node:child_process";
import { cpSync, existsSync, mkdirSync, mkdtempSync, readFileSync, readdirSync, rmSync, statSync, symlinkSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { promisify } from "node:util";

const run = promisify(execFile);
const ROOT = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const DESKTOP = resolve(process.env.OLEAFLY_DESKTOP ?? join(ROOT, "..", "oleafly-desktop"));
const sidecar = (name) => join(DESKTOP, "src-tauri/binaries", `${name}-aarch64-apple-darwin`);
const TYPST = process.env.TYPST ?? (existsSync(sidecar("typst")) ? sidecar("typst") : "typst");
const TECTONIC = process.env.TECTONIC ?? (existsSync(sidecar("tectonic")) ? sidecar("tectonic") : "tectonic");
const LATEXMK = process.env.LATEXMK ?? "latexmk";
const PANDOC = process.env.PANDOC ?? "pandoc";
const FONT_PATHS = (process.env.TYPST_FONT_PATHS ?? "").split(":").filter(Boolean);
export const THUMB_WIDTH = 320;
export const PAGE_WIDTH = 960;
const QUALITY = "70";
const TEX_BUNDLE = process.env.PREVIEW_TEX_BUNDLE ?? "https://mirrors.oleafly.com/tex-bundles/tlextras-2022.0r0.tar";
const LATEXMK_FLAVORS = {
  pdflatex: ["-pdf"],
  xelatex: ["-xelatex"],
  lualatex: ["-lualatex", "-latexoption=--nosocket"],
  uplatex: ["-pdfdvi", "-latex=uplatex %O %S", "-e", "$dvipdf = q/dvipdfmx %O -o %D %S/", "-e", "$bibtex = q/upbibtex %O %S/", "-e", "$makeindex = q/upmendex %O -o %D %S/"],
  platex: ["-pdfdvi", "-latex=platex %O %S", "-e", "$dvipdf = q/dvipdfmx %O -o %D %S/", "-e", "$bibtex = q/pbibtex %O %S/", "-e", "$makeindex = q/mendex %O -o %D %S/"],
};

export function previewDir(root, pack, template) {
  return join(root, "previews", pack, template);
}

function pandocTectonic() {
  const dir = mkdtempSync(join(tmpdir(), "pandoc-engine-"));
  const link = join(dir, "tectonic");
  symlinkSync(TECTONIC, link);
  return link;
}

const PANDOC_TECTONIC = TECTONIC.endsWith("/tectonic") || TECTONIC === "tectonic" ? TECTONIC : pandocTectonic();

function latexmkCommand(main, work, flavor) {
  const stem = "oleafly-preview";
  return {
    file: LATEXMK,
    args: ["-norc", "-f", "-interaction=nonstopmode", ...LATEXMK_FLAVORS[flavor], `-jobname=${stem}`, main.split("/").pop()],
    cwd: dirname(join(work, main)),
    pdf: join(dirname(join(work, main)), `${stem}.pdf`),
  };
}

export function compileCommands(manifest, work) {
  const main = manifest.main_doc;
  const pdf = join(work, ".oleafly-preview.pdf");
  if (manifest.engine === "typst") {
    const fonts = FONT_PATHS.flatMap((path) => ["--font-path", path]);
    return [{ file: TYPST, args: ["compile", "--root", work, ...fonts, "--font-path", work, join(work, main), pdf], cwd: dirname(join(work, main)), pdf }];
  }
  if (manifest.engine === "markdown") {
    return [{ file: PANDOC, args: [main, "--standalone", "--citeproc", `--pdf-engine=${PANDOC_TECTONIC}`, "--output", pdf], cwd: work, pdf }];
  }
  const flavor = manifest.requires?.tex_flavor;
  if (manifest.requires?.engine === "latexmk" && LATEXMK_FLAVORS[flavor]) {
    return [latexmkCommand(main, work, flavor)];
  }
  const fallback = LATEXMK_FLAVORS[manifest.engine] ? manifest.engine : "pdflatex";
  return [
    {
      file: TECTONIC,
      args: ["-X", "compile", "--bundle", TEX_BUNDLE, "--outdir", work, main.split("/").pop()],
      cwd: dirname(join(work, main)),
      pdf: join(work, main.split("/").pop().replace(/\.tex$/, ".pdf")),
    },
    latexmkCommand(main, work, fallback),
  ];
}

const STORE = process.env.TEMPLATE_FILES_STORE ?? join(ROOT, "..", "third-party-cdn", "template-files");

async function restoreRemoteFiles(manifest, work) {
  for (const file of manifest.remote_files ?? []) {
    const destination = join(work, file.path);
    mkdirSync(dirname(destination), { recursive: true });
    const local = join(STORE, file.url.split("/").pop());
    if (existsSync(local)) {
      cpSync(local, destination);
    } else {
      const response = await fetch(file.url);
      if (!response.ok) throw new Error(`could not fetch ${file.url}`);
      writeFileSync(destination, Buffer.from(await response.arrayBuffer()));
    }
  }
}

async function renderPreview(templateDir, outDir) {
  const manifest = JSON.parse(readFileSync(join(templateDir, "template.json"), "utf8"));
  const work = mkdtempSync(join(tmpdir(), "pack-preview-"));
  try {
    cpSync(templateDir, work, { recursive: true });
    await restoreRemoteFiles(manifest, work);
    let produced = null;
    let lastError = null;
    for (const command of compileCommands(manifest, work)) {
      await run(command.file, command.args, { cwd: command.cwd, timeout: 300_000, maxBuffer: 64 * 1024 * 1024 }).catch((error) => {
        lastError = error;
      });
      if (existsSync(command.pdf)) {
        produced = command;
        break;
      }
    }
    if (!produced) throw lastError ?? new Error("no PDF");
    const command = produced;
    const png = join(work, ".oleafly-page");
    await run("pdftoppm", ["-png", "-f", "1", "-l", "1", "-singlefile", "-scale-to-x", String(PAGE_WIDTH * 2), "-scale-to-y", "-1", command.pdf, png]);
    mkdirSync(outDir, { recursive: true });
    await run("cwebp", ["-quiet", "-q", QUALITY, "-resize", String(PAGE_WIDTH), "0", `${png}.png`, "-o", join(outDir, "page-1.webp")]);
    await run("cwebp", ["-quiet", "-q", QUALITY, "-resize", String(THUMB_WIDTH), "0", `${png}.png`, "-o", join(outDir, "thumb.webp")]);
  } finally {
    rmSync(work, { recursive: true, force: true });
  }
}

export function templateDirs(root, packs) {
  const dirs = [];
  for (const pack of readdirSync(join(root, "packs")).sort()) {
    if (packs.length && !packs.includes(pack)) continue;
    const packDir = join(root, "packs", pack);
    if (!statSync(packDir).isDirectory()) continue;
    for (const template of readdirSync(packDir).sort()) {
      if (existsSync(join(packDir, template, "template.json"))) dirs.push({ pack, template, dir: join(packDir, template) });
    }
  }
  return dirs;
}

function isFresh(entry, outDir) {
  const thumb = join(outDir, "thumb.webp");
  return existsSync(thumb) && statSync(thumb).mtimeMs >= statSync(join(entry.dir, "template.json")).mtimeMs;
}

async function main() {
  const args = process.argv.slice(2);
  const force = args.includes("--force");
  const missingOnly = args.includes("--missing-only");
  const concurrency = Number(args.find((arg) => arg.startsWith("--jobs="))?.slice(7) ?? 6);
  const packs = args.filter((arg) => !arg.startsWith("--"));
  const todo = templateDirs(ROOT, packs).filter((entry) => {
    const outDir = previewDir(ROOT, entry.pack, entry.template);
    if (force) return true;
    if (missingOnly) return !existsSync(join(outDir, "thumb.webp")) || !existsSync(join(outDir, "page-1.webp"));
    return !isFresh(entry, outDir);
  });
  console.log(`${todo.length} previews to build`);
  const failures = [];
  let next = 0;
  let done = 0;
  async function worker() {
    while (next < todo.length) {
      const entry = todo[next++];
      try {
        await renderPreview(entry.dir, previewDir(ROOT, entry.pack, entry.template));
      } catch (error) {
        const message = String(error.stderr || error.message || error).split("\n").filter(Boolean).slice(-2).join(" ");
        failures.push({ pack: entry.pack, template: entry.template, error: message.slice(0, 300) });
      }
      done += 1;
      if (done % 50 === 0 || done === todo.length) console.log(`${done}/${todo.length} (${failures.length} failed)`);
    }
  }
  await Promise.all(Array.from({ length: concurrency }, worker));
  writeFileSync(join(ROOT, "previews", "failures.json"), `${JSON.stringify(failures, null, 1)}\n`);
  console.log(`${todo.length - failures.length} built, ${failures.length} failed; see previews/failures.json`);
}

if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  await main();
}

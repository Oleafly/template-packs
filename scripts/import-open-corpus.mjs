#!/usr/bin/env node
/**
 * Import open-licensed, compile-verified templates from the TeXFix-Bench dataset
 * into packs/ as community open-source packs (with attribution).
 */
import {
  readdirSync,
  readFileSync,
  writeFileSync,
  copyFileSync,
  mkdirSync,
  existsSync,
  statSync,
} from 'node:fs';
import { join, basename, dirname } from 'node:path';

const DATASET =
  process.env.DATASET_ROOT ||
  '/Users/prajwalsvenkatesh/Codespace/Oleafly/oleafly-desktop/.private/papers/texfix-bench/dataset';
const PACKS = join(process.cwd(), 'packs');

const ALLOWED = new Set([
  'MIT',
  'CC0-1.0',
  'CC-BY-4.0',
  'Apache-2.0',
  'LPPL-1.3c',
  'MIT-0',
]);

const CAT_TO_PACK = {
  venue: {
    pack: 'open-venue',
    category: 'Journals & Conferences',
  },
  cv: { pack: 'open-cv', category: 'CVs & Resumes' },
  thesis: { pack: 'open-thesis', category: 'Theses & Reports' },
  coursework: { pack: 'open-coursework', category: 'Assignments' },
  business: { pack: 'open-business', category: 'Business' },
  creative: { pack: 'open-creative', category: 'Creative' },
  beamer: { pack: 'open-beamer', category: 'Presentations' },
  report: { pack: 'open-report', category: 'Theses & Reports' },
  letter: { pack: 'open-letter', category: 'Business' },
  book: { pack: 'open-book', category: 'Theses & Reports' },
  'package-example': {
    pack: 'open-ctan',
    category: 'Package Examples',
  },
  misc: { pack: 'open-misc', category: 'Community' },
};

const SOURCE_LABEL = {
  'github-latex': 'GitHub',
  'github-typst': 'GitHub',
  'typst-universe': 'Typst Universe',
  overleaf: 'Overleaf Gallery',
  ctan: 'CTAN / TeX Live',
};

function slugify(s) {
  return String(s)
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
    .slice(0, 72) || 'template';
}

function titleCase(id) {
  return id
    .replace(/^open-/, '')
    .split('-')
    .filter(Boolean)
    .map((w) => w.charAt(0).toUpperCase() + w.slice(1))
    .join(' ');
}

function resolveDir(entry) {
  // Prefer absolute file_path's parent
  if (entry.file_path && existsSync(entry.file_path)) {
    return dirname(entry.file_path);
  }
  // relative_path like processed/latex/...
  if (entry.relative_path) {
    const abs = join(DATASET, entry.relative_path);
    if (existsSync(abs)) return dirname(abs);
  }
  // id-based processed paths
  const idFlat = String(entry.id).replace(/\//g, '__');
  for (const sub of [
    'processed/latex/cross-engine',
    'processed/latex/engine-specific',
    'processed/typst',
  ]) {
    const d = join(DATASET, sub, idFlat);
    if (existsSync(d)) return d;
  }
  return null;
}

function main() {
  const catalogPath = join(DATASET, 'catalog.json');
  if (!existsSync(catalogPath)) {
    console.error('Missing catalog at', catalogPath);
    process.exit(1);
  }
  const cat = JSON.parse(readFileSync(catalogPath, 'utf8'));
  const docs = cat.documents || cat;
  let added = 0;
  let skipped = 0;
  const byPack = {};

  // Existing template ids under packs
  const existing = new Set();
  for (const pack of readdirSync(PACKS)) {
    const pd = join(PACKS, pack);
    if (!statSync(pd).isDirectory()) continue;
    for (const t of readdirSync(pd)) {
      if (existsSync(join(pd, t, 'template.json'))) existing.add(t);
    }
  }

  for (const entry of docs) {
    if (entry.source === 'template-packs') {
      skipped++;
      continue;
    }
    if (!ALLOWED.has(entry.license)) {
      skipped++;
      continue;
    }
    if (entry.format !== 'latex' && entry.format !== 'typst') {
      skipped++;
      continue;
    }

    const catKey = entry.category || 'misc';
    const map = CAT_TO_PACK[catKey] || CAT_TO_PACK.misc;
    const packId = map.pack;

    // Build unique template id
    let rawId = String(entry.id)
      .replace(/^(github-latex|github-typst|typst-universe|overleaf|ctan)\//, '')
      .replace(/^gh-/, '')
      .replace(/^typst-/, '')
      .replace(/^ol-/, '')
      .replace(/^ctan-/, '');
    let tplId = slugify(`os-${entry.source.replace(/[^a-z]/g, '')}-${rawId}`);
    if (existing.has(tplId)) {
      tplId = slugify(`${tplId}-${added}`);
    }
    if (existing.has(tplId)) {
      skipped++;
      continue;
    }

    const srcDir = resolveDir(entry);
    if (!srcDir) {
      skipped++;
      continue;
    }

    // Find main document
    let mainDoc = entry.main_doc;
    if (!mainDoc || !existsSync(join(srcDir, mainDoc))) {
      const files = readdirSync(srcDir).filter((f) =>
        /\.(tex|typ)$/i.test(f),
      );
      if (!files.length) {
        skipped++;
        continue;
      }
      mainDoc = files[0];
    }

    const destDir = join(PACKS, packId, tplId);
    mkdirSync(destDir, { recursive: true });

    // Copy document + small companions (no previews from dataset)
    for (const name of readdirSync(srcDir)) {
      const sp = join(srcDir, name);
      if (!statSync(sp).isFile()) continue;
      if (name === 'record.json' || name === 'manifest.json') continue;
      if (/\.(pdf|log|aux|out|toc|synctex\.gz)$/i.test(name)) continue;
      if (/\.(tex|typ|sty|cls|bib|bst|clo|csl|yml|yaml|json|md|txt)$/i.test(name) || name === 'SOURCE.json') {
        if (statSync(sp).size > 500_000) continue;
        copyFileSync(sp, join(destDir, name));
      }
    }

    // Ensure main is present
    if (!existsSync(join(destDir, mainDoc))) {
      // cleanup empty
      skipped++;
      continue;
    }

    // Load SOURCE.json if present for author
    let sourceMeta = {};
    const srcJson = join(destDir, 'SOURCE.json');
    if (existsSync(srcJson)) {
      try {
        sourceMeta = JSON.parse(readFileSync(srcJson, 'utf8'));
      } catch {
        /* ignore */
      }
    }

    const author =
      entry.original_author ||
      sourceMeta.original_author ||
      sourceMeta.author ||
      SOURCE_LABEL[entry.source] ||
      'unknown';
    const sourceUrl =
      entry.source_url ||
      sourceMeta.source_url ||
      null;
    const format = entry.format;
    const engine = format === 'typst' ? 'typst' : 'pdflatex';
    const name =
      sourceMeta.title ||
      sourceMeta.extra?.title ||
      titleCase(rawId).slice(0, 100) ||
      tplId;

    const description = [
      `${format === 'typst' ? 'Typst' : 'LaTeX'} template from ${SOURCE_LABEL[entry.source] || entry.source}.`,
      sourceUrl ? `Source: ${sourceUrl}.` : null,
      entry.engine_class === 'cross-engine'
        ? 'Compiles under Tectonic, pdfLaTeX, XeLaTeX, and LuaLaTeX.'
        : format === 'latex'
          ? 'Compiles under Tectonic.'
          : 'Compiles under the Typst CLI.',
    ]
      .filter(Boolean)
      .join(' ');

    const packages = Array.isArray(entry.uses_packages)
      ? entry.uses_packages.slice(0, 20)
      : [];

    const manifest = {
      id: tplId,
      name,
      category: map.category,
      description,
      main_doc: mainDoc,
      engine,
      license: {
        spdx: entry.license,
        author,
        url: sourceUrl || `https://github.com/Oleafly/template-packs`,
      },
      requires: {
        packages: format === 'latex' ? packages : [],
        fonts: [],
        engine: format === 'typst' ? 'typst' : 'tectonic',
      },
      attribution: {
        source: SOURCE_LABEL[entry.source] || entry.source,
        source_url: sourceUrl,
        original_author: author,
        license: entry.license,
      },
      order: 1000 + added,
    };

    // Always write SOURCE.json for redistribution clarity
    writeFileSync(
      join(destDir, 'SOURCE.json'),
      JSON.stringify(
        {
          source: SOURCE_LABEL[entry.source] || entry.source,
          source_url: sourceUrl,
          original_author: author,
          license: entry.license,
          license_url:
            sourceMeta.license_url ||
            {
              MIT: 'https://opensource.org/licenses/MIT',
              'Apache-2.0': 'https://www.apache.org/licenses/LICENSE-2.0',
              'CC-BY-4.0': 'https://creativecommons.org/licenses/by/4.0/',
              'CC0-1.0': 'https://creativecommons.org/publicdomain/zero/1.0/',
              'LPPL-1.3c': 'https://www.latex-project.org/lppl/lppl-1-3c/',
              'MIT-0': 'https://opensource.org/licenses/MIT-0',
            }[entry.license] || null,
          downloaded_at: entry.downloaded_at || null,
        },
        null,
        2,
      ) + '\n',
    );

    writeFileSync(
      join(destDir, 'template.json'),
      JSON.stringify(manifest, null, 2) + '\n',
    );

    existing.add(tplId);
    byPack[packId] = (byPack[packId] || 0) + 1;
    added++;
  }

  console.log(JSON.stringify({ added, skipped, byPack }, null, 2));
}

main();

// Regenerates catalog.json from packs/. Run: node gen-catalog.mjs
import { readdirSync, readFileSync, statSync, writeFileSync } from "node:fs";
import { join } from "node:path";

const BASE = "https://raw.githubusercontent.com/Oleafly/template-packs/main";
const PACK_META = {
  "venue-classes": {
    label: "Journal & conference classes",
    description: "REVTeX, ACS achemso, Elsevier, ACM sigconf, IEEEtran, and Typst journal starters.",
    category: "Journals & Conferences",
  },
  "resume-plus": {
    label: "Resume & CV expansion",
    description: "Two-column tech resume, minimal resume, long-form academic CV, cover letter, and a Typst CV.",
    category: "CVs & Resumes",
  },
  "slides-posters": {
    label: "Slides & posters",
    description: "Metropolis beamer deck, tikzposter portrait and landscape, and a better-poster layout.",
    category: "Presentations",
  },
  "conference-preprints": {
    label: "Conference preprint styles",
    description:
      "NeurIPS, ICML, ICLR, ACL, CVPR, AAAI, IJCAI, USENIX, Nature, PLOS ONE, Springer LNCS, JMLR, arXiv, and Interspeech style preprints.",
    category: "Journals & Conferences",
  },
  "academic-writing": {
    label: "Academic writing pack",
    description:
      "Research and grant proposals, registered reports, literature reviews, application materials, and traditional, publication-based, minimal, and bilingual theses.",
    category: "Theses & Reports",
  },
  coursework: {
    label: "Coursework pack",
    description:
      "Homework, worksheets, quizzes, rubrics, lecture notes, syllabi, math reference sheets, exams, and pseudocode writeups.",
    category: "Assignments",
  },
  "cv-collection": {
    label: "CV & resume style collection",
    description:
      "ModernCV, AltaCV, Awesome-CV, Europass, Friggeri, Plasmati, Twenty Seconds, and Jake's-style resumes.",
    category: "CVs & Resumes",
  },
  "reports-lab": {
    label: "Lab & technical reports",
    description:
      "Lab reports, scientific and technical reports, project and internship reports, and an annual report.",
    category: "Theses & Reports",
  },
  "business-documents": {
    label: "Business documents",
    description:
      "Invoices, memos, meeting minutes, business plans and reports, certificates, and a trifold brochure.",
    category: "Business",
  },
  "creative-misc": {
    label: "Creative & miscellaneous",
    description:
      "Recipe books, invitations, RPG character sheets, a year calendar, table and TikZ galleries, and field notes.",
    category: "Creative",
  },
  "beamer-themes": {
    label: "Beamer theme collection",
    description:
      "Madrid, Warsaw, Berkeley, Singapore, Copenhagen, Frankfurt, Boadilla, and Pittsburgh beamer decks.",
    category: "Presentations",
  },
  "open-venue": {
    label: "Open journal & conference templates",
    description:
      "Openly licensed journal and conference paper templates from public sources (GitHub, Overleaf Gallery, Typst Universe).",
    category: "Journals & Conferences",
  },
  "open-cv": {
    label: "Open CV & resume templates",
    description:
      "Openly licensed CV and resume templates from public sources (GitHub, Overleaf Gallery, Typst Universe).",
    category: "CVs & Resumes",
  },
  "open-thesis": {
    label: "Open thesis templates",
    description:
      "Openly licensed thesis and dissertation templates from public sources.",
    category: "Theses & Reports",
  },
  "open-coursework": {
    label: "Open coursework templates",
    description:
      "Openly licensed homework, notes, and assignment templates from public sources.",
    category: "Assignments",
  },
  "open-business": {
    label: "Open business document templates",
    description:
      "Openly licensed business and office document templates from public sources.",
    category: "Business",
  },
  "open-creative": {
    label: "Open creative templates",
    description:
      "Openly licensed creative and miscellaneous templates from public sources.",
    category: "Creative",
  },
  "open-beamer": {
    label: "Open presentation templates",
    description:
      "Openly licensed Beamer and Typst presentation templates from public sources.",
    category: "Presentations",
  },
  "open-report": {
    label: "Open report templates",
    description:
      "Openly licensed lab, technical, and project report templates from public sources.",
    category: "Theses & Reports",
  },
  "open-letter": {
    label: "Open letter templates",
    description:
      "Openly licensed letter and correspondence templates from public sources.",
    category: "Business",
  },
  "open-book": {
    label: "Open book templates",
    description:
      "Openly licensed book and long-form document templates from public sources.",
    category: "Theses & Reports",
  },
  "open-ctan": {
    label: "CTAN package examples",
    description:
      "Example documents from TeX Live / CTAN packages under the LaTeX Project Public License (LPPL).",
    category: "Package Examples",
  },
  "open-misc": {
    label: "Open community templates",
    description:
      "Openly licensed community document templates from public sources.",
    category: "Community",
  },
};

const catalog = [];
for (const packId of readdirSync("packs").sort()) {
  const packDir = join("packs", packId);
  if (!statSync(packDir).isDirectory()) continue;
  const files = [];
  let bytes = 0;
  let count = 0;
  const licenses = new Set();
  for (const tplId of readdirSync(packDir).sort()) {
    const tplDir = join(packDir, tplId);
    if (!statSync(tplDir).isDirectory()) continue;
    count++;
    const manifest = JSON.parse(readFileSync(join(tplDir, "template.json"), "utf8"));
    if (manifest.license?.spdx) licenses.add(manifest.license.spdx);
    for (const f of readdirSync(tplDir).sort()) {
      const p = join(tplDir, f);
      if (!statSync(p).isFile()) continue;
      bytes += statSync(p).size;
      files.push({ name: `${tplId}/${f}`, url: `${BASE}/${packDir}/${tplId}/${f}` });
    }
  }
  const meta = PACK_META[packId] ?? { label: packId, description: "", category: "" };
  catalog.push({
    id: packId,
    label: meta.label,
    description: meta.description,
    category: meta.category,
    approx_bytes: bytes,
    count,
    license_summary: [...licenses].sort().join(", "),
    files,
  });
}
writeFileSync("catalog.json", `${JSON.stringify(catalog, null, 2)}\n`);
console.log(`catalog.json: ${catalog.length} packs, ${catalog.reduce((n, p) => n + p.count, 0)} templates`);

# Template authoring rules

Each template lives at `packs/<pack-id>/<template-id>/` and contains:

- `template.json` (manifest, schema below)
- the main document (`main.tex` or `main.typ`)
- optional extra files (`refs.bib`, class/style files you are allowed to redistribute)
- `preview.png` (generated, never hand made)

## Manifest schema

```json
{
  "id": "<template-id, kebab-case, must equal the folder name>",
  "name": "Human Name",
  "category": "one of: Journals & Conferences | Theses & Reports | CVs & Resumes | Assignments | Presentations | Posters | Letters | Books | Newsletters | Calendars | Bibliographies | Business | Creative",
  "description": "One sentence, plain language, no em dashes.",
  "main_doc": "main.tex",
  "engine": "xetex",            // "xetex" for LaTeX via Tectonic, "typst" for Typst
  "ats_profile": null,           // only resumes: "friendly" | "design-forward" | null
  "default_color": "#RRGGBB",   // pick a tasteful accent per template
  "license": { "spdx": "CC0-1.0", "author": "Oleafly", "url": "https://github.com/Oleafly/template-packs" },
  "requires": { "packages": [], "fonts": [], "engine": "tectonic" },
  "order": <int, use the range assigned to your pack>
}
```

## Hard rules

1. Every template MUST compile: `node tools/build-previews.mjs packs/<pack>/<tpl>` must print `OK` and produce `preview.png`. Do not finish with any FAIL.
2. LaTeX templates compile with Tectonic's default bundle (TeX Live). Use only packages that exist in TeX Live. No `\write18`, no fontspec system fonts (use bundled font packages like lmodern, libertine, sourcesanspro, charter, biolinum), no external images. Draw figures with TikZ if a figure helps the preview.
3. Typst templates must not import remote `@preview` packages. Built-in Typst features only.
4. No em dashes anywhere in template text. Use commas or periods.
5. Filler content must be realistic and tasteful (a believable paper abstract, a plausible invoice, real-looking section names). Never lorem ipsum. Never real people's personal data; invent names.
6. When a template emulates a well-known venue or design (NeurIPS, ACL, AltaCV, Jake's resume, Friggeri), name it honestly with "-style" and do NOT copy proprietary style files or text. Recreate the look with standard packages. Exception: files whose license allows redistribution (e.g. MIT) may be vendored with the license kept in the manifest and a LICENSE note.
7. Keep each template to one page or a small number of pages; the preview shows page 1, so page 1 must look great and representative.
8. `id` in the manifest must equal the folder name, and `order` values must be unique inside your pack.

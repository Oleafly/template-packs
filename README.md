# Oleafly template packs

Downloadable template packs for [Oleafly](https://github.com/Oleafly/Oleafly).
The app fetches `catalog.json` and installs packs on demand, so this catalog
grows without app releases.

## Layout

- `catalog.json` lists every pack with per-file raw URLs (regenerate with `node gen-catalog.mjs`).
- `packs/<pack-id>/<template-id>/` holds one template: a `template.json`
  manifest plus its source files, the same layout the app bundles internally.
- Community open templates may also include `SOURCE.json` with origin URL,
  author, and license for redistribution.

## Engines

| Engine | Use |
| --- | --- |
| **Tectonic** | Default for most LaTeX packs (bundled in Oleafly) |
| **pdfLaTeX / XeLaTeX / LuaLaTeX** | TeX Live engines; many LaTeX packs also work here |
| **Typst** | Templates with `engine: "typst"` and `.typ` main documents |
| **Pandoc** | Markdown-oriented workflows (when present) |

LaTeX templates are intended to work with packages available from TeX Live so
Tectonic can fetch them automatically.

## Sources

| Pack prefix | Origin |
| --- | --- |
| *(original packs)* | Oleafly-authored templates (CC0-1.0) |
| `open-venue`, `open-cv`, … | Public open-license templates |
| `open-github-*` (via manifests) | [GitHub](https://github.com) repositories under MIT, Apache-2.0, or CC0 |
| `open-overleaf` content | [Overleaf Gallery](https://www.overleaf.com/latex/templates) (CC BY 4.0 / CC0 only) |
| `open-typst` content | [Typst Universe](https://typst.app/universe/) and public Typst repos (MIT / Apache-2.0) |
| `open-ctan` | Example documents from [CTAN](https://ctan.org) / TeX Live (LPPL-1.3c) |

Each imported template records author, license (SPDX), and source URL in
`template.json` (and usually `SOURCE.json`).

## Contributing

PRs welcome. Every template must:

1. Carry an open license in its manifest (**CC0**, **CC BY 4.0**, **MIT**,
   **Apache-2.0**, **LPPL**, or **OFL**).
2. Compile on Oleafly’s bundled **Tectonic** (or **Typst** / **Pandoc** for
   those engines).
3. Prefer TeX Live packages so Tectonic can fetch them automatically.
4. Include attribution for any third-party source (`license.author`,
   `license.url`, and `SOURCE.json` when required by the license).

Original Oleafly content in this repository is **CC0-1.0**. Community packs
retain their upstream licenses.

## Licensing and attribution

The license field in each `template.json` covers the template source
distributed here. Templates may load third-party classes, packages, and fonts
from TeX Live or Typst package registries; those dependencies are not
redistributed in this repo and remain under their respective licenses.

Templates named after a venue, publisher, institution, or established design
are not endorsed by the referenced organization unless the upstream project
says otherwise. Always check current official submission or degree
requirements before using a template for final delivery.

Public sources only: no private or proprietary document templates are included.

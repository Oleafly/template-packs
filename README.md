# Oleafly template packs

Downloadable template packs for [Oleafly](https://github.com/Oleafly/Oleafly).
The app fetches `catalog.json` and installs packs on demand, so this catalog
grows without app releases.

## Layout

- `catalog.json` lists every pack with per-file raw URLs (regenerate with `node gen-catalog.mjs`).
- `packs/<pack-id>/<template-id>/` holds one template: a `template.json`
  manifest plus its source files, the same layout the app bundles internally.

## Contributing

PRs welcome. Every template must carry an open license (LPPL, MIT, OFL, or
CC0) in its manifest, compile on Oleafly's bundled Tectonic (or Typst /
Pandoc for those engines), and use only TeX Live packages so Tectonic can
fetch them automatically.

All original content here is CC0-1.0.

## Licensing and attribution

The license in each manifest covers the original example source and content
distributed by this repository. Templates may load third-party classes,
packages, and fonts from TeX Live; those dependencies are not redistributed
here and remain under their respective licenses.

Templates named after a venue, publisher, institution, or established design
are clearly marked as official-class based or as independently recreated
styles. Independently recreated styles are not endorsed by the referenced
organization. Always check the current official submission or degree
requirements before using a template for final delivery.

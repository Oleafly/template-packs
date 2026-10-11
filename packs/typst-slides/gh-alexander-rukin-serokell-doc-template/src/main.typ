// =============================================================================
// Generic wrapper. Never edit this to write a document - it is driven entirely
// by --input flags from the build script:
//
//   typst compile src/main.typ out/foo.pdf \
//     --font-path assets/fonts \
//     --input doc=content/foo.md \
//     --input art=true
// =============================================================================

#import "template.typ": report, split-frontmatter, table-width
#import "@preview/cmarker:0.1.8"

#let doc-path = sys.inputs.at("doc", default: "content/example-proposal.md")
#let has-art = sys.inputs.at("art", default: "true") == "true"

#let raw-src = read("/" + doc-path)
#let (meta, body-src) = split-frontmatter(raw-src)

// Images referenced in the Markdown are written relative to the .md file, but
// cmarker resolves paths relative to the package. Rebase them onto the
// document's own directory before handing them to Typst's `image`.
#let doc-dir = {
  let parts = doc-path.split("/")
  if parts.len() <= 1 { "" } else { parts.slice(0, -1).join("/") + "/" }
}

#let resolve(path) = {
  if path.starts-with("/") { path } else { "/" + doc-dir + path }
}

// No frontmatter title means there is nothing to put on a cover, so the
// document is built without one. `cover: false` skips it even when a title is
// present.
#let wants-cover = "title" in meta and meta.at("cover", default: "true") != "false"

#show: report.with(
  title: meta.at("title", default: none),
  cover-page: wants-cover,
  subtitle: meta.at("subtitle", default: none),
  author: meta.at("author", default: none),
  date: meta.at("date", default: none),
  has-art: has-art,
  // "auto" or "full"; a document's frontmatter wins over the template default.
  tables: meta.at("tables", default: table-width),
)

// Body images default to the full content width.
//
// This is applied here, on each image as it is constructed, rather than with a
// `set image(width: 100%)` rule. A set rule - even wrapped in a content block -
// leaks into the page footer, because the footer is laid out as part of the
// page carrying this content and inherits the active style chain. It then
// overrides the footer artwork's explicit `height`, blowing the mountains up to
// full width and pushing them off the bottom of the page.
#cmarker.render(
  body-src,
  // Let the .md drive real Typst images, with paths rebased as above.
  scope: (
    image: (path, alt: none) => image(resolve(path), alt: alt, width: 100%),
  ),
)

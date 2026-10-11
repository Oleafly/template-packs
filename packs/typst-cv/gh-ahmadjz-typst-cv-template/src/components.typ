// Reusable layout building blocks for the CV. Edit components here to change
// how every role / section / contact item looks across the document.
// You usually DON'T need to touch this file — edit src/cv.typ for content and
// src/style.typ for colors/fonts/sizes.

#import "style.typ": *

// A FontAwesome-style icon, rendered via Unicode emoji fallback so we don't
// depend on an extra font install. Swap to fontawesome package later if wanted.
#let icon(name) = {
  let table = (
    "user":     "👤",
    "briefcase":"💼",
    "book":     "🎓",
    "heart":    "🤝",
    "map":      "📍",
    "linkedin": "in",
    "mail":     "✉",
    "phone":    "✆",
    "tools":    "🛠",
  )
  let glyph = table.at(name, default: "•")
  text(fill: accent, weight: "bold", glyph)
}

// Section header: title + horizontal blue rule under it.
// Used for "About me", "Work Experience", "Education", "Volunteer experience".
// sticky: true so the header never sits alone at the bottom of a page.
// The icon-name parameter is kept for backwards compatibility but unused —
// icon tiles were removed because emoji glyphs leak into pdftotext output
// and clutter ATS extraction with standalone icon lines.
#let section-header(icon-name, title) = {
  block(above: 18pt, below: 10pt, sticky: true)[
    #text(size: h2-size, weight: "bold", fill: accent, title)
    #v(-4pt)
    #line(length: 100%, stroke: 1pt + accent)
  ]
}

// One entry in the Work / Education / Volunteer sections.
// Single-column layout: company name on the left, dates pushed to the right
// edge on the same line; title (if any) on its own line below; then body.
// breakable: false keeps an entry intact across page breaks.
// This layout also keeps bullets attached to their org in pdftotext output
// (the prior two-column grid detached them — pdftotext read all left cells
// before all right cells).
#let role(company: "", dates: "", title: "", body) = {
  // Front-loaded spacing: large above, small below. With Typst's adjacent-block
  // spacing collapse (max of below_prev + above_next), this gives ~18pt between
  // entries — clearly larger than the 6pt between bullets within an entry —
  // while keeping each entry tight to its own bullets.
  block(above: 18pt, below: 4pt, breakable: false)[
    // Direction-aware alignment: start/end adapt to text dir (LTR → left/right,
    // RTL → right/left), so the same grid renders correctly for the Arabic CV.
    #grid(
      columns: (1fr, auto),
      column-gutter: 10pt,
      align: (start + horizon, end + horizon),
      // Company name is the visual anchor for a new entry — slightly larger
      // than the title below so the eye lands on it first.
      text(size: company-size, weight: "bold", fill: ink, company),
      if dates != "" { text(size: small-size, fill: muted, dates) } else { [] },
    )
    #if title != "" [
      #v(3pt)
      #text(size: h3-size, weight: "bold", fill: ink, title)
    ]
    #v(5pt)
    #body
  ]
}

// One row in the header contact panel: optional icon + bold label + value.
// Pass icon-name: "" (or any glyph the bundled font doesn't render) to skip
// the icon column. Used for Address, whose pin emoji (📍) Carlito can't render.
#let contact-item(icon-name, label, value) = {
  if icon-name == "" {
    grid(
      columns: (auto, 1fr),
      column-gutter: 6pt,
      align: (start + horizon, start + horizon),
      text(weight: "bold", label + ":"),
      text(value),
    )
  } else {
    grid(
      columns: (auto, auto, 1fr),
      column-gutter: 6pt,
      align: (start + horizon, start + horizon, start + horizon),
      icon(icon-name),
      text(weight: "bold", label + ":"),
      text(value),
    )
  }
}

// The top band: circular photo on the start side, name+title+contacts after it.
// In LTR document → photo on left, content on right.
// In RTL document → photo on right, content on left (natural for Arabic).
// contacts-columns controls how many columns the contact grid uses (default 2).
// Use 1 when contact values are long (e.g. translated labels in Arabic + full
// LinkedIn URL) and a 2-column split would wrap the value awkwardly.
//
// PHOTO IS OPTIONAL: pass `photo: none` (the default) to render a photo-less,
// full-width header — useful if you'd rather not put a picture on your CV.
// Pass a path (e.g. "assets/photo.jpg") to show a circular photo.
#let header-band(photo: none, name: "", title: "", contacts: (), contacts-columns: 2) = {
  // Name + title + contacts block, shared by both the with-photo and the
  // photo-less layouts.
  let info = [
    #text(size: h1-size, weight: "bold", fill: ink, name)
    #v(-2pt)
    #text(size: 11pt, fill: muted, title)
    #v(6pt)
    #grid(
      columns: (1fr,) * contacts-columns,
      column-gutter: 14pt,
      row-gutter: 5pt,
      ..contacts,
    )
  ]
  block(below: 16pt)[
    #if photo == none {
      // No photo → name/title/contacts take the full width.
      info
    } else {
      // With photo → circular photo on the start side, info after it.
      grid(
        columns: (3.4cm, 1fr),
        column-gutter: 18pt,
        align: (center + horizon, start + horizon),
        // Circular photo, clipped from a square JPEG.
        box(
          width: 3.4cm,
          height: 3.4cm,
          clip: true,
          radius: 50%,
          stroke: 2pt + accent.lighten(40%),
          image(photo, width: 100%, height: 100%, fit: "cover"),
        ),
        info,
      )
    }
  ]
}

// A compact bulleted list used inside roles. Slightly tighter than Typst's default.
#let bullets(items) = {
  list(
    marker: text(fill: accent, "•"),
    spacing: 6pt,
    indent: 0pt,
    body-indent: 6pt,
    ..items,
  )
}

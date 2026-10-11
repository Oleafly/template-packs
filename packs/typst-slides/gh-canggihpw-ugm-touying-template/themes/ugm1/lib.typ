// =======================================================
// UGM Touying Theme — "ugm1"
// Converted from the LaTeX Beamer ugm1 theme
//
// Coordinate mapping: LaTeX TikZ (origin=bottom-left, y↑)
// → Typst (origin=top-left, y↓)
//   top-anchored:  typst_dy = page_height - latex_y
//   bottom-anchored: typst_dy = latex_y
// =======================================================

// ===== Colors =====
#let ugm-yellow = rgb("#f6d648")
#let ugm-blue = rgb("#194168")
#let ugm-dark-blue = rgb("#00416B")

// ===== UGM branding =====
#let ugm-url = "ugm.ac.id"
#let ugm-tagline = "LOCALLY ROOTED, GLOBALLY RESPECTED"

// ===== Slide dimensions (Beamer 16:9 = 16cm × 9cm) =====
#let slide-width = 16cm
#let slide-height = 9cm
#let slide-margin = 1cm

// ===== Font family =====
#let gama-font = "Gama-Sans"

// ===== Helper: full-page colored rectangle =====
#let full-bg(color) = {
  place(top + left, dx: 0pt, dy: 0pt, rect(
    width: slide-width,
    height: slide-height,
    fill: color,
  ))
}

// ===== Helper: URL/tagline text with wide tracking =====
#let url-style = {
  set text(font: gama-font, weight: "bold", size: 7pt, tracking: 4pt)
}

#let tagline-style = {
  set text(font: gama-font, weight: "bold", size: 7pt, tracking: 4pt)
}

// ===================================================================
// TITLE SLIDE
//
// LaTeX layout (bottom-left origin, cm units):
//   bg:      fill=ugmbackgroundblue, full page
//   line1:   (5.25,7.75)→(15.25,7.75)  thin white
//   line2:   (0.75,3.75)→(1.75,3.75)   thick white
//   logo:    anchor=NW at (0.6,8.5)     w=4cm
//   img:     anchor=SE at (pw+0.2,-0.1) w=11.5cm
//   title:   anchor=NW at (0.6,6.15)    12cm minipage, yellow bold 16pt
//   subtitle: anchor=NW at (0.6,3.64)    4.5cm minipage, white 7pt
//   url:     anchor=NW at (0.6,0.9)     white bold 7pt wide tracking
//   tagline: anchor=NW at (8.85,0.9)    white bold 7pt wide tracking
//   stripe:  rect (0,0) to (pw+0.3,0.25) yellow
// ===================================================================
#let title-slide(
  title: "",
  subtitle: "",
  author: "",
  date: "",
) = {
  set page(fill: ugm-dark-blue, margin: 0pt)

  full-bg(ugm-dark-blue)

  // UGM logo — white horizontal, top-left
  // LaTeX: anchor=NW at (0.6, 8.5) → dy = 9-8.5 = 0.5cm from top
  place(top + left, dx: 0.6cm, dy: 0.5cm, {
    image("images/ugm-horizontal-white.png", width: 4cm)
  })

  // Title image — bottom-right, extends beyond page edge
  // LaTeX: anchor=SE at (paperwidth+0.2, -0.1) from bottom-left
  //   → Typst: anchor=bottom+right, dx=+0.2cm (right), dy=+0.1cm (below)
  place(bottom + right, dx: 0.2cm, dy: 0.1cm, {
    image("images/title-image.png", width: 11.5cm)
  })

  // Thin white decorative line
  // LaTeX: from (5.25,7.75) to (15.25,7.75) → dy = 9-7.75 = 1.25cm from top
  place(top + left, dx: 5.25cm, dy: 1.25cm, {
    line(length: 10cm, stroke: 0.5pt + white)
  })

  // Short thick white decorative line
  // LaTeX: from (0.75,3.75) to (1.75,3.75) → dy = 9-3.75 = 5.25cm from top
  place(top + left, dx: 0.75cm, dy: 5.25cm, {
    line(length: 1cm, stroke: 1.5pt + white)
  })

  // Title — yellow, bold, 16pt, 12cm wide
  // LaTeX: anchor=NW at (0.6, 6.15) → dy = 9-6.15 = 2.85cm from top
  place(top + left, dx: 0.6cm, dy: 2.85cm, {
    set text(fill: ugm-yellow, font: gama-font, weight: "bold", size: 16pt)
    block(width: 12cm, title)
  })

  // Subtitle — white, 7pt, 4.5cm wide
  // LaTeX: anchor=NW at (0.6, 3.64) → dy = 9-3.64 = 5.36cm from top
  place(top + left, dx: 0.6cm, dy: 5.36cm, {
    set text(fill: white, font: gama-font, size: 7pt)
    block(width: 4.5cm, subtitle)
  })

  // URL — white, near bottom
  // LaTeX: anchor=NW at (0.6, 0.9) from bottom-left → bottom-anchor, dy=0.9cm
  place(bottom + left, dx: 0.6cm, dy: 0.9cm, {
    url-style
    set text(fill: white)
    ugm-url
  })

  // Tagline — white, near bottom
  // LaTeX: anchor=NW at (8.85, 0.9) from bottom-left
  place(bottom + left, dx: 8.85cm, dy: 0.9cm, {
    tagline-style
    set text(fill: white)
    ugm-tagline
  })

  // Yellow stripe at very bottom
  // LaTeX: rect from (0,0) to (paperwidth+0.3, 0.25) from bottom-left
  place(bottom + left, dx: 0pt, dy: 0pt, {
    rect(width: slide-width + 0.3cm, height: 0.25cm, fill: ugm-yellow)
  })

  pagebreak()
}

// ===================================================================
// SECTION DIVIDER SLIDE
//
// LaTeX layout (bottom-left origin):
//   bg:      white (default)
//   stripe:  rect from (0,1.25) to (0.25,7.75)  yellow vertical
//   logo:    anchor=NW at (11.1,8.5)  w=4cm blue
//   img:     anchor=SE at (pw+0.3,-0.2)  w=5.4cm
//   title:   anchor=NW at (1.35,6.65)  12cm, blue bold 16pt
//   url:     anchor=NW at (13.85,0.67)  blue bold 7pt
//   tagline: anchor=NW at (1.35,0.67)   blue bold 7pt
// ===================================================================
#let section-slide(section-name) = {
  set page(fill: white, margin: 0pt)

  full-bg(white)

  // Yellow vertical stripe (left edge)
  // LaTeX: rect from (0,1.25) to (0.25,7.75) → height = 7.75-1.25 = 6.5cm
  //   top-anchor, dy = 9-7.75 = 1.25cm from top
  place(top + left, dx: 0pt, dy: 1.25cm, {
    rect(width: 0.25cm, height: 6.5cm, fill: ugm-yellow)
  })

  // Blue UGM logo — top-right area
  // LaTeX: anchor=NW at (11.1, 8.5) → dy = 9-8.5 = 0.5cm from top
  place(top + left, dx: 11.1cm, dy: 0.5cm, {
    image("images/ugm-horizontal-blue.png", width: 4cm)
  })

  // Section decorative image — bottom-right, extends beyond page
  // LaTeX: anchor=SE at (paperwidth+0.3, -0.2)
  //   → Typst: bottom+right, dx=+0.3cm (right), dy=+0.2cm (below)
  place(bottom + right, dx: 0.3cm, dy: 0.2cm, {
    image("images/section-image.png", width: 5.4cm)
  })

  // Section title — blue, bold, 16pt, 12cm wide
  // LaTeX: anchor=NW at (1.35, 6.65) → dy = 9-6.65 = 2.35cm from top
  place(top + left, dx: 1.35cm, dy: 2.35cm, {
    set text(fill: ugm-blue, font: gama-font, weight: "bold", size: 16pt)
    block(width: 12cm, section-name)
  })

  // URL — blue, bottom-right area
  // LaTeX: anchor=NW at (13.85, 0.67) from bottom-left
  place(bottom + left, dx: 13.85cm, dy: 0.67cm, {
    url-style
    set text(fill: ugm-blue)
    ugm-url
  })

  // Tagline — blue, bottom-left area
  // LaTeX: anchor=NW at (1.35, 0.67) from bottom-left
  place(bottom + left, dx: 1.35cm, dy: 0.67cm, {
    tagline-style
    set text(fill: ugm-blue)
    ugm-tagline
  })

  pagebreak()
}

// ===================================================================
// CONTENT SLIDE
//
// LaTeX layout (bottom-left origin):
//   bg:          white (default)
//   blue stripe: rect (0,0) to (0.25,6.875)  blue
//   yellow stripe: rect (0,6.875) to (0.25,paperheight) yellow
//   logo:        anchor=NW at (13.37,8.5)  w=1.9cm blue
//   url:         anchor=NW at (0.6,0.65)   blue bold 7pt
//   tagline:     anchor=NW at (8.85,0.65)  blue bold 7pt
//   frametitle:  vspace*{1cm}, hspace*{-0.25cm}, blue bold 18pt
// ===================================================================
#let content-slide(title: "", body) = {
  set page(fill: white, margin: 0pt)

  full-bg(white)

  // Vertical stripes on left edge:
  // Blue segment: from bottom to y=6.875 (height=6.875)
  place(bottom + left, dx: 0pt, dy: 0pt, {
    rect(width: 0.25cm, height: 6.875cm, fill: ugm-blue)
  })
  // Yellow segment: from y=6.875 to top (height = 9-6.875 = 2.125)
  place(top + left, dx: 0pt, dy: 0pt, {
    rect(width: 0.25cm, height: (slide-height - 6.875cm), fill: ugm-yellow)
  })

  // Small blue UGM logo — top-right
  // LaTeX: anchor=NW at (13.37, 8.5) → dy = 9-8.5 = 0.5cm from top
  place(top + left, dx: 13.37cm, dy: 0.5cm, {
    image("images/ugm-horizontal-blue.png", width: 1.9cm)
  })

  // URL — blue, bottom
  // LaTeX: anchor=NW at (0.6, 0.65) from bottom-left
  place(bottom + left, dx: 0.6cm, dy: 0.65cm, {
    url-style
    set text(fill: ugm-blue)
    ugm-url
  })

  // Tagline — blue, bottom
  // LaTeX: anchor=NW at (8.85, 0.65) from bottom-left
  place(bottom + left, dx: 8.85cm, dy: 0.65cm, {
    tagline-style
    set text(fill: ugm-blue)
    ugm-tagline
  })

  // Frame title — blue, bold, 18pt
  // LaTeX: vspace*{1cm}, hspace*{-0.25cm} from text margin (1cm)
  //   → (1cm - 0.25cm) = 0.75cm from left, 1cm from top
  place(top + left, dx: 0.75cm, dy: 1cm, {
    set text(fill: ugm-blue, font: gama-font, weight: "bold", size: 18pt)
    block(width: (slide-width - slide-margin * 2) * 0.9, title)
  })

  // Content body
  place(top + left, dx: slide-margin, dy: 3.2cm, {
    set text(font: gama-font, size: 11pt, fill: black)
    block(width: slide-width - slide-margin * 2, body)
  })

  pagebreak()
}

// ===================================================================
// QUOTE SLIDE
//
// LaTeX layout (bottom-left origin):
//   bg:          fill=ugmbackgroundblue, full page
//   img:         anchor=SE at (pw+0.1,-0.2)  w=5.4cm
//   logo:        anchor=NW at (6.35,5.2)  w=3cm stacked
//   quote:       anchor=NW at (4.5,8)  6.5cm minipage, white italic 11pt
//   tagline:     anchor=NW at (4.9,1.6)  white bold 7pt
//   url:         anchor=NW at (7.1,1.18) white bold 7pt
// ===================================================================
#let quote-slide(quote) = {
  set page(fill: ugm-dark-blue, margin: 0pt)

  full-bg(ugm-dark-blue)

  // Quote decorative image — bottom-right, extends beyond page
  // LaTeX: anchor=SE at (paperwidth+0.1, -0.2)
  //   → Typst: bottom+right, dx=+0.1cm (right), dy=+0.2cm (below)
  place(bottom + right, dx: 0.1cm, dy: 0.2cm, {
    image("images/quote-image.png", width: 5.4cm)
  })

  // Stacked UGM logo — center-left area
  // LaTeX: anchor=NW at (6.35, 5.2) → dy = 9-5.2 = 3.8cm from top
  place(top + left, dx: 6.35cm, dy: 3.8cm, {
    image("images/ugm-stacked.png", width: 3cm)
  })

  // Quote text — white, italic, 11pt, 6.5cm wide, centered
  // LaTeX: anchor=NW at (4.5, 8) → dy = 9-8 = 1.0cm from top, 6.5cm minipage
  place(top + left, dx: 4.5cm, dy: 1cm, {
    set text(fill: white, font: gama-font, style: "italic", size: 11pt)
    align(center, block(width: 6.5cm, quote))
  })

  // Tagline — white, bottom
  // LaTeX: anchor=NW at (4.9, 1.6) from bottom-left
  place(bottom + left, dx: 4.9cm, dy: 1.6cm, {
    tagline-style
    set text(fill: white)
    ugm-tagline
  })

  // URL — white, bottom
  // LaTeX: anchor=NW at (7.1, 1.18) from bottom-left
  place(bottom + left, dx: 7.1cm, dy: 1.18cm, {
    url-style
    set text(fill: white)
    ugm-url
  })

  pagebreak()
}

// ===================================================================
// Custom slide environment — wraps content-slide for convenience
// ===================================================================
#let slide(title: "", body) = {
  content-slide(title: title, body)
}

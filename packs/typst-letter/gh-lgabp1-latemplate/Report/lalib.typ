// ##########################################################
//   _          _ _ _
//  | |    __ _| (_) |__
//  | |   / _` | | | '_ \
//  | |__| (_| | | | |_) |
//  |_____\__,_|_|_|_.__/
// ##########################################################

/*
  Place content at specified alignment with standard settings
*/
#let place_at(align, content) = {
  place(
    align,
    float: true,
    scope: "parent",
    clearance: 1em,
    content,
  )
}

/*
  Quick emphasis text function for headers, labels, etc.
*/
#let emphasis_text(
  content,
  text_color: orange,
  text_style: "italic",
  text_weight: "bold",
  text_size: 1em,
) = {
  text(
    fill: text_color,
    style: text_style,
    weight: text_weight,
    size: text_size,
    content,
  )
}

/*
  Render an appendix as a heading while retaining figure's independent counter.
  Apply with: #show figure.where(kind: "appendix"): appendix_heading
*/
#let appendix_heading(it) = {
  let number = counter(figure.where(kind: "appendix")).at(it.location())
  block(above: 0em, below: 0em)[
    #align(center + top)[
      #set text(size: 24pt, weight: "bold", fill: color.rgb("1f4e79"), hyphenate: false)
      #it.supplement
      #h(0.25em)
      #numbering(it.numbering, ..number)
      #text(": ")
      #it.caption.body
    ]
  ]
}

/*
  Lay out a page after a title has been rendered.
*/
#let insert_titled_page_content(
  render_title,
  content,
  page_break_before: true,
  page_break_after: false,
  content_align: center + top,
  column_count: none,
  gap_under_header: 1.5em,
) = {
  if page_break_before {
    pagebreak()
  }

  if column_count != none {
    // Keep the title full-width, then apply the requested columns to the body.
    set page(columns: 1)
    render_title()
    v(gap_under_header)
    columns(column_count)[
      #align(content_align)[#content]
    ]
  } else {
    render_title()
    v(gap_under_header)
    align(content_align)[#content]
  }

  if page_break_after {
    pagebreak()
  }
}

/*
  Insert an appendix page with an independent A/B/C counter and a native label.
*/
#let insert_appendix(
  title,
  supplement: [ANNEXE],
  numbering: "A",
  label_name: none,
  show_in_toc: true,
  page_break_before: true,
  page_break_after: false,
  content_align: left + top,
  column_count: none,
  content,
  gap_under_header: 0em,
) = {
  let render_title = if label_name != none {
    () => eval(
      "#figure(kind: \"appendix\", supplement: supplement, numbering: numbering, outlined: show_in_toc, caption: title)[] <"
        + label_name
        + ">",
      mode: "markup",
      scope: (title: title, supplement: supplement, numbering: numbering, show_in_toc: show_in_toc),
    )
  } else {
    () => figure(
      kind: "appendix",
      supplement: supplement,
      numbering: numbering,
      outlined: show_in_toc,
      caption: title,
    )[]
  }

  insert_titled_page_content(
    render_title,
    content,
    page_break_before: page_break_before,
    page_break_after: page_break_after,
    content_align: content_align,
    column_count: column_count,
    gap_under_header: gap_under_header,
  )
}

/*
  Insert a titled page, optionally represented by an outline heading.
*/
#let insert_titled_page(
  title: none,
  title_color: color.rgb("1f4e79"),
  title_size: 24pt,
  show_in_toc: false,
  label_name: none,
  page_break_before: true,
  page_break_after: false,
  content_align: center + top,
  column_count: none,
  content,
  gap_under_header: 1.5em,
) = {
  let title_content = text(size: title_size, weight: "bold", fill: title_color, hyphenate: false)[
    #title
    #if label_name != none { label(label_name) }
  ]
  let render_title = if show_in_toc {
    () => align(center + top)[
      #show heading: it => title_content
      #heading(level: 1, numbering: none)[#title]
    ]
  } else {
    () => align(center + top)[#title_content]
  }

  insert_titled_page_content(
    render_title,
    content,
    page_break_before: page_break_before,
    page_break_after: page_break_after,
    content_align: content_align,
    column_count: column_count,
    gap_under_header: gap_under_header,
  )
}

/*
  Insert table of contents with customizable styling
*/
#let insert_toc(
  title: "Table of Contents",
  title_color: color.rgb("1f4e79"),
  title_size: 24pt,
  text_size: 11pt,
  max_depth: 3,
  indent: auto,
  page_break_before: true,
  page_break_after: true,
  show_in_toc: true,
) = {
  insert_titled_page(
    title: title,
    title_color: title_color,
    title_size: title_size,
    page_break_before: page_break_before,
    page_break_after: page_break_after,
    content_align: left + top,
    show_in_toc: show_in_toc,
    [
      // Generate the outline with custom text size
      #show outline.entry: it => {
        set text(size: text_size)
        it
      }

      #outline(
        title: none,
        depth: max_depth,
        indent: indent,
      )
    ],
  )
}

/*
  Create a heading that appears in TOC but is invisible on the page
*/
#let hidden_heading(
  title,
  level: 1,
  numbering: none,
) = {
  // Set up show rule to make this specific heading invisible
  show heading.where(body: [#title]): it => []
  // Create the heading (will be invisible due to show rule above)
  heading(level: level, numbering: numbering)[#title]
}

/*
  Image cropped by removing margins from its edges.
*/
#let image_cropped(
  source,
  margin_top: 0em,
  margin_bottom: 0em,
  margin_left: 0em,
  margin_right: 0em,
  format: auto,
  width: auto,
  height: auto,
  alt: none,
  page: 1,
  fit: "cover",
  crop_fit: false,
  scaling: auto,
  icc: auto,
) = context {
  // Resolve contextual units such as `em`.
  let mt = margin_top.to-absolute()
  let mb = margin_bottom.to-absolute()
  let ml = margin_left.to-absolute()
  let mr = margin_right.to-absolute()

  // For a fixed target box, fit the image to the box enlarged by the crop
  // margins, then clip the margins. This makes the remaining image still
  // cover the target box instead of looking like an already-fitted image
  // whose right edge was merely removed.
  if crop_fit and width != auto and height != auto {
    let fitted = image(
      source,
      format: format,
      width: width + ml + mr,
      height: height + mt + mb,
      alt: alt,
      page: page,
      fit: fit,
      scaling: scaling,
      icc: icc,
    )
    return box(width: width, height: height, clip: true)[
      #move(dx: -ml, dy: -mt)[#fitted]
    ]
  }

  // Relative dimensions cannot be measured before they have a layout parent.
  // Render the image at the parent's full target size, then clip the visible
  // viewport. This preserves `fit: "cover"` before applying the crop.
  if width == 100% and height == 100% {
    let relative-img = image(
      source,
      format: format,
      width: 100%,
      height: 100%,
      alt: alt,
      page: page,
      fit: fit,
      scaling: scaling,
      icc: icc,
    )
    return box(
      width: 100% - ml - mr,
      height: 100% - mt - mb,
      clip: true,
    )[
      #move(dx: -ml, dy: -mt)[#relative-img]
    ]
  }

  // Load the image at its nominal (unscaled) size. Cropping must happen in
  // this coordinate system: a 1 cm margin means removing 1 cm from the
  // nominal image, not 1 cm from an already-rescaled image.
  let raw = image(
    source,
    format: format,
    alt: alt,
    page: page,
    scaling: scaling,
    icc: icc,
  )

  // No cropping is needed in this case. Returning the image directly also
  // preserves percentage dimensions such as `width: 100%` when the image is
  // used as delayed content inside another container.
  if mt == 0pt and mb == 0pt and ml == 0pt and mr == 0pt {
    return image(
      source,
      format: format,
      width: width,
      height: height,
      alt: alt,
      page: page,
      fit: fit,
      scaling: scaling,
      icc: icc,
    )
  }

  let size = measure(raw)

  assert(
    ml + mr < size.width,
    message: "Horizontal crop margins exceed the image width.",
  )

  assert(
    mt + mb < size.height,
    message: "Vertical crop margins exceed the image height.",
  )

  let cropped-width = size.width - ml - mr
  let cropped-height = size.height - mt - mb

  // Margins define the raw-image viewport first. The requested dimensions
  // describe that cropped viewport after rescaling, so the scale is computed
  // from the cropped dimensions, not from the complete source image.
  let factor = if width != auto and height != auto {
    let x = width / cropped-width
    let y = height / cropped-height
    if fit == "cover" { if x > y { x } else { y } } else { if x < y { x } else { y } }
  } else if width != auto {
    width / cropped-width
  } else if height != auto {
    height / cropped-height
  } else {
    1
  }
  let output-width = (size.width - ml - mr) * factor
  let output-height = (size.height - mt - mb) * factor
  // Render the whole nominal source at the calculated scale, then clip its
  // raw-coordinate margins (scaled by the same factor). Using an explicitly
  // sized image is important: `scale` transforms the drawing but keeps the
  // inner layout frame at its unscaled size, which caused mismatched output
  // widths for crops with different vertical margins.
  let scaled = image(
    source,
    format: format,
    width: size.width * factor,
    height: size.height * factor,
    alt: alt,
    page: page,
    fit: "stretch",
    scaling: scaling,
    icc: icc,
  )
  box(width: output-width, height: output-height, clip: true)[
    #move(dx: -ml * factor, dy: -mt * factor)[#scaled]
  ]
}

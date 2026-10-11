#import "../foundation/theme.typ": theme

#let sidebar-row-gutters(row-count) = range(0, row-count + 1).map(index => if index == 0 { 0.12em } else { 0.05em })

/// Formats a level 1 or level 2 heading for the sidebar outline.
///
/// The generated heading text is linked to the original heading location.
/// Level 1 headings use bold body text; level 2 headings keep regular body
/// text after the numbering.
///
/// - heading-node (content): Heading node returned by `query(heading)`.
/// -> content
#let format-outline-heading(heading-node) = {
    let location = heading-node.location()
    let heading-numbers = counter(heading).at(location)
    let body = if heading-node.numbering == none {
        text(weight: "bold", heading-node.body)
    } else {
        let heading-number = numbering(heading-node.numbering, ..heading-numbers)
        text(weight: "regular", heading-number)
        if heading-node.level == 1 {
            [] + text(weight: "bold", heading-node.body)
        } else {
            h(0.3em) + text(weight: "regular", heading-node.body)
        }
    }
    link(location, body)
}

/// Finds the active level 2 heading for a page.
///
/// A subheading is active from the page where it appears until the next outline
/// heading starts. This keeps overlay pages inside the same highlighted sidebar
/// row.
///
/// - outline-headings (array): Queried level 1 and level 2 headings.
/// - current-page (int): Current page number.
/// -> none | content
#let find-active-subheading(outline-headings, current-page) = {
    let active-subheading = none
    for (index, heading-node) in outline-headings.enumerate() {
        if heading-node.level != 2 { continue }
        let start-page = counter(page).at(heading-node.location()).first()
        let next-heading = outline-headings.at(index + 1, default: none)
        let end-page = if next-heading == none {
            none
        } else {
            counter(page).at(next-heading.location()).first()
        }
        if current-page >= start-page and (end-page == none or current-page < end-page) {
            active-subheading = heading-node
        }
    }
    active-subheading
}

/// Builds table cells for the sidebar outline.
///
/// The returned dictionary contains the cells and the table row that should be
/// filled with the active color.
///
/// - outline-headings (array): Queried level 1 and level 2 headings.
/// - active-subheading (none, content): Active level 2 heading, if any.
/// - show-text (bool): Whether to render the row labels.
/// -> dictionary
#let build-outline-cells(outline-headings, active-subheading, show-text: true) = {
    let fonts = theme.fonts
    let cells = ()
    let active-row = none
    for (index, heading-node) in outline-headings.enumerate() {
        let row = cells.len() + 1
        let is-active = (
            active-subheading != none
                and heading-node.level == 2
                and heading-node.location() == active-subheading.location()
        )
        if is-active {
            active-row = row
        }
        let cell-body = if show-text {
            text(
                font: fonts.outline,
                size: 18pt,
                fill: if is-active { white } else { black },
                format-outline-heading(heading-node),
            )
        } else {
            []
        }
        cells.push(
            table.cell(
                align: if heading-node.level == 1 { center + horizon } else { left + horizon },
                inset: (x: 5pt, y: 1pt),
                cell-body,
            ),
        )
        if heading-node.level == 2 {
            let next-heading = outline-headings.at(index + 1, default: none)
            if next-heading != none and next-heading.level == 1 {
                cells.push(table.cell([]))
            }
        }
    }
    (cells: cells, active-row: active-row)
}

/// Renders a sidebar table layer.
///
/// The `fill-mode` controls which row backgrounds are drawn:
/// `"full"` draws the normal sidebar fills, `"base"` skips the active row, and
/// `"active"` only draws the active row fill. This lets the theme interleave
/// the decorative ring between normal row fills and the active row.
///
/// `setup()` calls this internally. It is documented because the sidebar is the
/// most template-specific component and is useful when customizing the theme.
///
/// - title (str): Sidebar title, usually the presentation subtitle.
/// - author (str): Author name shown in the footer.
/// - date (datetime): Date shown in the footer.
/// - fill-mode (str): Either `"full"`, `"base"`, or `"active"`.
/// - show-text (bool): Whether to render title, outline labels, and footer.
/// -> content
#let render-sidebar(title, author, date, fill-mode: "full", show-text: true) = context {
    let colors = theme.colors
    let outline-headings = query(heading.where(outlined: true)).filter(heading-node => heading-node.level <= 2)
    let current-page = counter(page).get().first()
    let active-subheading = find-active-subheading(outline-headings, current-page)
    let outline = build-outline-cells(outline-headings, active-subheading, show-text: show-text)
    let row-count = outline.cells.len()
    let row-fill = (_, row) => if outline.active-row != none and row == outline.active-row {
        if fill-mode == "base" {
            none
        } else {
            colors.primary
        }
    } else if fill-mode == "active" {
        none
    } else if row == 0 {
        colors.primary-soft
    } else {
        colors.primary-muted
    }
    table(
        columns: (1fr,),
        rows: (1fr,) * (row-count + 2),
        fill: row-fill,
        row-gutter: sidebar-row-gutters(row-count),
        stroke: none,
        align: center + horizon,
        table.cell(if show-text { text(size: 20pt, weight: "bold", title) } else { [] }),
        ..outline.cells,
        table.cell(if show-text {
            text(size: 12pt, fill: colors.meta)[#author #h(0.4em) #date.display("[year].[month]")]
        } else { [] }),
    )
}

/// Masks sidebar gutters above the decorative ring.
///
/// The mask follows the same row-gutter sequence as the sidebar table and adds
/// a thin right and bottom edge so the ring remains clipped by the table gaps.
///
/// - width (length): Width of the sidebar block.
/// - height (length): Height of the sidebar block.
/// - edge-gutter (length): Thickness of the right and bottom masks.
/// -> content
#let render-sidebar-gap-mask(width, height, edge-gutter: 0.05em) = context {
    let outline-headings = query(heading.where(outlined: true)).filter(heading-node => heading-node.level <= 2)
    let row-count = 0
    for (index, heading-node) in outline-headings.enumerate() {
        row-count = row-count + 1
        if heading-node.level == 2 {
            let next-heading = outline-headings.at(index + 1, default: none)
            if next-heading != none and next-heading.level == 1 {
                row-count = row-count + 1
            }
        }
    }
    let total-rows = row-count + 2
    let gutters = sidebar-row-gutters(row-count)
    let total-gutter-height = 0pt
    for gutter in gutters {
        total-gutter-height = total-gutter-height + gutter
    }
    let row-height = (height - total-gutter-height) / total-rows
    let y = row-height
    for gutter in gutters {
        place(top + left, dx: 0pt, dy: y, rect(width: width, height: gutter, fill: white, stroke: none))
        y = y + gutter + row-height
    }
    place(top + left, dx: width - edge-gutter, dy: 0pt, rect(width: edge-gutter, height: height, fill: white, stroke: none))
    place(top + left, dx: 0pt, dy: height - edge-gutter, rect(width: width, height: edge-gutter, fill: white, stroke: none))
}

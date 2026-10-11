#import "@preview/numbly:0.1.0": *
#import "components/cover.typ": render-cover
#import "components/sidebar.typ": render-sidebar, render-sidebar-gap-mask
#import "foundation/theme.typ": theme
#import "core/overlays.typ": render-overlays
#import "utils/draw.typ": place-circle

#let render-sidebar-circles() = {
    place-circle(
        32.2cm + 3.56cm / 2,
        17.7cm + 3.56cm / 2,
        3.56cm / 2,
        fill: theme.colors.primary,
        stroke: none,
    )
    place-circle(
        32.2cm + 3.56cm / 2,
        17.7cm + 3.56cm / 2,
        1cm,
        fill: rgb("e6c2c4"),
        stroke: none,
    )
}

/// Applies the SDU OS slide theme to the document.
///
/// The setup function renders a cover page, configures the slide canvas,
/// installs the heading styles, and enables overlay rendering through
/// `pause`, `meanwhile`, and `jump`.
///
/// Headings always start a new page. Level 3 and deeper headings are rendered
/// as centered in-slide titles.
///
/// ```typ
/// #import "slide.typ": setup, pause
///
/// #show: setup.with(
///   title: "Operating Systems",
///   subtitle: "Scheduling",
///   author: "arshtyi",
///   term: "2026 Spring",
/// )
///
/// = CPU Scheduling
/// == Round Robin
///
/// The ready queue is served by time slices.
///
/// #pause
///
/// A smaller quantum improves response time but raises switching overhead.
/// ```
///
/// - author (str): Author name shown on the cover and sidebar.
/// - term (str): Course term shown on the cover.
/// - title (str): Presentation title shown on the cover.
/// - subtitle (str): Subtitle shown on the cover and sidebar.
/// - date (datetime): Date shown in the sidebar.
/// - handout (bool): Whether to render only the final overlay state of each slide.
/// - sidebar-ring-style (int): `1` draws the decorative ring above the sidebar; `2` interleaves the ring with sidebar fills, active row, and gutters.
/// - body (content): Presentation body.
/// -> content
#let setup(
    author: "arshtyi",
    term: "2026 Spring",
    title: "SDU OS Slide",
    subtitle: "Slide for SDU OS",
    date: datetime.today(),
    handout: false,
    sidebar-ring-style: 1,
    body,
) = {
    set document(title: title, author: author, date: date, description: subtitle)
    let colors = theme.colors
    let page-config = theme.page
    let sidebar-x = 27.12cm
    let sidebar-y = 1.88cm
    let sidebar-width = page-config.sidebar-width - 0.35pt
    let sidebar-height = page-config.sidebar-height - 0.6pt
    let place-sidebar(body) = place(
        dx: sidebar-x,
        dy: sidebar-y,
        block(width: sidebar-width, height: sidebar-height, body),
    )
    set page(
        width: page-config.width,
        height: page-config.height,
        margin: 0cm,
    )
    render-cover(
        title: title,
        subtitle: subtitle,
        author: author,
        term: term,
    )
    set heading(numbering: numbly(
        "{1:一}、",
        "{1:1}.{2:1} ",
        "",
    ))
    show heading: heading-node => {
        pagebreak(weak: true)
        if heading-node.level > 2 {
            set align(center)
            text(size: 20pt, fill: theme.colors.primary, heading-node)
        }
    }
    show heading.where(level: 3): set block(below: 2em)
    set page(
        margin: (
            right: page-config.sidebar-width + 1cm,
            left: 1cm,
            top: 1cm,
            bottom: 1cm,
        ),
        foreground: {
            place(
                dx: 27.44cm,
                dy: 0.1cm,
                image("../assets/sdu.png", width: 6.02cm, height: 1.59cm),
            )
            if sidebar-ring-style == 2 {
                place-sidebar(render-sidebar(subtitle, author, date, fill-mode: "base", show-text: false))
                render-sidebar-circles()
                place-sidebar({
                    render-sidebar(subtitle, author, date, fill-mode: "active")
                    render-sidebar-gap-mask(sidebar-width, sidebar-height)
                })
            } else {
                place-sidebar(render-sidebar(subtitle, author, date))
                render-sidebar-circles()
            }
            place(
                dx: 0.07cm,
                dy: 0.1cm,
                rect(
                    width: page-config.frame-width,
                    height: page-config.frame-height,
                    radius: 10pt,
                    stroke: 2.5pt + colors.primary,
                ),
            )
        },
    )
    set text(size: 20pt, font: theme.fonts.content, weight: "medium")
    set par(justify: true)
    set underline(stroke: 0.05em, offset: 0.25em)
    show raw: set text(font: theme.fonts.raw)
    show raw.where(block: false): box.with(
        fill: luma(240),
        inset: (x: 0.3em, y: 0em),
        outset: (x: 0em, y: 0.3em),
        radius: 0.2em,
    )
    show raw.where(block: true): block.with(
        fill: luma(248),
        stroke: 0.5pt + colors.neutral-soft,
        inset: 0.7em,
        radius: 4pt,
    )
    render-overlays(body, handout: handout)
}

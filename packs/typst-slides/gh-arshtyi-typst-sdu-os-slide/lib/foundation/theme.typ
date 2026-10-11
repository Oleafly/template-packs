/// Shared visual constants for the SDU OS slide theme.
///
/// The dictionary contains font families, colors, and page dimensions used by
/// the cover, sidebar, frame, and body text.
///
/// ```typ
/// #import "slide.typ": theme
///
/// #text(fill: theme.colors.primary)[Important]
/// #rect(width: theme.page.sidebar-width, height: 1cm)
/// ```
///
/// -> dictionary
#let theme = (
    fonts: (
        cover: "LXGW WenKai",
        outline: "Noto Sans CJK SC",
        content: ("LXGW WenKai", (name: "Libertinus Serif", covers: "latin-in-cjk")),
        raw: ("IBM Plex Mono", "Noto Sans CJK SC"),
    ),
    colors: (
        primary: rgb("9c0b15"),
        primary-soft: rgb("ce858a"),
        primary-muted: rgb("e6c2c4"),
        neutral: rgb("d9d9d9"),
        neutral-soft: rgb("bfbfbf"),
        meta: rgb("a6a6a6"),
    ),
    page: (
        width: 33.87cm,
        height: 19.05cm,
        frame-width: 27.06cm,
        frame-height: 18.74cm,
        sidebar-width: 6.75cm,
        sidebar-height: 17.2cm,
    ),
)

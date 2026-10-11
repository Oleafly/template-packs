// tufte-original: Tufte-LaTeX `tufte-handout` ported to Typst. It is the
// base style: every other style file holds only its differences from it.
//
// colors: hex strings. PDF reads bg (`none`: no fill), fg and link. HTML
//   writes every key as `var(--<key>)`. The "full" overlay also reads
//   heading and note (default fg), meta (default heading, then fg) and
//   quote (default inherited).
//
// toc: title and depth apply to PDF; the HTML list has every heading.
//
// html:
//   css       tufte-css stylesheets
//   sheets    extra stylesheets, e.g. web fonts
//   overlay   none; "links": plain link underline; "full": colours, links, mobile layout
//   extra     CSS
//
// typography.print roles: body, note, caption, quote, code, h1..h3,
// title, meta, header, marks, newthought, list.
//   body.size, body.line        lengths; line is baseline to baseline
//   size, left, right, indent   factor of body.size (also list indents)
//   line, before, after, par    factor of body.line, baseline to baseline
//   weight                      number, 400 regular to 700 bold
//   kern                        space before a heading
//   sep                         space after a note number; between meta items
//   code.inline                 em of the surrounding text
//   header.upper                uppercase the running header
//   marks.anchor, marks.margin  note number size in the text and in the margin
//   newthought.lower            size of lowercase letters set as capitals
//   a length                    used as given
// A missing font is the body font; a caption takes the note font and style.
// Measured per font: marks and newthought keep numeral and small-cap height
// over body x-height as here; code.inline matches the surrounding x-height.
//
// typography.web roles: body, note (also captions), quote, code, title,
// meta, h1..h3, newthought.
//   size           px, or (a, b): a at a 375px window, b at 1440px
//   line           px when an int, factor of size when a float
//   weight         number
//   track          em
//   before, after  margin in px
//   code.inline    em of the surrounding text
//   code.font      goes on inline and block code; other code fields on `pre`
// A missing web role keeps the stylesheet value.

#let tufte-original = (
    // Geometry from tufte-common.def:446: left=1in, textwidth=26pc
    // (4.33in), marginparsep=2pc (0.33in), marginparwidth=12pc (2in).
    page: (paper: "us-letter", margin-x: 1in, margin-y: 1in),
    margin-col: (width: 2in, sep: 0.333in),
    abstract: (v-after: 1.5em),
    toc: (title: [Contents], depth: 2, v-after: 1.5em),
    text: (justify: true),
    link: (underline: true),
    colors: (bg: "#fffff8", fg: "#111111", link: "#111111"),
    html: (
        color-scheme: "light dark",
        css: ("https://cdnjs.cloudflare.com/ajax/libs/tufte-css/1.8.0/tufte.min.css",),
        sheets: (),
        overlay: none,
        extra: "",
    ),
    typography: (
        // 10/14 body, 8pt notes (tufte-common.def:367-389).
        print: (
            body:    (font: ("ETBembo", "Palatino", "Georgia"), size: 10pt, line: 14.5pt, par: 1.38, indent: 1.2),
            note:    (style: "normal", size: 0.80, line: 0.66, sep: 0.3em),
            caption: (size: 0.80, line: 0.72),
            quote:   (style: "italic", size: 1.05, line: 0.93, before: 2.96, after: 2.38, left: 1.8, right: 1.0),
            code:    (font: ("Roboto Mono", "Menlo", "Monaco", "Courier"), size: 0.69, line: 0.62, before: 1.50, after: 1.63, left: 1.36, right: 0.64, inline: 0.76),
            h1:      (weight: 400, style: "italic", size: 1.20, line: 1.0, before: 2.81, after: 1.79, kern: -0.1em),
            h2:      (weight: 400, style: "italic", size: 1.10, line: 1.0, before: 1.82, after: 1.61, kern: 0em),
            h3:      (weight: 400, style: "italic", size: 1.00, line: 1.0, before: 1.66, after: 1.45, kern: 0em),
            title:   (weight: 400, size: 1.40, line: 1.2, after: 1.59, kern: -0.1em),
            meta:    (style: "italic", size: 0.90, after: 2.24, sep: 0em),
            header:  (weight: 400, size: 8pt, track: 1.5pt, upper: true, after: 20pt),
            marks:   (anchor: 0.7em, margin: 0.85em),
            newthought: (lower: 0.78),
            list:    (indent: 1.0, body-indent: 1.0),
        ),
        web: (
            code: (inline: 0.85),
        ),
    ),
)

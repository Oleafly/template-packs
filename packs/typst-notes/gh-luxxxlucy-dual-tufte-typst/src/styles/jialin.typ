// jialin: personal handout. The PDF is compact; the HTML is more open
// for screen reading.

#let _gill-print = ("Gill Sans", "Helvetica")
#let _gill = "Gill Sans, Avenir Next, system-ui, sans-serif"

#let jialin = (
    page: (margin-x: 0.68in, margin-y: 2cm),
    margin-col: (width: 2.25in, sep: 0.7in),
    colors: (bg: "#FFFFFB", fg: "#242424", link: "#2557C7", note: "#5B6370", meta: "#505866"),
    html: (
        color-scheme: "light",
        overlay: "full",
        extra: ```css
            article p.subtitle { margin-top: 0.25rem; }
            article .epigraph + h1 { margin-top: 1.9rem; }
        ```.text,
    ),
    typography: (
        print: (
            body:    (size: 9pt, line: 13pt, indent: 0),
            note:    (font: _gill-print, style: "italic", size: 0.68, line: 0.55, sep: 0.35em),
            caption: (line: 0.66),
            quote:   (size: 1.00, line: 0.88, before: 2.83, after: 2.28, left: 1.5),
            code:    (font: ("Berkeley Mono", "Menlo", "Monaco", "Courier"), size: 0.72, line: 0.68, before: 1.46, after: 1.59, left: 1.0, right: 0.56, inline: 0.8),
            h1:      (size: 1.30, line: 1.1, before: 2.20, after: 1.67, kern: -0.05em),
            h2:      (size: 1.12, after: 1.56),
            h3:      (before: 1.62),
            title:   (font: _gill-print, size: 1.65, line: 1.35),
            meta:    (font: _gill-print, style: "normal", size: 0.80, after: 2.31, sep: 1.1em),
            header:  (font: ("Berkeley Mono", "Menlo", "Monaco"), weight: 700, size: 5pt, track: 1.25pt, after: 11.75pt),
            marks:   (margin: 0.91em),
        ),
        web: (
            body:    (font: "et-book, Palatino, Georgia, serif", size: 21, line: 30),
            note:    (size: 16, line: 23),
            code:    (font: "Berkeley Mono, Menlo, Monaco, ui-monospace, monospace", size: 15, line: 22, inline: 0.72),
            title:   (font: _gill, size: (28, 36), line: 1.12, track: 0, before: 45, after: 5),
            meta:    (font: _gill, style: "normal", size: 14, line: 19),
            h1:      (font: _gill, style: "italic", size: (22, 25), line: 1.25, track: 0, before: 30, after: 7),
            h2:      (font: _gill, style: "italic", size: (20, 22), line: 1.3, before: 25),
            h3:      (font: _gill, style: "italic", size: 19, line: 1.35),
            newthought: (font: _gill),
        ),
    ),
)

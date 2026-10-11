// orange-happy: warm editorial style. Source Serif text, Public Sans
// headings and notes, Newsreader title.

#let _public-sans-print = ("Public Sans", "Helvetica Neue", "Helvetica", "Arial")
#let _newsreader-print = ("Newsreader", "Source Serif 4", "Georgia", "Palatino")
#let _public-sans ="'Public Sans', system-ui, sans-serif"
#let _newsreader = "'Newsreader', Georgia, serif"

#let orange-happy = (
    colors: (bg: "#F7F2EA", fg: "#2F2A24", link: "#A85428", heading: "#2A2018", note: "#6D6257", quote: "#625447", rule: "#d9cdb8"),
    html: (
        color-scheme: "light",
        sheets: ("https://fonts.googleapis.com/css2?family=Newsreader:ital,opsz,wght@0,6..72,400;0,6..72,500;0,6..72,600;1,6..72,400&family=Public+Sans:ital,wght@0,400;0,500;0,600;1,400&family=JetBrains+Mono:wght@400;500&family=Source+Serif+4:ital,wght@0,400;0,500;1,400&display=swap",),
        overlay: "full",
        extra: ```css
            body { font-optical-sizing: auto; }
            article p.subtitle { margin-top: 0.25rem; }
            article .epigraph + h1 { margin-top: 1.95rem; }
            article blockquote, article blockquote p { border-left: none; }
            article blockquote { padding-left: 1em; padding-right: 1em; }
            hr { border: none; border-top: 1px solid var(--rule); width: 36%; margin: 1.8em auto; }
        ```.text,
    ),
    typography: (
        print: (
            body:    (font: ("Source Serif 4", "Georgia", "Palatino"), size: 9.8pt, line: 13pt, par: 1.42),
            note:    (font: _public-sans-print, size: 0.76),
            caption: (size: 0.78),
            quote:   (size: 0.90, line: 0.74, before: 2.84, after: 2.31, left: 1.45, right: 0.9),
            code:    (font: ("JetBrains Mono", "Menlo", "Monaco", "Courier"), size: 0.81, line: 0.79, before: 1.59, left: 1.04, right: 0.6, inline: 0.89),
            h1:      (style: "normal", size: 1.08, before: 2.10, after: 1.65),
            h2:      (style: "normal", size: 1.00, before: 1.76, after: 1.53),
            h3:      (style: "normal", before: 1.72, after: 1.49),
            title:   (font: _newsreader-print, weight: 500, size: 1.34, after: 1.64),
            meta:    (font: _public-sans-print, style: "normal", size: 0.78, after: 2.17),
            header:  (font: _newsreader-print),
            marks:   (anchor: 0.81em, margin: 1.03em),
            newthought: (lower: 0.90),
        ),
        web: (
            body:    (font: "'Source Serif 4', Georgia, serif", size: 18, line: 29),
            note:    (font: _public-sans, size: 14, line: 22),
            quote:   (style: "italic", size: 16, line: 26),
            code:    (font: "'JetBrains Mono', ui-monospace, monospace", size: 14, line: 22, inline: 0.81),
            title:   (font: _newsreader, size: (32, 40), line: 1.1, before: 46, after: 5),
            meta:    (font: _public-sans, style: "normal", size: 14, line: 19),
            h1:      (font: _public-sans, size: (21, 24), line: 1.25, before: 32, after: 7),
            h2:      (font: _public-sans, size: (18, 20), line: 1.35),
            h3:      (font: _public-sans, size: 17, line: 1.4),
            newthought: (font: _newsreader),
        ),
    ),
)

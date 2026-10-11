// terpret: plain technical style. Inter text, Space Grotesk title,
// JetBrains Mono code.

#let _space-grotesk-print = ("Space Grotesk", "Inter", "Helvetica Neue", "Helvetica", "Arial")
#let _space-grotesk ="'Space Grotesk', 'Inter', system-ui, sans-serif"

#let terpret = (
    colors: (bg: "#FAFAF8", fg: "#1B1B1F", link: "#1F6FEB", heading: "#182338", note: "#4A4A52", rule: "#E1DED4", code-bg: "#F1F0E8"),
    html: (
        color-scheme: "light",
        sheets: ("https://fonts.googleapis.com/css2?family=Inter:wght@400;500&family=Space+Grotesk:wght@500;700&family=JetBrains+Mono:wght@400;700&display=swap",),
        overlay: "full",
        extra: ```css
            article p.subtitle { margin-top: 0.25rem; }
            article .epigraph + h1 { margin-top: 2rem; }
            article h2 { border-bottom: 1px solid var(--rule); padding-bottom: 0.18em; }
            code:not(pre code) { background: var(--code-bg); padding: 0.08em 0.28em; border-radius: 3px; }
        ```.text,
    ),
    typography: (
        print: (
            body:    (font: ("Inter", "Helvetica Neue", "Helvetica", "Arial"), size: 9.4pt, line: 13pt, par: 1.40),
            note:    (size: 0.76, line: 0.63),
            caption: (size: 0.78, line: 0.69),
            quote:   (size: 0.88, line: 0.72, before: 2.73, after: 2.26, left: 1.35, right: 0.9),
            code:    (font: ("JetBrains Mono", "Menlo", "Monaco", "Courier"), size: 0.84, line: 0.79, before: 1.52, after: 1.61, left: 1.0, right: 0.56, inline: 0.94),
            h1:      (weight: 500, style: "normal", size: 1.12, before: 2.14, after: 1.67),
            h2:      (weight: 500, style: "normal", size: 1.00, before: 1.73, after: 1.51),
            h3:      (weight: 500, style: "normal", before: 1.69, after: 1.47),
            title:   (font: _space-grotesk-print, weight: 500, size: 1.24, after: 1.62),
            meta:    (style: "normal", size: 0.76, after: 2.13),
            header:  (font: _space-grotesk-print),
            marks:   (anchor: 0.76em, margin: 0.92em),
            newthought: (lower: 0.87),
        ),
        web: (
            body:    (font: "'Inter', system-ui, sans-serif", size: 17, line: 27),
            note:    (size: 14, line: 22),
            quote:   (size: 15, line: 23),
            code:    (font: "'JetBrains Mono', ui-monospace, monospace", size: 14, line: 22, inline: 0.84),
            title:   (font: _space-grotesk, size: (30, 40), line: 1.12, before: 48, after: 5),
            meta:    (style: "normal", size: 14, line: 20),
            h1:      (font: _space-grotesk, size: (22, 26), line: 1.25, before: 33, after: 7),
            h2:      (font: _space-grotesk, size: (18, 20), line: 1.35, before: 28),
            h3:      (font: _space-grotesk, size: 17, line: 1.4),
            newthought: (font: _space-grotesk),
        ),
    ),
)

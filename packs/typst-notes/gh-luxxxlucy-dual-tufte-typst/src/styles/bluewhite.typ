// bluewhite: clean ML blog style after the OpenAI and Sakana blogs.

#let _inter = "Inter, 'OpenAI Sans', 'Public Sans', system-ui, sans-serif"

#let bluewhite = (
    link: (underline: false),
    colors: (bg: "#FFFFFF", fg: "#17191F", link: "#315E9F", heading: "#111318", note: "#687385", meta: "#596273", quote: "#687385"),
    html: (
        color-scheme: "light",
        sheets: ("https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=JetBrains+Mono:wght@400;500&display=swap",),
        overlay: "full",
        extra: ```css
            body { font-optical-sizing: auto; }
            article p.subtitle { margin-top: 0.25rem; }
            article .epigraph + h1 { margin-top: 1.95rem; }
        ```.text,
    ),
    typography: (
        print: (
            body:    (font: ("Inter", "Helvetica Neue", "Helvetica", "Arial"), size: 9.5pt, line: 13pt, par: 1.40),
            note:    (size: 0.76, line: 0.63),
            caption: (size: 0.78, line: 0.69),
            quote:   (size: 0.88, line: 0.73, before: 2.75, after: 2.26, left: 1.45, right: 0.9),
            code:    (font: ("JetBrains Mono", "Menlo", "Monaco", "Courier"), size: 0.84, line: 0.80, before: 1.52, after: 1.61, left: 1.04, right: 0.6, inline: 0.94),
            h1:      (weight: 500, style: "normal", size: 1.12, before: 2.18, after: 1.67),
            h2:      (weight: 500, style: "normal", size: 1.00, before: 1.73, after: 1.51),
            h3:      (weight: 500, style: "normal", before: 1.69, after: 1.47),
            title:   (weight: 600, size: 1.36, after: 1.62),
            meta:    (style: "normal", size: 0.76, after: 2.12),
            marks:   (anchor: 0.76em, margin: 0.92em),
            newthought: (lower: 0.87),
        ),
        // After the OpenAI blog type scale.
        web: (
            body:    (font: _inter, size: 17, line: 28),
            note:    (size: 14, line: 22),
            quote:   (style: "italic", size: 15, line: 24),
            code:    (font: "'JetBrains Mono', ui-monospace, monospace", size: 14, line: 22, inline: 0.84),
            title:   (weight: 500, size: (32, 44), line: 1.1, track: -0.02, before: 46, after: 5),
            meta:    (style: "normal", size: 14, line: 20),
            h1:      (weight: 500, size: (24, 30), line: 1.25, track: -0.01, before: 32, after: 7),
            h2:      (weight: 500, size: (20, 22), line: 1.3, track: -0.01, before: 28),
            h3:      (weight: 500, size: (17, 18), line: 1.4),
        ),
    ),
)

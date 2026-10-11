// rosa: after David Álvarez Rosa's site (https://david.alvarezrosa.com/).

#let _alegreya-sc-print = ("Alegreya SC", "Alegreya", "Georgia")
#let _alegreya-sc ="'Alegreya SC', serif"

#let rosa = (
    link: (underline: false),
    colors: (bg: "#FCFCFC", fg: "#111111", link: "#003366", accent: "#660000", rule: "#ccc"),
    html: (
        color-scheme: "light",
        sheets: ("https://fonts.googleapis.com/css2?family=Alegreya:ital,wght@0,400..900;1,400..900&family=Alegreya+SC:wght@400;500;700&family=Inconsolata:wght@400..700&display=swap",),
        overlay: "full",
        extra: ```css
            code:not(pre code) { color: var(--accent); font-weight: 530; }
            .sidenote-number:after, .sidenote:before { color: var(--accent); }
            pre { border: 1px solid var(--rule); border-left: 3px solid var(--rule); }
        ```.text,
    ),
    typography: (
        print: (
            body:    (font: ("Alegreya", "Georgia", "Palatino"), size: 9.5pt, line: 13.6pt, par: 1.6, indent: 0),
            note:    (size: 0.79, line: 0.77),
            caption: (size: 0.79, line: 0.77),
            quote:   (size: 1.00, line: 1.0, before: 2.4, after: 2.0, left: 1.5),
            code:    (font: ("Inconsolata", "Menlo", "Monaco"), size: 0.82, line: 0.74, before: 1.6, after: 1.6, left: 1.0, right: 0.5, inline: 1.0),
            h1:      (font: _alegreya-sc-print, weight: 700, style: "normal", size: 1.14, before: 2.2, after: 1.4, kern: 0em),
            h2:      (font: _alegreya-sc-print, weight: 700, style: "normal", size: 1.00, before: 1.8, after: 1.4),
            h3:      (before: 1.6, after: 1.4),
            title:   (font: _alegreya-sc-print, size: 2.00, line: 1.1, after: 1.8, kern: 0em),
            meta:    (after: 2.4, sep: 1em),
            header:  (font: _alegreya-sc-print, track: 0.5pt, upper: false),
            marks:   (anchor: 0.82em, margin: 0.99em),
            newthought: (lower: 0.86),
        ),
        web: (
            body:    (font: "'Alegreya', serif", weight: 440, size: 21, line: 30),
            note:    (size: 16.5, line: 23),
            code:    (font: "'Inconsolata', monospace", size: 17, line: 24, inline: 0.94),
            title:   (font: _alegreya-sc, weight: 420, size: (32, 42), line: 1.1, track: 0.02, before: 45, after: 33),
            meta:    (style: "italic", size: 18, line: 26),
            h1:      (font: _alegreya-sc, weight: 700, size: 24, line: 1.2, track: -0.013, before: 36, after: 10),
            h2:      (font: _alegreya-sc, weight: 700, size: 21, line: 1.25, before: 30),
            h3:      (style: "italic", size: 21, line: 1.3),
            newthought: (font: _alegreya-sc),
        ),
    ),
)

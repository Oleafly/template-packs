// --- THÈMES ---
#import "themes/cea/theme.typ": cea-theme

// --- TEMPLATES ---
#import "templates/cover-letter.typ": cover-letter
#import "templates/report.typ": report, part_cover, glossary_page
#import "templates/slides.typ": slides, title-slide, outline-slide, slide, end-slide
#import "templates/resume.typ": *


// --- ALIAS ---
#let cea-report = report.with(theme: cea-theme)
#let cea-slides = slides.with(theme: cea-theme)
#let cea-cover-letter = cover-letter.with(theme: cea-theme)
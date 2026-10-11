// tubci – Typst templates in the corporate design of TU Berlin.
#import "colors.typ": tub-cmyk, tub-colors, tub-gradients, tub-rgb
#import "core.typ": tub-logo
#import "brochure.typ": back-page, picture-page, title-page, tub-brochure, tub-claim
#import "slides.typ": alert, focus-slide, section-slide, slide, title-slide, tub-slides

// Overlay helpers for slides, see the polylux documentation.
#import "@preview/polylux:0.4.0"
#import polylux: alternatives, item-by-item, later, one-by-one, only, reveal-code, toolbox, uncover
#let side-by-side = toolbox.side-by-side
#let speaker-note = toolbox.pdfpc.speaker-note

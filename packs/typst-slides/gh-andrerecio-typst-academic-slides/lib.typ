// brownbag — a minimal Touying theme for academic talks.
//
// This file is the whole public surface. Design tokens in `src/tokens.typ`
// are deliberately not exported.

#import "src/theme.typ": brownbag-theme
#import "src/slides.typ": focus-slide, slide, title-slide
#import "src/components.typ": goto, keypoint, muted, source
#import "src/figures.typ": cols
#import "src/statements.typ": (
  assumption, corollary, definition, example, lemma, proof, proposition,
  remark, theorem,
)

// The Touying names an author needs, so a deck has a single import line.
#import "@preview/touying:0.7.4": (
  alert, alternatives, appendix, components, config-colors, config-common,
  config-info, config-methods, config-page, config-store, empty-slide,
  item-by-item, meanwhile, only, pause, speaker-note, uncover, utils,
)

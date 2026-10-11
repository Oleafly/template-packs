// Template core. Nothing here knows which thesis it is rendering -- every
// entry point takes a config, and the caller decides where that comes from.

#import "config.typ": load
#import "template.typ": thesis
#import "cite.typ": c, ca, cp, cy, references
#import "sections.typ": abstract-en, abstract-zh, acknowledgement, denotation
#import "util.typ": eq-numbering, fill, merge, month-name, roc-year, spread

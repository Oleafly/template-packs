#import "../template.typ": section-title

#let abstract(config) = {
  section-title(config, [Abstract])
  set par(justify: true, leading: config.style.leading)
  config.abstract
}

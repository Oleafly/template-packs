// clinical-case-spread — lives in bookkit-didactics (depends on clinical-case)
#import "/packages/bookkit/theme.typ": fonts, gradients, palette, space, type-scale
#import "/packages/bookkit/components/spreads.typ": feature-spread
#import "didactics.typ": clinical-case

#let clinical-case-spread(
  title: none,
  anamnese: none,
  befund: none,
  diagnose: none,
  therapie: none,
  left-extra: none,
  discussion: none,
  right-extra: none,
) = feature-spread(
  title: title,
  {
    clinical-case(
      anamnese: anamnese,
      befund: befund,
      diagnose: diagnose,
      therapie: therapie,
    )
    if left-extra != none { left-extra }
  },
  {
    block(below: space.md, text(size: type-scale.h3, weight: "bold", font: fonts.sans, fill: palette.primary)[Diskussion])
    discussion
    if right-extra != none { right-extra }
  },
)

#import "../../macros/formatting.typ" as fmt

== Formatting helpers

The formatting module provides callouts, semantic emphasis helpers, horizontal rules, and vertical spacing.

#fmt.note([This is a note callout.])

#fmt.warning([This is a warning callout.])

#fmt.todo([This is a TODO callout.])

#fmt.callout("Custom callout.", [This uses the generic `callout` helper with a custom fill.], rgb("#eef7ee"))

A #fmt.term([term]) is emphasized, while a #fmt.key([key phrase]) is strong.

#fmt.hr()

There is extra vertical space below this sentence.

#fmt.space(amount: 1.5em)

The text continues after `#fmt.space(amount: 1.5em)`.

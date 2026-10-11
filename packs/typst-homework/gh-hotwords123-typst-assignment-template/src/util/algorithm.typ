// Procedure call: `proc(..args)`.
#let call(proc, ..args) = smallcaps(proc) + $($ + args.pos().join([, ]) + $)$

// Style registry. A style is data about looks: each file overrides the
// `tufte-original` base record.

#import "tufte-original.typ": tufte-original
#import "jialin.typ": jialin
#import "envision.typ": envision
#import "terpret.typ": terpret
#import "orange-happy.typ": orange-happy
#import "bluewhite.typ": bluewhite
#import "rosa.typ": rosa

#let registry = (
    jialin: jialin,
    tufte-original: tufte-original,
    envision: envision,
    terpret: terpret,
    orange-happy: orange-happy,
    bluewhite: bluewhite,
    rosa: rosa,
)

// A name picks a registered style; a record is used as given.
#let resolve(style) = {
    if type(style) != str { return style }
    assert(style in registry, message: "unknown style: " + style + "  (known: " + registry.keys().join(", ") + ")")
    registry.at(style)
}

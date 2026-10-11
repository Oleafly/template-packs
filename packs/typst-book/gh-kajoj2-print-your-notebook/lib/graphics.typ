// Importing graphics from Affinity (SVG export to assets/svg/).
// Export tips: units in mm, "Rasterise: nothing", text converted to curves
// (or a font that's in fonts/).

#let asset(name, ..args) = image("/assets/svg/" + name + ".svg", ..args)

// A full-page graphic behind the content (e.g. a cover). Usage:
//   #page(background: page-background("cover"))[…]
// Note: anything closer than ~4.2 mm to the sheet edge won't print.
#let page-background(name) = asset(name, width: 100%, height: 100%, fit: "stretch")

// An ornament, centred horizontally.
#let ornament(name, width: 30mm) = align(center, asset(name, width: width))

// Hacky workaround for colorizing the SVG file
#let colorized-image(path, color: black, original_color: "", ..args) = {
  let raw = read(path).replace(original_color, color.to-hex())
  image(bytes(raw), ..args.named())
}

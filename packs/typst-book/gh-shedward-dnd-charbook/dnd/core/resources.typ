#let icon(name, ..args) = context {
    let resolvedArgs = if (args.named().len() == 0) {
      let fontSize = text.size
      let baseline = 1pt
      (height: fontSize - baseline, baseline: baseline)
    } else {
      args
    }

    box(image("/resources/icons/" + name + ".svg"), ..resolvedArgs)
  }


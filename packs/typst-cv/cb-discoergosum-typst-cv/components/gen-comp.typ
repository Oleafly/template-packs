#import "@preview/nerd-icons:0.2.0": change-nerd-font, nf-icon
#let metadata = toml("../meta.toml")

#let base-color = rgb(metadata.style.base_color)
#let base-font = metadata.style.base_font
#let accent-color = rgb(metadata.style.accent_color)
#let accent-font = metadata.style.accent_font


#let h-bar = [#h(0.5em) | #h(0.5em)]

#let icon(str) = {
  change-nerd-font("Hack Nerd Font Mono")
  text(
    size: 1.8em,
    baseline: 0.15em,
    nf-icon(str) + " ",
  )
}

#let header = {
  stack(
    block(
      fill: accent-color,
      inset: 1em,
      text(
        font: accent-font,
        weight: "bold",
        size: 3.2em,
        fill: rgb("#ffffff"),
        metadata.personnal.name,
      ),
    ),
    v(0.7em),
    [#metadata.personnal.adress.street ・ #metadata.personnal.adress.zipcode
      #metadata.personnal.adress.city],
    icon("nf-oct-mail")
      + metadata.personnal.infos.email
      + h-bar
      + icon("nf-md-phone_classic")
      + metadata.personnal.infos.phone
      + h-bar
      + icon("nf-dev-github")
      + link(
        "https://github.com/" + metadata.personnal.infos.github,
      )[#metadata.personnal.infos.github],
  )
}

/// Generat the footer Content.
///
/// - doc-name (str): The name of the of the document or the a text in the middel
/// -> content of the footer
#let footer(doc-name) = context {
  let footerStyle(str) = {
    text(size: 0.8em, fill: accent-color.lighten(45%), smallcaps(str))
  }

  return {
    grid(
      columns: (1fr, 1fr, 1fr),
      align(left, footerStyle(metadata.personnal.name)),
      align(center, footerStyle(doc-name)),
      align(right, footerStyle(
        counter(page).display("1/1", both: true),
      )),
    )
  }
}

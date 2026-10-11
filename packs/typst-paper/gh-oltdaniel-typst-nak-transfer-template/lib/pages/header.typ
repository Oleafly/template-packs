#let dark_blue = color.rgb(8, 31, 92)

#let header = {
  stack(
      grid(
        columns: (1fr, 1fr),
        align(
          start,
          context if text.lang == "de" {
            image("../res/header_left_de.jpg", height: 1cm)
          } else {
            image("../res/header_left_en.jpg")
          },
        ),
        align(
          end,
          image("../res/logo.png", height: 1cm)
        ),
      ),
      v(10pt),
      rect(
        width: 100%,
        height: 1pt,
        fill: gradient.linear(
          (white, 0%),
          (white, 5%),
          (dark_blue, 100%),
        ),
      ),
    )
}
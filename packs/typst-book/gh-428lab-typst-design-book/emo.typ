#let dict = (
  "🙇": "1f647",
  "📛": "1f4db",
  "🔋": "1f50b",
  "👀": "1f440",
  "⛺︎": "26fa",
  "🦊": "1f98a",
)

#let re = dict.keys().join("|")

#let emo(c, height: 1em) = context {
  let path = "emojis/emoji_u"+dict.at(c)+".svg"
  let h = measure([X]).height
  box(
      align(horizon, image(path, format: "svg", height: height, alt: c)),
      height: h,
      outset: (y: (height - h) / 2),
  )
}

#let setup-emo(height: 1em, body) = {
  show regex(re): it => {
    emo(it.text)
  }
  body
}
#import "../../timeline-cv.typ": *
#let metadata = toml("../metadata.toml")
#let entry_simple = entry_simple.with(data: metadata)

#section_items(
  title: "Awards",
  (
    entry_simple(title: "Turing Award")[for having such a wonderful name.],
    entry_simple(title: "Best drawing")[of *My Super Kindergarten*. Received a price of one (1) green sticker.],
  ),
)

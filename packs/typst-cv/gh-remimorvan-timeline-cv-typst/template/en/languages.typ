#import "../../timeline-cv.typ": *
#let metadata = toml("../metadata.toml")
#let entry_simple = entry_simple.with(data: metadata)

#section_items(
  title: "Languages",
  (
    entry_simple(title: "English:")[
      mother tongue.
    ],
    entry_simple(title: "French:")[
      bilingual (level C2).
    ],
    entry_simple(title: "German:")[
      level B1.
    ],
  ),
)

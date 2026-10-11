#import "locale.typ": ACRONYMS
#import "@preview/i-am-acro:0.1.0": *
#import "custom-outline-entry-formatting.typ": *

/// Print all used acronyms in a outline. \
/// Using this with `link-to-toc` true, will couse all acronyms to be linked to here.
/// -> content
#let print-acronyms(
  /// Language to be used -> str
  language,
  /// Font to be used -> str
  font,
) = {
  heading(level: 1, outlined: true)[#ACRONYMS.at(language)]

  update-acro-lang(language)

  context {
    let final-acronyms = _acronyms.final()
    let default-lang-final = _default-lang.get()
    let printable-acronyms = (:)

    for (key, (value, used, long-shown)) in final-acronyms {
      if used {
        // extract only used acronyms with their default-lang short and long form
        let short-long = (value.at(default-lang-final).short, value.at(default-lang-final).long)
        printable-acronyms.insert(str(key), short-long)
      }
    }

    printable-acronyms = printable-acronyms.pairs().sorted(key: it => it.at(0))

    let max-width = 0pt
    for (key, value) in printable-acronyms {
      let result = measure(value.at(0)).width
      if (result > max-width) {
        max-width = result
      }
    }


    for (key, value) in printable-acronyms {
      set text(font: font)
      custom-outline-entry-formatting(
        location: none,
        front: [*#value.at(0)#label(LABEL_KEY + key)*],
        mid: [#value.at(1)],
        front-max-width: max-width,
      )
    }
  }
}


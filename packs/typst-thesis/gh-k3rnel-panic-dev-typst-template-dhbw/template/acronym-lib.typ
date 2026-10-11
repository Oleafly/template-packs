#import "locale.typ": ACRONYMS
#import "shared-lib.typ": display, display-link, is-in-dict

#let prefix = "acronym-state-"

// 1. Initialize a global state to hold your acronyms
#let acros = state("acronyms", (:))

// 2. Create a helper function to load your dictionary into the state
#let init-acronyms(dict) = {
  acros.update(dict)
}

// 3. The main function wrapped in 'context' so it can access the state anywhere
#let acrs(acr, plural: false, link: true) = {
  if plural {
    display("acronyms", acros, acr, acr + "s", link: link)
  } else {
    display("acronyms", acros, acr, acr, link: link)
  }
}

#let acrspl(acr, link: true) = {
  acrs(acr, plural: true, link: link)
}

#let acrl(acr, plural: false, link: true) = context {
  let acronyms = acros.get()

  if acr not in acronyms {
    panic("No definitions found for acronym '" + acr + "'. Make sure it is defined in the dictionary.")
  }

  let defs = acronyms.at(acr)
  let output-text = ""

  if type(defs) == str {
    output-text = if plural { defs + "s" } else { defs }
  } else if type(defs) == array {
    if defs.len() == 0 {
      panic("Definitions should be arrays of one or two strings. Definition of " + acr + " is empty.")
    }
    if plural {
      if defs.len() == 1 {
        output-text = defs.at(0) + "s"
      } else if defs.len() == 2 {
        output-text = defs.at(1)
      } else {
        panic("Definitions should be arrays of one or two strings.")
      }
    } else {
      output-text = defs.at(0)
    }
  } else {
    panic("Definitions should be strings or arrays. Definition of " + acr + " is: " + str(type(defs)))
  }

  output-text
}

#let acrlpl(acr, link: true) = {
  acrl(acr, plural: true, link: link)
}

#let acrf(acr, plural: false, link: true) = {
  if plural {
    display("acronyms", acros, acr, [#acrlpl(acr) (#acr\s)], link: link)
  } else {
    display("acronyms", acros, acr, [#acrl(acr) (#acr)], link: link)
  }
  state(prefix + acr, false).update(true)
}

#let acrfpl(acr, link: true) = {
  acrf(acr, plural: true, link: link)
}

#let acr(acr, plural: false, link: true) = {
  context {
    let seen = state(prefix + acr, false).get()

    if seen {
      if plural {
        acrspl(acr, link: link)
      } else {
        acrs(acr, link: link)
      }
    } else {
      if plural {
        acrfpl(acr, link: link)
      } else {
        acrf(acr, link: link)
      }
    }
  }
}

#let acrpl(acronym, link: true) = {
  acr(acronym, plural: true, link: link)
}

#let print-acronyms(language, acronym-spacing) = {
  heading(level: 1, outlined: true, numbering: none)[#ACRONYMS.at(language)]

  context {
    let acronyms = acros.get()
    let acronym-keys = acronyms.keys()

    let max-width = 0pt
    for acr in acronym-keys {
      let result = measure(acr).width

      if (result > max-width) {
        max-width = result
      }
    }

    let acr-list = acronym-keys.sorted()

    for acr in acr-list {
      grid(
        columns: (max-width + 0.5em, auto),
        gutter: acronym-spacing,
        [*#acr#label("acronyms-" + acr)*], [#acrl(acr, link: false)],
      )
    }
  }
}


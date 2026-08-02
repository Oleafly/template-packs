#let (
  use-ja-ref,
  no-trim,
) = {
  let default-lang = "ja"
  let default-numbering = "1.1"
  let default-placeholder = "?"
  let postfix-supplements = ("部", "部分", "章", "節", "項", "\u{FA56}")

  //---------------------------------------------

  let is-std-symbol(char) = {
    // check if char is a standard symbol
    (char in "1aAiI" or not ("2" in numbering(char + "1", 2, 1)))
  }

  let trim-pattern(check, pattern) = {
    let chrs = pattern.codepoints()
    let poss = range(chrs.len()).filter(k => check(chrs.at(k)))
    let (nchr, nsym) = (chrs.len(), poss.len())
    let (fp, lp) = (poss.first(), poss.last())
    let p = if nsym == 1 { 0 } else { poss.at(-2) + 1 }
    if (lp + 1 < nchr and p == lp) {
      chrs.push(chrs.at(lp))
      (nchr, nsym) = (nchr + 1, nsym + 1)
    } else {
      nchr = lp + 1
    }
    if nsym == 1 and fp > 0 {
      return chrs.at(fp) + chrs.slice(0, nchr).join()
    }
    chrs.slice(fp, nchr).join()
  }

  //---------------------------------------------

  // Converts content to string if possible.
  let stringize(v) = {
    if type(v) != content { v } else if v == [] { "" } else { v.at("text", default: v) }
  }

  // Retrieves the necessary parameters.
  let retrieve(it, footnote-sup, placeholder) = {
    let elem = it.element
    let kind = (
      if elem.func() == figure { elem.at("kind", default: none) } else { elem.func() }
    )
    let supplement = stringize(if type(it.supplement) == function {
      let elem-sup = elem.at("supplement", default: none)
      (..args) => {
        // auto is changed to elem-sup
        let stext = (it.supplement)(..args)
        if stext != auto { stext } else { elem-sup }
      }
    } else if it.supplement != auto { it.supplement } else if kind == footnote { footnote-sup } else { elem.at("supplement", default: none) })
    if supplement in postfix-supplements {
      supplement = placeholder + supplement
    }
    let count = elem.at("counter", default: none)
    if kind in (heading, math.equation, footnote) {
      count = counter(kind)
    }
    let number = elem.at("numbering", default: default-numbering)
    // If the numbering is a pattern string,
    // trim it just as the standard procedure does.
    if type(number) == str {
      number = trim-pattern(is-std-symbol, number)
    }
    (kind, supplement, number, count)
  }

  // Resolves a function-value supplement
  // just as the standard procedure does.
  let get-supplement(supplement, element) = {
    if type(supplement) != function { supplement } else { supplement(element) }
  }

  // Adorns the counter text with the supplement.
  let add-supplement(stext, ctext, space, placeholder) = {
    if (
      // stext has a placeholder
      type(stext) == str and placeholder != none and placeholder != "" and stext.find(placeholder) != none
    ) {
      let ps = stext.split(placeholder)
      assert(
        ps.len() == 2,
        message: "supplement has multiple placeholder characters",
      )
      return {
        ps.first()
        ctext
        ps.last()
      }
    }
    // Otherwise prefix with stext, but without space by default.
    let sp = if space and stext not in ("", none) { " " } else { "" }
    {
      stext
      sp
      ctext
    }
  }

  let elements = (heading, math.equation, image, table, footnote)
  let is-function(v) = {
    type(v) == function and v not in elements
  }

  let is-target(kind, spec) = {
    if spec == auto { true } else if type(spec) == array { kind in spec } else if is-function(spec) { spec(kind) } else { spec == kind }
  }

  let use-ja-ref(
    body,
    target: auto,
    footnote-supplement: none,
    placeholder: default-placeholder,
    add-space: false,
    lang: default-lang,
  ) = {
    assert(
      type(placeholder) == str and placeholder.codepoints().len() == 1,
      message: "placeholder must be a single character",
    )

    set text(lang: lang) if lang != none

    show ref: it => {
      let elem = it.element
      if type(elem) != content { return it }

      let (kind, supplement, number, count) = (
        retrieve(it, footnote-supplement, placeholder)
      )
      if (
        (count == none) or (kind == footnote and supplement == none) or not is-target(kind, target)
      ) { return it }

      let ctext = numbering(number, ..count.at(elem.location()))
      let stext = get-supplement(supplement, elem)
      add-supplement(stext, ctext, add-space, placeholder)
    }

    body
  }

  let no-trim(pattern) = {
    numbering.with(pattern)
  }

  (
    // exports
    use-ja-ref,
    no-trim,
  )
}

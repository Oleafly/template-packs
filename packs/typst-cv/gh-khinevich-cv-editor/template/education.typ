#import "basic-resume.typ": edu

#let render-sub-sub(ss) = [#ss.text]

#let render-sub(sub) = {
  let body = if "label" in sub {
    let lbl = sub.label
    let txt = sub.at("text", default: "")
    let bold-txt = sub.at("bold-text", default: false)
    let link-txt = sub.at("link-text", default: "")
    let link-url = sub.at("link-url", default: "")
    let suffix = sub.at("suffix", default: "")

    if link-txt != "" {
      [*#lbl:* #link(link-url)[#link-txt]#suffix]
    } else if bold-txt {
      [*#lbl:* *#txt*]
    } else {
      [*#lbl:* #txt]
    }
  } else if sub.at("bold", default: false) {
    strong(sub.at("text", default: ""))
  } else {
    let txt = sub.at("text", default: "")
    let link-txt = sub.at("link-text", default: "")
    let link-url = sub.at("link-url", default: "")
    let suffix = sub.at("suffix", default: "")
    if link-txt != "" {
      [#txt#link(link-url)[#link-txt]#suffix]
    } else {
      txt
    }
  }

  let subsubs = sub.at("sub", default: ())
  if subsubs.len() == 0 {
    body
  } else {
    [#body #list(..subsubs.map(ss => render-sub-sub(ss)))]
  }
}

#let render-note(note) = {
  let main = if note.at("bold", default: false) {
    strong(note.text)
  } else {
    note.text
  }

  let line = if "timeframe" in note {
    [#main #h(1fr) #note.timeframe]
  } else {
    main
  }

  let subs = note.at("sub", default: ())
  if subs.len() == 0 {
    line
  } else {
    [#line #list(..subs.map(s => render-sub(s)))]
  }
}

#let render-education(data: none) = {
  let entries = if data != none { data } else { yaml("education.yml") }

  for (i, entry) in entries.enumerate() {
    if i > 0 { v(0.6em) }

    edu(
      degree: entry.at("degree-type", default: "") + " - " + entry.at("degree-name", default: ""),
      institution: entry.institution,
      location: entry.location,
      dates: entry.timeframe,
    )

    let notes = entry.at("notes", default: ())
    if notes.len() > 0 {
      list(..notes.map(n => render-note(n)))
    }
  }
}

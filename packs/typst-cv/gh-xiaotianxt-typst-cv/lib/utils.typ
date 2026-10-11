#let get(v, key, def) = {
  if v == none {
    def
  } else if type(v) == dictionary and v.keys().contains(key) {
    v.at(key)
  } else {
    def
  }
}

#let arr(v) = {
  if v == none {
    ()
  } else if type(v) == array {
    v
  } else {
    ()
  }
}

#let txt(v) = if v == none { "" } else { str(v) }

#let has(v) = {
  if v == none {
    false
  } else if type(v) == str {
    v.trim() != ""
  } else if type(v) == array {
    v.len() > 0
  } else {
    true
  }
}

#let parse-date(v) = {
  if v == none {
    ""
  } else if type(v) != str {
    str(v)
  } else {
    let s = v.trim()
    if s == "" {
      ""
    } else if lower(s) == "present" {
      "Present"
    } else if s.len() >= 10 {
      let d = datetime(
        year: int(s.slice(0, 4)),
        month: int(s.slice(5, 7)),
        day: int(s.slice(8, 10)),
      )
      d.display("[month repr:short] [year repr:full]")
    } else {
      s
    }
  }
}

#let parse-csv(v) = {
  if v == none {
    ()
  } else {
    let raw = str(v).trim()
    if raw == "" {
      ()
    } else {
      raw.split(",").map(s => s.trim()).filter(s => s != "")
    }
  }
}

#let render-date-range(start, end) = {
  let s = parse-date(start)
  let e = parse-date(end)
  if s == "" and e == "" {
    ""
  } else if s == "" {
    e
  } else if e == "" {
    s
  } else {
    s + " – " + e
  }
}

#let display-link(url) = {
  let s = txt(url)
  if s.contains("://") {
    s.split("://").at(1)
  } else {
    s
  }
}

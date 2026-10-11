#let fill_instance_with_default(instance, default: ()) = {
  for (key, value) in default {
    if key in instance {
      if type(value) == "dictionary" {
        let filled_value = fill_instance_with_default(instance.at(key), default: value)
        instance.insert(key, filled_value)
      }
    } else {
      instance.insert(key, value)
    }
  }
  instance
}

#let codelink(url, txt) = {
  set text(font: "Cascadia Code", size: 0.85em)
  link(url, txt)
}

#let codetxt(txt) = {
  set text(font: "Cascadia Code", size: 0.85em)
  txt
}

#let linkify_doi(doi) = {
  doi.replace("doi:", "https://doi.org/")
}

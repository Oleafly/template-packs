#let thesis-type-name(lang: "de", type) = {
  if lang == "de" {
    if type == "bachelor" {
      "Bachelorarbeit"
    } else if type == "master" {
      "Masterarbeit"
    } else if type == "phd" {
      "Dissertation"
    } else {
      panic([`type` has to be one of ("bachelor", "master", "phd")])
    }
  } else if lang == "en" {
    if type == "bachelor" {
      "Bachelor's Thesis (Bachelorarbeit)"
    } else if type == "master" {
      "Master's Thesis (Masterarbeit)"
    } else if type == "phd" {
      "Dissertation"
    } else {
      panic([`type` has to be one of ("bachelor", "master", "phd")])
    }
  } else {
    panic([`lang` has to be either "de" or "en"])
  }
}

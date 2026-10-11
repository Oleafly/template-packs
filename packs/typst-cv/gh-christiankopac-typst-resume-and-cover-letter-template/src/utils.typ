// utils.typ - Utility functions for Typst Resume Template
// Save this file in the same directory as your cv.typ file

// Date parsing function (converts ISO date string to structured date)
#let strpdate(date) = {
  if date == "present" or date == none {
    return date
  }
  
  let parts = date.split("-")
  if parts.len() < 3 {
    return date // Return original if not parseable
  }
  
  let year = int(parts.at(0))
  let month = int(parts.at(1))
  let day = int(parts.at(2))
  return (year: year, month: month, day: day)
}

// Format a date range nicely (e.g. "Jan 2020 - Present")
#let daterange(start, end, lang) = {
  let endText = if end == none {
    if lang == "de" { "heute" } else { "present" }
  } else if type(end) == dictionary and lang in end {
    end.at(lang)
  } else {
    end
  }
  
  [#start – #endText]
}

// Get the base filename without extension
#let get-filename(path) = {
  let parts = path.split("/")
  let filename = parts.at(-1)
  let name-parts = filename.split(".")
  if name-parts.len() > 1 {
    name-parts.remove(-1)
  }
  name-parts.join(".")
}

// Convert a string to title case
#let titlecase(str) = {
  if str == none { return "" }
  
  let words = str.split(" ")
  let capitalized = words.map(word => {
    if word.len() == 0 { return word }
    return word.at(0).upper() + word.slice(1)
  })
  capitalized.join(" ")
}

// Calculate age from birthdate - simplified version
#let calculate-age(birthdate) = {
  if birthdate == none { return none }
  
  let birth = if type(birthdate) == str {
    strpdate(birthdate)
  } else {
    birthdate
  }
  
  if type(birth) != dictionary { return none }
  if "year" not in birth { return none }
  
  // Simple age calculation (just uses year)
  let current-year = datetime.today().year()
  return current-year - birth.year
}

// Safe accessor for nested dictionaries
#let safe-get(dict, keys, default: none) = {
  if dict == none { return default }
  
  let current = dict
  for key in keys {
    if type(current) != dictionary or key not in current {
      return default
    }
    current = current.at(key)
  }
  
  return current
}

// Check if an item exists in a sequence
#let contains(seq, item) = {
  if seq == none { return false }
  
  for i in seq {
    if i == item { return true }
  }
  return false
}

// Join a sequence of strings with a separator
#let join(seq, separator: ", ") = {
  if seq == none or seq.len() == 0 { return "" }
  
  let result = ""
  for (i, item) in seq.enumerate() {
    if i > 0 { result += separator }
    result += str(item)
  }
  
  return result
}

// Return a localized string from value that can be a plain string or
// a dictionary with language keys (en/de/si). Falls back to English, then empty.
#let localize(value, lang) = {
  if value == none { return "" }
  if type(value) == dictionary {
    if value.at(lang, default: none) != none { return value.at(lang) }
    if value.at("en", default: none) != none { return value.at("en") }
    return ""
  }
  value
}

// Add this function to your sections.typ file
#let projectEntry(name, description, technologies) = [
  *#name* 
  #linebreak()
  #text(style: "italic")[#description]
  #linebreak()
  #text(size: 9pt, fill: gray)[Technologies: #technologies]
  #linebreak()
  #linebreak()
]


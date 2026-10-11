// Helper function to convert TOML datetime to Typst datetime
#let toml_to_datetime(toml_date) = {
  if toml_date == none {
    none
  } else {
    datetime(
      year: toml_date.year(),
      month: toml_date.month(),
      day: toml_date.day(),
    )
  }
}

// Helper function to format dates with i18n support for month names
#let format_date(dt, lang) = {
  let months_de = (
    "Januar", "Februar", "März", "April", "Mai", "Juni",
    "Juli", "August", "September", "Oktober", "November", "Dezember"
  )

  let months_en = (
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  )

  let month_name = if lang == "de" {
    months_de.at(dt.month() - 1)
  } else {
    months_en.at(dt.month() - 1)
  }

  str(dt.day()) + ". " + month_name + " " + str(dt.year())
}
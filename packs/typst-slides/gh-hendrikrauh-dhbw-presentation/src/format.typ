/// Date formatting helpers.
///
/// Typst's `datetime.display()` cannot localise month names yet (English only,
/// see the datetime reference), so German dates are composed here.

#let german-months = (
  "Januar",
  "Februar",
  "März",
  "April",
  "Mai",
  "Juni",
  "Juli",
  "August",
  "September",
  "Oktober",
  "November",
  "Dezember",
)

/// Formats a date for the given language.
///
/// Anything that is not a `datetime` (string, content, `none`) is returned
/// unchanged, so callers can pass `self.info.date` directly.
///
/// - date (datetime, content, str, none): the value to format.
/// - lang (str): ISO 639-1 code; `"de"` gets German month names.
/// -> content, str
#let format-date(date, lang: "de") = {
  if type(date) != datetime {
    date
  } else if lang == "de" {
    str(date.day()) + ". " + german-months.at(date.month() - 1) + " " + str(
      date.year(),
    )
  } else {
    date.display("[day padding:none]. [month repr:long] [year]")
  }
}

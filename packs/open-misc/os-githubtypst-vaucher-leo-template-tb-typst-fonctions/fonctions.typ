
#let todayDate(lang) = {
  let actualDay = datetime.today().display("[day]")
  if actualDay.first() == "0" {
    actualDay = actualDay.last()
  }
  let actualMonth = datetime.today().display("[month repr:long]")

  if lang == "FR"{
    // Convert month to french
    if actualMonth == "January" {
      actualMonth = "janvier"
    }
    if actualMonth == "February" {
      actualMonth = "février"
    }
    if actualMonth == "March" {
      actualMonth = "mars"
    }
    if actualMonth == "April" {
      actualMonth = "avril"
    }
    if actualMonth == "May" {
      actualMonth = "mai"
    }
    if actualMonth == "June" {
      actualMonth = "juin"
    }
    if actualMonth == "July" {
      actualMonth = "juillet"
    }
    if actualMonth == "August" {
      actualMonth = "août"
    }
    if actualMonth == "September" {
      actualMonth = "septembre"
    }
    if actualMonth == "October" {
      actualMonth = "octobre"
    }
    if actualMonth == "November" {
      actualMonth = "novembre"
    }
    if actualMonth == "December" {
      actualMonth = "décembre"
    }
  }

  let actualYear = datetime.today().display("[year]")
  text(actualDay + " " + actualMonth + " " + actualYear)
}

// Warning: datetime.today() lacks hour precision for
//   day/night checks, so it will always return true
//   as for the value of hour is none.
#let is_day_time(time: datetime) = {
  let hour = time.hour()
  if hour == none {
    return true
  }
  hour >= 6 and hour < 18
}

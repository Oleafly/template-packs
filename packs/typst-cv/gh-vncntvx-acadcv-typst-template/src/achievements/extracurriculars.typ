/*
 * Extracurriculars component
 */

#import "../layout/generic.typ": generic-one-by-two

#let extracurriculars(
  activity: "",
  dates: "",
) = {
  generic-one-by-two(
    left: strong(activity),
    right: dates,
  )
}

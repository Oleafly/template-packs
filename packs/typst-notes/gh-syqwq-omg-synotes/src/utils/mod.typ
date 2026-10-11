#import "common-utils.typ": *
#import "math-utils.typ": *
#import "thmenv.typ": *

#let show-utils(body) = {
  show: show-common-format
  show: show-math-format
  show: show-thmenv

  body
}

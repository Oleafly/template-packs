// ============================================================
// AUTO — Conditional logic utilities (truthify, render-if, call-or-value)
// ============================================================

#let truthify(v) = v != "" and v != false and v != [] and v != none

#let call-or-value(v) = if type(v) == function { v() } else { v }

#let render-if(cond, if-true, if-false: none) = {
  if truthify(cond) { call-or-value(if-true) }
  else if if-false != none { call-or-value(if-false) }
}

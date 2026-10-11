// ******************************************************************************
// thesis-info.typ
// Thesis metadata -- the Typst counterpart of thesis-info.tex.
// Edit the values below; thesis.typ pulls them in to build the title page.
// ******************************************************************************

#let thesis-title = "Writing your PhD thesis in Typst"
#let thesis-subtitle = "Using the lualatex-thesis-equivalent template, ported from LaTeX"
#let thesis-author = "Krishna Kumar"
#let thesis-department = "Department of Engineering"
#let thesis-university = "University of Cambridge"

// Crest minimum width should be ~30mm as per the original class's comment.
//
// The image below is a blank, transparent placeholder at the exact pixel
// dimensions (246x288) of the crest image previously shipped here, rather
// than an actual university crest -- crests/coats of arms are frequently
// under their own usage restrictions independent of this template's
// licence, so this repository doesn't ship a real one. Replace
// figs/university-crest.png with your own institution's crest (keeping it
// roughly this aspect ratio, or adjusting the `width:` below to match) once
// you've confirmed you're entitled to use it.
#let thesis-crest = image("figs/university-crest.png", width: 25%)

// College shield [optional] -- uncomment and point at a shield image if
// used. Same copyright caveat as the university crest above applies.
// #let thesis-college-shield = image("figs/college-shield.png", width: 20%)
#let thesis-college-shield = none

// Supervisor / advisor (optional) -- set to `none` to omit. For multiple
// supervisors/advisors, separate names with a linebreak, e.g.:
// #let thesis-supervisor = [Prof. A.B. Supervisor \ Prof. C.D. Supervisor]
#let thesis-supervisor = none
#let thesis-advisor = none

#let thesis-degree-title = "Doctor of Philosophy"

// College affiliation (optional) -- set to `none` to omit.
#let thesis-college = "King's College"

// Submission date. Default mirrors the LaTeX class's
// {\monthname[\the\month]\space\the\year} -- swap for a literal string
// (e.g. "September 2026") if you want a fixed date instead.
#let thesis-degree-date = datetime.today().display("[month repr:long] [year]")

#let thesis-keywords = ("Typst", "PhD Thesis", "Engineering", "University of Cambridge")

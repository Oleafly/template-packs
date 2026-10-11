// IMPORTANT: Print at Actual size (100% scale). If you use a print shop, ask
// the staff to use these settings. See README.md#printing.

// ===========================================================================
// THIS is the file to compile. Not a chapter, not config.typ.
//
//   typst compile main.typ        one-shot build
//   typst watch  main.typ         rebuild on every save
//
// In the Typst web app, open this file before pressing preview. In VS Code
// with Tinymist, run "Typst: Pin main file" on this file once, otherwise the
// preview follows whichever file you are editing and a chapter on its own
// renders as a few unstyled pages with no cover, contents or page numbers.
// ===========================================================================
//
// Edit config.typ for everything about your report. Edit the chapter files for
// its contents. This file only decides which chapters are included and in what
// order: to add one, create the file and add an #include line; to drop one,
// delete its line.

#import "config.typ": config
#import "report.typ": report

#show: report.with(config)

#include "03_chapters/01_introduction.typ"
#include "03_chapters/02_literature-survey.typ"
#include "03_chapters/03_system-requirements.typ"
#include "03_chapters/04_methodology-implementation.typ"
#include "03_chapters/05_results-discussion.typ"
#include "03_chapters/06_conclusion.typ"


/////////////////////////////////////////////////////////////////////////
//  MAIN SCRIPT
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////

#import "setup.typ": the_setup
#import "include/template.typ": *
#import "include/snippets.typ": *

// Move below the_body to ignore words in front matter
#import "@preview/wordometer:0.1.4": total-words, word-count
#show: word-count.with(exclude: (<no-wc>, figure))


////////////////////////////////////////////////////////////////////////////
// The Main Text: Markup section files

#show: the_body.with(..the_setup(total-words))
#include "1-introduction.typ"
#include "2-background.typ"
// ommitted
#include "5-conclusions.typ"

#show: the_bibliography.with(..the_setup(total-words))

#show: the_appendix
#include "A-appendix.typ"
#include "B-appendix.typ"

#show: the_statement.with(..the_setup(total-words))

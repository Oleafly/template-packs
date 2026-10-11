#import "include/snippets.typ": *

/////////////////////////////////////////////////////////////////////////
//  DOCUMENT SETUP
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////

#let the_setup(total-words) = (
  title: [
    Thesis Title: \
    Second Line of Title
  ],
  subtitle: "Master's Thesis",
  date: "April 27, 2026",
  author: (
    name: "Name",
    email: "my@email.com",
    affiliation: "Hertie School, Berlin",
    program: "M.Sc. Data Science for Public Policy",
  ),
  supervision: (
    supervisor: "The Super Visor",
    supervisor_affiliation: "Hertie School, Berlin",
    practice_partner: none,
  ),
  meta: (
    words: total-words,
    jel: none,
    keywords: none,
    last_accessed: "27 April 2026",
  ),
  abstract: [
    #lorem(150)

    #lorem(70)
  ],
  acknowledgements: [
    #lorem(200)
  ],
  statements: (
    authorship: [
      I hereby confirm and certify that this master thesis is my own work. All ideas and language of others are acknowledged in the text. All references and verbatim extracts are properly quoted and all other sources of information are specifically and clearly designated. I confirm that the digital copy of the master thesis that I submitted on April 27, 2026 is identical to the printed version I submitted to the Examination Office on April 28, 2026.
    ],
    coi: [The author declares no conflict of interest.],
    da: [The data and replication code can be made available upon request.],
  ),
)

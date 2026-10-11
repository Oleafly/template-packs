// ============================================================================
// FRONT MATTER
// Half title, title page, copyright page, and dedication
// ============================================================================

#import "config.typ": display-font, body-font

// --- HALF TITLE PAGE ---
#let half-title-page(title) = {
  set page(numbering: none)
  set par(justify: false)
  v(2.5in)
  align(center)[
    #text(
      font: display-font,
      size: 14pt,
      tracking: 0.1em,
    )[#upper(title)]
  ]
  pagebreak()
}

// --- TITLE PAGE ---
#let title-page(
  title,
  subtitle: none,
  author,
  publisher,
) = {
  set page(numbering: none)
  set par(justify: false)
  v(1in)
  align(center)[
    #text(
      font: display-font,
      size: 22pt,
      weight: "bold",
      tracking: 0.05em,
      hyphenate: false,
    )[#upper(title)]

    #if subtitle != none {
      v(0.4em)
      text(
        font: display-font,
        size: 10pt,
        hyphenate: false
      )[#subtitle]
    }

    #v(1em)
    #text(font: display-font, size: 9pt)[by]
    #v(0.3em)
    #text(
      font: display-font,
      size: 13pt,
      tracking: 0.15em,
    )[#upper(author)]

    #v(1fr)
    #text(
      font: display-font,
      size: 10pt,
      tracking: 0.2em,
    )[#upper(publisher)]
  ]
  pagebreak()
}

// --- COPYRIGHT PAGE ---
#let copyright-page(
  title,
  author,
  publisher,
  year,
  isbn,
) = {
  set page(numbering: none)
  set text(size: 7pt)
  set par(justify: false, first-line-indent: 0pt, leading: 0.6em)

  v(1fr)

  [This is a work of fiction. Names, characters, places, and incidents either are the product of the author's imagination or are used fictitiously. Any resemblance to actual persons, living or dead, events, or locales is entirely coincidental.]

  v(1em)

  [#upper(publisher) BOOKS are published by #publisher, Inc.]

  v(1em)

  [Copyright © #year by #author]
  v(0em)
  [All rights reserved.]

  v(0.5em)

  [No part of this book may be reproduced or transmitted in any form or by any means, electronic or mechanical, including photocopying, recording, or by any information storage and retrieval system, without permission in writing from the publisher.]

  v(1em)

  [ISBN: #isbn]

  v(0.5em)

  [Printed in the United States of America]
  v(0em)
  [First Printing: #year]
  v(0em)
  [10 9 8 7 6 5 4 3 2 1]

  pagebreak()
}

// --- DEDICATION ---
#let dedication(text-content) = {
  set page(numbering: none)
  v(2in)
  align(center)[
    #set text(style: "italic", size: 10pt)
    #text-content
  ]
  pagebreak()
}

// --- TABLE OF CONTENTS ---
#let table-of-contents() = {
  set page(numbering: none)
  v(0.8in)
  align(center)[
    #text(
      font: display-font,
      size: 14pt,
      tracking: 0.15em,
    )[CONTENTS]
  ]
  v(0.6em)

  set text(size: 9pt, font: body-font)
  set par(first-line-indent: 0pt, leading: 0.8em)

  outline(
    title: none,
    indent: 1em,
    depth: 2,
  )

  pagebreak()
}

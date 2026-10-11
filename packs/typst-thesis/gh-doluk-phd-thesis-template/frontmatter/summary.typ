// Many faculties want the summary in English *and* in the local language.
// Delete whichever you do not need.

= Summary

Summarise the whole thesis in half a page: the problem, what you did about it,
and what came out. Acronyms defined in lib/abbreviations.typ expand on their
first use, so writing `@AUC` here yields @AUC and every later `@AUC` yields the
short form.

A good summary answers four questions in order. What was not possible before?
What did you build? What does it now allow? And how far does that claim reach?

// `#[ ... ]` is a content block: `set` rules inside it apply only within the
// brackets. Here it switches hyphenation and quotation marks to German for the
// German summary, without changing the language of the rest of the thesis.
#[
  #set text(lang: "de")

  = Zusammenfassung

  Die deutsche Fassung der Zusammenfassung steht hier. Durch `lang: "de"` wird
  für diesen Abschnitt die deutsche Silbentrennung verwendet, ohne die Sprache
  des restlichen Dokuments zu ändern.

  Beschreiben Sie in einer halben Seite das Problem, Ihren Lösungsansatz und
  die wichtigsten Ergebnisse Ihrer Arbeit.
]

#import "Template/Config.typ": h1-pagebreak, h1-reset
#import "Template/Commands.typ": *

// ----------- CONFIG, NESAHAT!!! ----------- // 

#h1-pagebreak.update(false)
#h1-reset.update(false)

#heading(numbering: none, outlined: true)[Přílohy]

#set heading(numbering: "A.1")
#counter(heading).update(0)
#counter(figure.where(kind: image)).update(0)  // reset číslování obrázků
#counter(figure.where(kind: table)).update(0)  // reset číslování tabulek
#counter(figure.where(kind: "code")).update(0) // reset číslování kódových bloků
#counter(math.equation).update(0)              // reset číslování rovnic

#set figure(numbering: (..nums) => {
  numbering("A.1", 1, ..nums)
})


// ----------- TADY UZ MUZES PSAT ----------- //

= První příloha
Tento nadpis už nezačíná na nové stránce, ale následuje hned pod nadpisem "Přílohy".

#code-input(
  "/README.md",
  lang: "md",
  caption: "Readme",
  label: "c-readme"
)

== Idk

#code-input(
  "/literatura.bib",
  lang: "bibtex",
  caption: "Literatura",
  label: "c-literature"
)

= Druhá příloha
Ani tento nadpis nebude mít před sebou vynucený odskok na novou stránku.

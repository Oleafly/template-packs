#import "template/thesis.typ": thesis
#import "chapters/content.typ"

#let meta = (
  title: "Titel der Arbeit", 
  type: "Projektarbeit / Bachelorarbeit",

  university: "Uni",
  campus: "Campus",

  academic-year: "Jahr",
  course: "A/B/C",

  faculty: "Fakultät",
  degree-program: "Studiengang",

  secret: true, //Sperrvermerk

  author: "Verfasser",
  matriculation-number: "4512345", //optimal
  company: "Unternehmen", //optimal
  supervisor: "Betreuer",

  delivery-date: "01-01-2001", //optional
  
  left-logo: "../assets/images/Firma.png",
  right-logo: "../assets/images/Uni.png",

  bibliography-file: "../references/bibliography.bib",
)

#show: document => thesis(meta, document)

#include "chapters/content.typ"
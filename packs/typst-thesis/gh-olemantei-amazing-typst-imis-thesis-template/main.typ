#import "config/formatting.typ": *

#show: doc => thesis(
  title: "Titel der Arbeit",
  subtitle: "Titel Zeile 2", // remove this line if not needed
  english_title: "Titel der Arbeit in Englisch",
  thesis_type: "Masterarbeit/Bachelorarbeit",
  study_program: "Informatik/Medieninformatik",
  author: "Vorname Nachname des Studierenden",
  supervisor: "Prof. Dr. Vorname Nachname",
  support: "Titel Vorname Nachname des/der Betreuer/in",
  company: "Muster GmbH", // remove this line if not needed
  date: "16. Februar 2025",
  exposé: false,
  doc,
)

#include "./_chapters/01_introduction.typ"
#include "./_chapters/02_related_work.typ"
#include "./_chapters/03_weitere_kapitel.typ"
#include "./_chapters/99_conclusion.typ"

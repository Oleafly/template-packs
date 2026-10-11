/*
 * Typst Thesis Template @ Ohm
 *
 * Copyright (c) 2026 Nils Weber <me@vimkat.dev>
 */

#import "parameters.typ" : p, thesis-parameters

#let translations = (
  "de": (
    "at_uni": "an der Technischen Hochschule Nürnberg",
    "city": "Nürnberg",
    "bachelor": "Bachelorarbeit",
    "master": "Masterarbeit",
    "report": "Bericht",
    "faculty": "Fakultät Informatik",
    "student-id": "Matrikelnummer",
    "examiners-singular": "Prüfer",
    "examiners-plural": "Prüfer",
    "supervisors-singular": "Betreuer",
    "supervisors-plural": "Betreuer",
    "copyright": context [
      #let company = thesis-parameters.get().at("company", default: none)
      #let copyright = if company != none [von #company] else [des Urhebers]
      Diese Arbeit, einschließlich ihrer Teile, *ist urheberrechtlich geschützt*.
      Jede Verwertung außerhalb der engen Grenzen des Urheberrechtsgesetzes ohne Zustimmung #copyright ist untersagt und strafbar.
      Dies gilt insbesondere für Vervielfältigungen, Übersetzungen, Mikroverfilmung und die Speicherung und Verarbeitung in elektronischen Systemen.
    ],
    "TOC": "Inhaltsverzeichnis",
    "LOT": "Tabellenverzeichnis",
    "LOF": "Abbildungsverzeichnis",
    "LOL": "Quellcodeverzeichnis",
    "LOA": "Abkürzungsverzeichnis",
    "BIB": "Referenzen",
    "glossary": "Glossar",
    "chapter": "Kapitel",
    "section": "Abschnitt",
    "appendix": "Anhang",
    "ack": "Danksagung",
    "abstract": "Kurzdarstellung",
    "kurzdarstellung": "Abstract",
    "and": "und",
    "for_a": "für eine",
    "page": "Seite",
    "numbering-1of1": "1 von 1",
  ),
  "de-gender": (
    "examiners-singular": "Prüfer*in",
    "examiners-plural": "Prüfer*innen",
    "supervisors-singular": "Betreuer*in",
    "supervisors-plural": "Betreuer*innen",
    "copyright": context [
      #let company = thesis-parameters.get().at("company", default: none)
      #let copyright = if company != none { company } else { thesis-parameters.get().at("author") }
      Diese Arbeit, einschließlich ihrer Teile, *ist urheberrechtlich geschützt*.
      Jede Verwertung außerhalb der engen Grenzen des Urheberrechtsgesetzes ohne Zustimmung von #copyright ist untersagt und strafbar.
      Dies gilt insbesondere für Vervielfältigungen, Übersetzungen, Mikroverfilmung und die Speicherung und Verarbeitung in elektronischen Systemen.
    ],
  ),
  "en": (
    "at_uni": "at Nuremberg Institute of Technology",
    "city": "Nuremberg",
    "bachelor": "Bachelor Thesis",
    "master": "Master Thesis",
    "report": "Report",
    "faculty": "Faculty of Computer Science",
    "student-id": "Student ID",
    "examiners-singular": "Examiner",
    "examiners-plural": "Examiners",
    "supervisors-singular": "Supervisor",
    "supervisors-plural": "Supervisors",
    "copyright": context [
      #let company = thesis-parameters.get().at("company", default: none)
      #let copyright = if company != none { company } else [the author]
      This work, including its parts, *is protected by copyright*.
      Any use outside the narrow limits of copyright law without the consent of #copyright is prohibited and punishable by law.
      This applies in particular to reproductions, translations, microfilming and storage and processing in electronic systems.
    ],
    "TOC": "Table of Contents",
    "LOT": "List of Tables",
    "LOF": "List of Figures",
    "LOL": "List of Listings",
    "LOA": "List of Acronyms",
    "BIB": "References",
    "glossary": "Glossary",
    "chapter": "Chapter",
    "section": "Section",
    "appendix": "Appendix",
    "ack": "Acknowledgements",
    "abstract": "Abstract",
    "kurzdarstellung": "Kurzdarstellung",
    "and": "and",
    "for_a": "for a",
    "page": "Page",
    "numbering-1of1": "1 of 1",
  ),
)

#let t(key, default: none) = {
  let locale = p("lang")
  let locale-fallback = locale.split("-").at(0)

  return translations.at(locale).at(key, default: translations.at(locale-fallback).at(key, default: default))
}

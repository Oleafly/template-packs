#import "../_functions.typ": *
#import "../_style.typ": *
#show: main

= Dokumentation LLM-Nutzung <anhang-llm>

Dokumentation jeder Interaktion mit LLMs, die zu einer Änderung des Inhalts dieser Arbeit führte.

#llmUsecase(
  date: "09.07.2026",
  contentref: "Es wurden lediglich kleine Rechtschreib- oder Grammatikfehler verbessert.",
  prompt: "Korrigiere den Input auf Rechtschreib- und Grammatikfehler. Gib mir nur eine Übersicht aller Fehler aus.",
  input: "[Absatz für Absatz die ganze Arbeit durch]",
  output: "[Auflistung von Fehlern in der jeweiligen Eingabe]",
  description: "Diese Abfrage wurde ganz am Ende der Abeit zum Korrigieren benutzt."
)

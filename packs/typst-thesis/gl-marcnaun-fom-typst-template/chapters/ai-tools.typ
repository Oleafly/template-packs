// ─── KI-Hilfsmittelverzeichnis ────────────────────────────────────────────────
// Jeder KI-Einsatz wird als eigener #ai-entry(...)-Block erfasst.
#import "../lib/ai-entry.typ": ai-entry

#ai-entry(
  tool:     "ChatGPT o4-mini (OpenAI)",
  usage:    [Unterstützung bei der Erstellung und strukturellen Gestaltung der
             Kapitelgliederung der Arbeit.],
  prompt:   [Erstelle eine wissenschaftliche Gliederung für eine Seminararbeit
             über betriebliche Informationssysteme und digitale Transformation.
             Die Arbeit soll eine beratungsorientierte Perspektive einnehmen und
             sowohl theoretische Grundlagen als auch eine praxisnahe Fallanalyse
             anhand eines Referenzszenarios umfassen.],
  response: [Das Modell schlug eine fünfteilige Struktur vor, bestehend aus
             Einleitung, Grundlagen, praxisbezogener Analyse, kritischer
             Diskussion sowie Fazit. Die vorgeschlagene Hierarchie wurde als
             Ausgangspunkt für die finale Gliederung herangezogen und inhaltlich
             angepasst.],
)

#ai-entry(
  tool:     "Claude Sonnet 4.6 (Anthropic)",
  usage:    [Überarbeitung und stilistische Vereinheitlichung von Textabschnitten
             zur Sicherstellung eines durchgängig akademisch-formalen
             Schreibstils.],
  prompt:   [Schreibe den folgenden Abschnitt in einem einheitlichen,
             wissenschaftlich-formalen Stil um. Beachte dabei die Verwendung
             des Nominalstils, präziser Fachbegriffe sowie komplexer
             Hypotaxen. Der Inhalt soll vollständig erhalten bleiben.
             Abschnitt: [Originaltext]],
  response: [Das Modell lieferte überarbeitete Textfassungen, die hinsichtlich
             Syntax, Nominalisierung und Fachterminologie vereinheitlicht wurden.
             Die generierten Formulierungen wurden anschließend inhaltlich
             geprüft, bei Bedarf angepasst und in die jeweiligen Kapitel
             integriert.],
)

#ai-entry(
  tool:     "Gemini 2.5 Pro (Google)",
  usage:    [Inhaltliche Recherche zu Konzepten, Integrationsprinzipien und
             betriebswirtschaftlichen Aspekten im Kontext betrieblicher IS.],
  prompt:   [Erkläre die wesentlichen Unterschiede zwischen transaktionalen
             Informationssystemen (TPS), Management Information Systems (MIS)
             und Decision Support Systems (DSS). Gehe dabei insbesondere auf
             typische Einsatzbereiche und Integrationspotenziale ein.],
  response: [Das Modell lieferte eine strukturierte Übersicht der Systemklassen,
             welche als Grundlage für die konzeptionellen Abschnitte in Kapitel 2
             diente. Die Inhalte wurden mit einschlägiger Fachliteratur
             abgeglichen und im Hinblick auf das Referenzszenario konkretisiert.],
)

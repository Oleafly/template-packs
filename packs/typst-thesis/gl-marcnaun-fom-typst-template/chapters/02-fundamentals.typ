#import "../lib/style.typ": placeholder
#import "../lib/cite.typ": cf, quot, cf-multi, fig-source, fig-based-on, fig-based-on-note
#import "../lib/abbr.typ": abbr

// ─── Chapter 2: Grundlagen ────────────────────────────────────────────────────

= Grundlagen

== Informationssysteme als betriebliche Infrastruktur

=== Definition und Klassifikation

Informationssysteme lassen sich als soziotechnische Systeme beschreiben, die menschliche und
maschinelle Komponenten verbinden, um betriebliche Informationen zu erfassen, zu speichern,
zu verarbeiten und bereitzustellen.#cf(<klausWhatERP2000>, page: "141") Diese weit gefasste
Definition schließt sowohl einfache Datenbankanwendungen als auch hochkomplexe,
unternehmensweite Plattformen ein, deren Leistungsumfang weit über die reine Datenverwaltung
hinausgeht.

In der Literatur werden IS typischerweise nach ihrem Einsatzbereich klassifiziert.
#abbr("TPS", "Transaction Processing Systems") bilden die unterste Ebene und erfassen operative
Geschäftsvorfälle in Echtzeit. Aufbauend darauf ermöglichen
#abbr("MIS", "Management Information Systems") eine aggregierte Berichterstattung für das
mittlere Management. Auf strategischer Ebene unterstützen
#abbr("DSS", "Decision Support Systems") komplexe Entscheidungsprozesse durch Szenarioanalysen
und Simulationen.#cf(<shangAssessingManagingBenefits2002>, page: "274 f")

@tab-klassifikation gibt einen Überblick über die wesentlichen Systemklassen sowie deren
typische Einsatzbereiche und charakteristische Merkmale.

#figure(
  caption: [Klassifikation betrieblicher Informationssysteme],
  table(
    columns: (auto, 1fr, 1fr),
    table.hline(),
    [Systemklasse], [Einsatzbereich], [Charakteristika],
    table.hline(),
    [TPS],
      [Operative Ebene],
      [Echtzeitverarbeitung, hohes Transaktionsvolumen],
    [MIS],
      [Taktische Ebene],
      [Aggregierte Berichte, Kennzahlensysteme],
    [DSS],
      [Strategische Ebene],
      [Szenarioanalysen, Prognosefunktionen],
    [ERP],
      [Unternehmensweite Integration],
      [Modulare Architektur, einheitliche Datenbasis],
    table.hline(),
  )
) <tab-klassifikation>

=== Architekturmodelle und Integrationsparadigmen

Die Architektur betrieblicher IS hat sich in den vergangenen Dekaden grundlegend gewandelt.
Während frühe Systeme auf monolithischen Architekturen basierten, dominieren heute
serviceorientierte Ansätze, die eine höhere Flexibilität und Skalierbarkeit ermöglichen.#cf(<dumasFundamentalsBusinessProcess2018>, page: "3 f")

Das Prinzip der losen Kopplung über standardisierte
#abbr("API", "Application Programming Interface", german: "Programmierschnittstelle") bildet die
technologische Grundlage moderner Integrationsparadigmen. Durch die Definition eindeutiger
Schnittstellenverträge können heterogene Systemkomponenten unabhängig voneinander
weiterentwickelt werden, ohne die Gesamtfunktionsfähigkeit zu gefährden.

Eine aktuelle Entwicklungslinie ist die Migration von On-Premises-Systemen in die Cloud,
wobei zwischen verschiedenen Servicemodellen unterschieden wird:

- *#abbr("SaaS", "Software as a Service"):* Die Anwendung wird vollständig durch den Anbieter
  betrieben und über das Internet bereitgestellt.
- *#abbr("PaaS", "Platform as a Service"):* Der Anbieter stellt eine Entwicklungsplattform zur
  Verfügung, auf der Unternehmen eigene Anwendungen betreiben.
- *#abbr("IaaS", "Infrastructure as a Service"):* Grundlegende Rechenressourcen wie Server und
  Speicher werden bedarfsgerecht bereitgestellt.

Die Wahl des geeigneten Modells hängt von den spezifischen Anforderungen, den
Datenschutzvorgaben sowie der strategischen IT-Ausrichtung des Unternehmens ab.#cf(<umbleEnterpriseResourcePlanning2003>, page: "243")

=== Betriebswirtschaftlicher Nutzen und Bewertung

Der Nutzen betrieblicher IS lässt sich nicht ausschließlich anhand technischer Kennzahlen
bemessen, sondern manifestiert sich in einer Vielzahl organisatorischer und strategischer
Dimensionen. Shang und Seddon identifizieren fünf zentrale Nutzendimensionen: operationale,
managerielle, strategische, IT-infrastrukturelle sowie organisatorische
Vorteile.#cf(<shangAssessingManagingBenefits2002>, page: "278 ff")

Als übergeordneter Rahmen zur wirtschaftlichen Bewertung von IS-Investitionen gilt die
Berechnung des #abbr("ROI", "Return on Investment"), welche jedoch aufgrund der Vielzahl schwer
quantifizierbarer Nutzeneffekte mit erheblichen Unsicherheiten behaftet ist.

Davenport stellt diesbezüglich fest, dass ein Unternehmenssystem seiner Natur nach eine eigene
Logik auf Strategie, Kultur und Organisation des Unternehmens aufzwingt.#quot(<davenportPuttingEnterpriseEnterprise1998>, page: "121")
Diese Einschätzung verdeutlicht, dass IS-Einführungen weit mehr als rein technische Projekte
darstellen und zwingend eine ganzheitliche betriebswirtschaftliche Betrachtung erfordern.

== Digitale Transformation

=== Begriff und strategische Treiber

Unter digitaler Transformation wird der tiefgreifende Wandel von Geschäftsmodellen, Prozessen
und Organisationsstrukturen verstanden, der durch den Einsatz digitaler Technologien ausgelöst
wird. Im Gegensatz zur reinen Digitalisierung analoger Prozesse impliziert die digitale
Transformation eine fundamentale Neugestaltung der Wertschöpfungslogik.#cf(<davenportPuttingEnterpriseEnterprise1998>, page: "123")

Zu den wesentlichen technologischen Treibern zählen:

1. *#abbr("KI", "Künstliche Intelligenz"):* Algorithmen zur automatisierten Mustererkennung
   und Entscheidungsunterstützung.
2. *#abbr("IoT", "Internet of Things", german: "Internet der Dinge"):* Vernetzung physischer
   Objekte zur Generierung und Übertragung von Echtzeitdaten.
3. *Cloud Computing:* Flexible und skalierbare Bereitstellung von Rechenkapazitäten.
4. *Big Data Analytics:* Auswertung großer, heterogener Datenmengen zur Gewinnung
   strategischer Erkenntnisse.

=== Phasenmodell der Transformation

Die Transformation betrieblicher Strukturen vollzieht sich typischerweise entlang eines
mehrstufigen Reifegradmodells, das von der initialen Digitalisierung analoger Prozesse bis hin
zur vollständigen Neudefinition von Geschäftsmodellen reicht.#cf(<dumasFundamentalsBusinessProcess2018>, page: "5 ff")

@tab-reifegradmodell stellt die Phasen des Modells mit den jeweils charakteristischen
Merkmalen und strategischen Implikationen zusammenfassend dar.

#figure(
  caption: [Phasen des digitalen Reifegradmodells],
  table(
    columns: (1.5fr, 2fr, 1fr, 1fr),
    align: (left, left, center, center),
    table.hline(),
    [Phase], [Beschreibung], [Digitisierungsgrad], [Strategische Relevanz],
    table.hline(),
    [1 – Digitisierung],
      [Analoge Prozesse werden digitalisiert],
      [Gering], [Operativ],
    [2 – Digitalisierung],
      [Prozesse werden neu gestaltet],
      [Mittel], [Taktisch],
    [3 – Digitale Integration],
      [Systemübergreifende Vernetzung],
      [Hoch], [Strategisch],
    [4 – Digitale Transformation],
      [Neugestaltung des Geschäftsmodells],
      [Vollständig], [Disruptiv],
    table.hline(),
  )
) <tab-reifegradmodell>

== Bewertungsrahmen für IT-Investitionen

=== Methoden der Wirtschaftlichkeitsanalyse

Die Bewertung von IT-Investitionen stellt Unternehmen vor besondere Herausforderungen, da
neben den quantifizierbaren Nutzeneffekten eine Vielzahl qualitativer Faktoren berücksichtigt
werden müssen.#cf-multi((<shangAssessingManagingBenefits2002>, "279"), (<umbleEnterpriseResourcePlanning2003>, "245"))

In der Praxis kommen häufig folgende Methoden zum Einsatz:

- *#abbr("KWM", "Kapitalwertmethode"):* Diskontierung zukünftiger
  Cashflows auf den Investitionszeitpunkt.
- *#abbr("TCO", "Total Cost of Ownership"):* Erfassung aller Kosten über den vollständigen
  Lebenszyklus der Investition.
- *Balanced Scorecard:* Mehrdimensionale Bewertung entlang der Perspektiven Finanzen,
  Kunden, Prozesse und Lernen.

=== Kritische Erfolgsfaktoren

Die Forschungsliteratur identifiziert eine Reihe von Faktoren, die den Projekterfolg bei
IS-Implementierungen maßgeblich bestimmen. Technische Vollständigkeit und
Konfigurationsqualität sind notwendige, jedoch nicht hinreichende Bedingungen; vielmehr
erweisen sich Change Management, Anwenderakzeptanz sowie das Commitment des
Top-Managements als entscheidende Differenzierungsmerkmale.#cf(<umbleEnterpriseResourcePlanning2003>, page: "250")

Umble et al. fassen dies prägnant zusammen: Ein ERP-Projekt ist in erster Linie ein
Organisationsprojekt und erst in zweiter Linie ein IT-Projekt.#cf(<umbleEnterpriseResourcePlanning2003>, page: "241")

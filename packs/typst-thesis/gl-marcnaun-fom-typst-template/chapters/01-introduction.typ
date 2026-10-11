#import "../lib/style.typ": placeholder
#import "../lib/cite.typ": cf, quot, cf-multi
#import "../lib/abbr.typ": abbr

// ─── Chapter 1: Einleitung ────────────────────────────────────────────────────

= Einleitung <einleitung>

#block(
  fill: rgb("#fff3cd"),
  stroke: rgb("#ffc107"),
  radius: 4pt,
  inset: 12pt,
  width: 100%,
)[
  *Hinweis:* Bei dieser Arbeit handelt es sich *nicht* um eine echte wissenschaftliche Arbeit, sondern ausschließlich um eine *Demonstration* des Typst-Templates. Sämtliche Inhalte wurden vollständig durch eine KI generiert und besitzen keinerlei wissenschaftliche Aussagekraft. Angegebene Quellen, Zitate und Referenzen sind fiktiv und existieren im Zweifel nicht.
]

== Motivation

Die fortschreitende Digitalisierung stellt Unternehmen jeder Größenordnung vor grundlegende
Herausforderungen hinsichtlich ihrer organisatorischen Strukturen und
informationstechnischen Infrastruktur. Insbesondere #abbr("KMU", "Kleine und mittlere Unternehmen")
sehen sich mit der Notwendigkeit konfrontiert, gewachsene Prozesslandschaften durch den Einsatz
integrierter #abbr("IS", "Informationssysteme") zu modernisieren, um ihre Wettbewerbsfähigkeit in
einem dynamischen Marktumfeld nachhaltig zu sichern.#cf(<davenportPuttingEnterpriseEnterprise1998>, page: "121")

Die Fragmentierung betrieblicher Datenhaltung gilt als wesentliche Ursache für ineffiziente
Entscheidungsprozesse, da heterogene Systemlandschaften eine kohärente Auswertung
unternehmensweiter Kennzahlen erheblich erschweren. Funktionsbereiche wie Beschaffung,
Produktion und Rechnungswesen operieren häufig auf Basis voneinander isolierter Datensilos,
was zu redundanter Datenpflege sowie inkonsistenten Berichten führt.#cf(<klausWhatERP2000>, page: "142 f")

Die Einführung unternehmensweiter #abbr("ERP", "Enterprise-Resource-Planning")-Systeme wird in der
betriebswirtschaftlichen Forschung als zentraler Lösungsansatz für diese Problematik diskutiert,
wobei die Integration sämtlicher Geschäftsprozesse auf einer einheitlichen Datenbasis als
entscheidender Mehrwert gilt. Dennoch ist die Implementierung solcher Systeme mit erheblichen
Aufwänden verbunden, die eine sorgfältige strategische Planung voraussetzen.#cf(<umbleEnterpriseResourcePlanning2003>, page: "242")

== Zielsetzung

Die vorliegende Arbeit verfolgt das Ziel, die wesentlichen Erfolgsfaktoren und Herausforderungen
bei der Implementierung betrieblicher IS zu analysieren und deren Auswirkungen auf die
organisatorische Effizienz zu bewerten. Dabei wird sowohl eine theoretische Fundierung als auch
eine praxisorientierte Betrachtung angestrebt, um handlungsleitende Erkenntnisse für
Entscheidungsträger abzuleiten.

Im Mittelpunkt der Untersuchung steht die Frage, unter welchen Bedingungen der Einsatz
integrierter Softwarelösungen einen messbaren betriebswirtschaftlichen Nutzen generiert und
welche organisatorischen sowie technischen Voraussetzungen eine erfolgreiche Einführung
begünstigen.#cf-multi((<shangAssessingManagingBenefits2002>, "272 f"), (<umbleEnterpriseResourcePlanning2003>, "244"))

Die Arbeit nimmt eine beratungsorientierte Perspektive ein und richtet sich an Führungskräfte sowie
#abbr("IT", "Informationstechnologie")-Verantwortliche, die vor der strategischen Entscheidung für
oder gegen eine Systemeinführung stehen. Technische Implementierungsdetails werden bewusst
zugunsten einer prozessualen und betriebswirtschaftlichen Analyse zurückgestellt.

== Aufbau der Arbeit

Das zweite Kapitel legt die theoretischen Grundlagen der Untersuchung dar, indem IS klassifiziert,
relevante Architekturmodelle vorgestellt und das Konzept der digitalen Transformation abgegrenzt
werden. Ergänzend werden gängige Bewertungsrahmen für IT-Investitionen erläutert.

Das dritte Kapitel überführt die theoretischen Konzepte in eine praxisnahe Analyse, wobei ein
generisches Referenzszenario als Untersuchungsgrundlage dient. Dabei werden Systemarchitektur,
Implementierungsprozess und Integrationsaspekte systematisch beleuchtet.

Das vierte Kapitel widmet sich einer kritischen Diskussion der erzielten Erkenntnisse, indem
Vorteile und Limitationen gegenübergestellt und strategische Empfehlungen abgeleitet werden.
Das fünfte Kapitel fasst die zentralen Ergebnisse zusammen und gibt einen Ausblick auf offene
Forschungsfragen.

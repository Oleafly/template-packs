#import "../lib/style.typ": placeholder, code-fig
#import "../lib/cite.typ": cf, quot, cf-multi, fig-source, fig-based-on
#import "../lib/abbr.typ": abbr

// ─── Chapter 3: Analyse am Referenzszenario ──────────────────────────────────

= Analyse am Referenzszenario <analyse>

== Vorstellung des Referenzszenarios

Als praxisnahe Grundlage für die nachfolgende Analyse dient ein fiktives mittelständisches
Fertigungsunternehmen, das im Folgenden als _Muster GmbH_ bezeichnet wird. Das Unternehmen
beschäftigt rund 500 Mitarbeiter an zwei Standorten und plant die Ablösung einer gewachsenen,
heterogenen IT-Landschaft durch ein integriertes ERP-System.

Das Investitionsvolumen beläuft sich auf ca. 800.000 EUR, verteilt über einen
Realisierungszeitraum von 24 Monaten. Ziel der Systemeinführung ist die Konsolidierung der
bislang fragmentierten Datenbestände aus Produktion, Einkauf und Finanzwesen auf einer
einheitlichen Plattform, um Echtzeittransparenz über die gesamte Wertschöpfungskette
zu schaffen.

@fig-referenzszenario illustriert die übergeordnete Systemarchitektur des Referenzszenarios.

#figure(
  image("../assets/grey.jpg"),
  caption: [Systemarchitektur des Referenzszenarios#footnote[#fig-based-on(<dumasFundamentalsBusinessProcess2018>, page: "3")]]
) <fig-referenzszenario>

== Systemarchitektur und Komponentenübersicht

=== Schichtenarchitektur

Die gewählte Zielarchitektur folgt dem Prinzip der Schichtentrennung, wobei Präsentation,
Anwendungslogik und Datenhaltung als eigenständige Schichten realisiert sind. Diese Struktur
ermöglicht eine unabhängige Skalierung einzelner Komponenten und reduziert die Kopplungsgrade
innerhalb des Gesamtsystems.#cf(<dumasFundamentalsBusinessProcess2018>, page: "4")

#figure(
  placeholder(h: 6cm, label: "Schichtenarchitektur (Placeholder)"),
  caption: [Schichtenarchitektur der Zielarchitektur#footnote[#fig-based-on(<dumasFundamentalsBusinessProcess2018>, page: "4")]]
) <fig-schichtenarchitektur>

Die Kommunikation zwischen den Schichten erfolgt über definierte API-Endpunkte, die einem
`REST`-basierten Schnittstellenstandard folgen. Dadurch können Frontend-Applikationen
unabhängig vom Backend weiterentwickelt werden, was sowohl die
#abbr("UI", "User Interface")-Entwicklung als auch die #abbr("UX", "User Experience")-Optimierung
erheblich vereinfacht.

=== Datenbankstruktur und Integrationsbus

Die persistente Datenhaltung erfolgt in einer relationalen Datenbank, auf die ausschließlich über
eine dedizierte Zugriffsschicht zugegriffen wird. Ein zentraler
#abbr("ESB", "Enterprise Service Bus") übernimmt die nachrichtenbasierte Kommunikation zwischen
Subsystemen und stellt sicher, dass Ereignisse aus dem Produktionsbereich unmittelbar in der
Finanzbuchhaltung reflektiert werden.

@tab-schnittstellen listet die wesentlichen Integrationsschnittstellen sowie deren technische
Realisierung auf.

#figure(
  caption: [Wesentliche Systemschnittstellen der Muster GmbH],
  table(
    columns: (auto, 1fr, auto),
    align: (center, center, center),
    table.hline(),
    [Schnittstelle], [Beschreibung], [Protokoll],
    table.hline(),
    [Einkauf → Finanzen],   [Übermittlung von Bestelldaten],        [`REST/JSON`],
    [Produktion → Lager],   [Warenbewegungen in Echtzeit],          [`MQTT`],
    [Lager → Finanzen],     [Bestandsbewertung],                    [`SOAP/XML`],
    [Finanzen → Reporting], [Aggregierte Kennzahlen],               [`OData`],
    table.hline(),
  )
) <tab-schnittstellen>

== Implementierungsprozess

=== Vorgehensmodell und Projektphasen

Die Projektdurchführung orientiert sich an einem hybriden Vorgehensmodell, welches sequentielle
Planungsphasen mit agilen Entwicklungsiterationen kombiniert. Dieses Vorgehen trägt der
Notwendigkeit Rechnung, einerseits verbindliche Meilensteine gegenüber dem
Lenkungsausschuss kommunizieren zu können und andererseits flexibel auf geänderte
Anforderungen zu reagieren.#cf(<tenhialaPerformanceEffectsUsing2015>, page: "150 f")

Das nachfolgende #abbr("SQL", "Structured Query Language")-Beispiel in @lst-datenbankabfrage
zeigt eine exemplarische Abfrage zur Auswertung des aktuellen Budgetstatus je Kostenstelle:

#code-fig(
  caption: [Budgetstatus je Kostenstelle abfragen],
)[
```sql
SELECT
    ks.kostenstelle_id,
    ks.bezeichnung,
    b.budget_gesamt,
    b.budget_verbraucht,
    (b.budget_gesamt - b.budget_verbraucht) AS budget_verfuegbar
FROM
    kostenstellen ks
    JOIN budgets b ON ks.kostenstelle_id = b.kostenstelle_id
WHERE
    b.geschaeftsjahr = 2026
ORDER BY
    budget_verfuegbar ASC;
```
] <lst-datenbankabfrage>

=== Konfiguration und Customizing

Die Systemkonfiguration umfasst die Anlage von Organisationsstrukturen, die Definition von
Buchungskreisen sowie die Einrichtung unternehmensindividueller Workflow-Regeln. Fehler in
dieser Phase können kaskadenartig durch die gesamte Prozesskette propagieren und sind häufig
erst im Rahmen von Periodenabschlüssen erkennbar.

@lst-konfiguration zeigt eine vereinfachte Konfigurationsstruktur in einem generischen
#abbr("DSL", "Domain-Specific Language")-Format, wie sie in modernen Deployment-Pipelines
zum Einsatz kommt:

#code-fig(
  caption: [Konfiguration der Organisationsstruktur],
)[
```yaml
organisation:
  buchungskreis: "DE01"
  waehrung: "EUR"
  geschaeftsjahr_variante: "K4"
  kostenrechnungskreis: "EU00"
  kostenstellen:
    - id: "KOST1000"
      bezeichnung: "Verwaltung"
      verantwortlicher: "Musterfrau"
    - id: "KOST2000"
      bezeichnung: "Produktion"
      verantwortlicher: "Mustermann"
```
] <lst-konfiguration>

=== Datenmigration und Qualitätssicherung

Die Migration historischer Datenbestände stellt einen kritischen Erfolgsfaktor dar, da fehlerhafte
Anfangsdaten die operativen Prozesse nach dem Go-live nachhaltig beeinträchtigen. In der Praxis
wird empfohlen, die Migration in drei Phasen zu strukturieren:#cf(<umbleEnterpriseResourcePlanning2003>, page: "248 f")

1. *Extraktion:* Übernahme der Rohdaten aus den Altsystemen in ein neutrales Zwischenformat.
2. *Transformation:* Bereinigung, Normalisierung und Anreicherung der Daten gemäß den
   Anforderungen des Zielsystems.
3. *Laden:* Kontrollierter Import in das Produktivsystem mit abschließender
   Plausibilitätsprüfung.

Die Validierung der migrierten Daten erfolgt durch automatisierte Testszenarios, die eine
Stichprobe von mindestens 10 % der Datensätze abdecken und sowohl syntaktische als auch
semantische Prüfungen umfassen. Inline-Codereferenzen wie `MAX_BATCH_SIZE = 500` oder der
API-Endpunkt `/api/v2/reports/kpi` können dabei direkt im Fließtext genutzt werden.

== Integration mit Umsystemen

=== Anbindung des Produktionssystems

Die Anbindung der Produktionssteuerung an das zentrale ERP-System erfolgt über einen
bidirektionalen Nachrichtenaustausch, bei dem Fertigungsaufträge an das Shopfloor-System
übertragen und Rückmeldungen zu Gut- und Ausschussmengen in Echtzeit zurückgemeldet werden.
Das Prinzip des _Event-Driven Architecture_-Musters stellt sicher, dass alle beteiligten Systeme
zeitnah über relevante Zustandsänderungen informiert werden.

@fig-integrationsprozess veranschaulicht den Datenfluss zwischen ERP-System und
Produktionssteuerung.

#figure(
  placeholder(h: 4cm, label: "Integrationsprozess (Placeholder)"),
  caption: [Datenfluss zwischen ERP und Produktionssteuerung#footnote[#fig-source(<dumasFundamentalsBusinessProcess2018>, page: "3")]]
) <fig-integrationsprozess>

=== Reporting und Analytics

Auf Basis der konsolidierten Datenbasis können unternehmensweite
#abbr("KPI", "Key Performance Indicator", german: "Leistungskennzahl") in Echtzeit ausgewertet
werden. Die Bereitstellung erfolgt über eine dedizierte Reporting-Schicht, die sowohl operative
Dashboards für das mittlere Management als auch strategische Berichte für die Unternehmensleitung
generiert.

@fig-dashboard zeigt einen exemplarischen Ausschnitt des operativen Dashboards.

#figure(
  placeholder(h: 5cm, label: "Operatives Dashboard (Placeholder)"),
  caption: [Exemplarisches operatives Dashboard#footnote[Eigene Darstellung; Daten fiktiv.]]
) <fig-dashboard>

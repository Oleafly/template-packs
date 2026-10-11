#import "htwg.typ": *
#import "appendix.typ": appendix
#import "abstract.typ": abstract
#import "acronyms.typ": acronyms
#import "preface.typ": preface
#import "symbols.typ": symbols, format-symbols-table

#show: htwg.with(
  title: "Titel der Arbeit",
  type: "Technischer Bericht",
  authors: (
    (
      name: "Max Mustermann", 
      student-id: "123456",
      company: (
        name: "Musterfirma GmbH",
        address: "Musterstraße 1, 12345 Musterstadt"
      )
    ),
  ),
  language: "de",
  at-university: true,
  show-declaration-of-authorship: true,
  show-table-of-contents: true,
  show-acronyms: true,
  show-list-of-figures: true,
  show-list-of-tables: true, 
  show-appendix: true,
  show-abstract: true,
  show-preface: true,
  show-header: true,
  show-student-id: true,
  show-symbols: true,
  captions-top: true,
  numbering-style: "1",
  numbering-alignment: center,  
  abstract: abstract,
  appendix: appendix,
  acronyms: acronyms,
  preface: preface,
  symbols: symbols,
  university: "HTWG-Konstanz 
    Hochschule für Technik, Wirtschaft und Gestaltung",
  department: "Maschinenbau",
  course: "MAB",  
  semester: "Sommersemester 2025",
  supervisor: "Prof. Dr. Max Mustermann",
  date: datetime.today(),
  submission-location: "Konstanz",
  bibliography: bibliography("sources.bib"),
  logo: image("assets/logos/htwg_logo.svg", width: auto),
  logo-height: 2.4cm
)

= Einleitung
In der heutigen digital vernetzten Geschäftswelt stehen Unternehmen vor der Herausforderung, ihre IT-Infrastruktur effizient zu gestalten und gleichzeitig rechtliche Vorgaben einzuhalten. Die Optimierung von Softwarelizenzen spielt dabei eine zentrale Rolle #htwgCite("brassel2019softwarelizenzmanagement", page: "12"). Die digitale Transformation ist ein fortlaufender Prozess, der alle Unternehmensbereiche betrifft #acr("IoT") und #acr("KI") sind dabei wichtige Technologietreiber.

Der Einsatz moderner Technologien wie #acr("ML") ermöglicht es Unternehmen, neue Geschäftsmodelle zu entwickeln #htwgCite("wagner2021machine", vgl: true). Gleichzeitig müssen rechtliche Aspekte wie die #acr("DSGVO") beachtet werden #htwgCite("bsi2024cybersecurity"). 

#figure(
  image("assets/img/license_cost_comparison.svg", width: 80%),
  caption: [Visualisierung des digitalen Wandels und seiner Kostenauswirkungen #htwgCite("meyer2022digitale", page: "128")]
)
<fig-digitaler-wandel>

== Problemstellung und Zielsetzung
Die vorliegende Arbeit adressiert die zentralen Herausforderungen bei der Implementierung effizienter Softwarelizenzmodelle in mittelständischen Unternehmen. Nach dieser Unterüberschrift (Level 2) sollte auch ein Abstand folgen, aber keine neue Seite beginnen.

Die Hauptproblematik liegt in der Komplexität moderner IT-Landschaften und den damit verbundenen Lizenzierungsmodellen #htwgCite("brassel2019softwarelizenzmanagement", page: "45"). Tabelle @tbl-lizenzmodelle zeigt einen Vergleich verschiedener Lizenzmodelle.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    inset: 6pt,
    align: center + horizon,
    [*Lizenzmodell*], [*Kostenstruktur*], [*Flexibilität*], [*Compliance-Aufwand*],
    [Perpetual], [Hohe Anfangsinvestition], [Niedrig], [Mittel],
    [Subscription], [Regelmäßige Zahlungen], [Mittel], [Mittel],
    [#acr("SaaS")], [Nutzungsbasiert], [Hoch], [Niedrig],
    [Open Source], [Gering/Keine], [Sehr hoch], [Niedrig]
  ),
  caption: [Vergleich verschiedener Softwarelizenzmodelle]
) <tbl-lizenzmodelle>

=== Relevanz für die Praxis
Die korrekte Auswahl von Lizenzierungsmodellen hat direkte Auswirkungen auf die Betriebskosten und Wettbewerbsfähigkeit von Unternehmen. Level-3-Überschriften haben auch einen Abstand danach, aber keine neue Seite.

== Forschungsmethodik
Die vorliegende Untersuchung basiert auf einem Mixed-Methods-Ansatz, der sowohl qualitative als auch quantitative Forschungsmethoden kombiniert #htwgCite("techniker2023industrie", pageRange: "15-18"). Die Datenerhebung erfolgte durch:

- Online-Befragung von 250 mittelständischen Unternehmen
- Experteninterviews mit 15 IT-Verantwortlichen
- Analyse von Fallstudien zur Lizenzoptimierung

Der Forschungsprozess ist in Abbildung @fig-forschungsprozess dargestellt.

= Grundlagen
Dieses zweite Kapitel beginnt auf einer neuen Seite, da es eine Level-1-Überschrift ist. Im Folgenden werden die theoretischen Grundlagen der Softwarelizenzierung und digitalen Transformation erläutert.

== Software-Lizenzierungsmodelle
Die Welt der Softwarelizenzierung hat sich in den letzten Jahren grundlegend gewandelt. Während traditionelle Lizenzmodelle auf dem Kauf von Softwarelizenzen basieren #htwgCite("brassel2019softwarelizenzmanagement", page: "77"), setzen sich zunehmend Cloud-basierte Dienste und abonnementbasierte Modelle durch #htwgCite("meyer2022digitale", pageRange: "130-132").

#figure(
  image("assets/img/research_process.svg", width: 70%),
  caption: [Entwicklung der Lizenzierungsmodelle 2010-2025 #htwgCite("meyer2022digitale", page: "135")]
) <fig-lizenz-entwicklung>

Die verschiedenen Lizenzmodelle lassen sich anhand ihrer mathematischen Kostenstruktur vergleichen. Für ein perpetuelles Lizenzmodell gilt:

$ "TotalCost"_"perpetual" = "InitialCost" + sum_(i=1)^n "MaintenanceCost"_i $

Bei abonnementbasierten Modellen ergibt sich hingegen:

$ "TotalCost"_"subscription" = sum_(i=1)^n "SubscriptionFee"_i $

Wobei $n$ die Anzahl der Betriebsjahre darstellt.

== Rechtliche Rahmenbedingungen
Die Einhaltung rechtlicher Vorgaben, insbesondere im Bereich Datenschutz, stellt einen wichtigen Aspekt bei der Softwarelizenzierung dar. Die #acr("DSGVO") definiert strikte Anforderungen an den Umgang mit personenbezogenen Daten #htwgCite("bsi2024cybersecurity", vgl: true).

Für die automatisierte Überprüfung der Lizenz-Compliance kann folgendes Code-Snippet verwendet werden:

#figure(
  sourcecode(
```python
def check_license_compliance(licenses, usage_data):
    """
    Überprüft die Compliance von Softwarelizenzen
    
    Args:
        licenses (dict): Dictionary mit Lizenzen und ihren Beschränkungen
        usage_data (dict): Nutzungsdaten der Software
        
    Returns:
        dict: Compliance-Status und potentielle Risiken
    """
    compliance_issues = []
    risk_score = 0
    
    for software, usage in usage_data.items():
        if software not in licenses:
            compliance_issues.append(f"Keine Lizenz für {software} gefunden")
            risk_score += 10
            continue
            
        license_info = licenses[software]
        
        # Überprüfe Nutzerbeschränkungen
        if usage["users"] > license_info["max_users"]:
            compliance_issues.append(
                f"{software}: {usage['users']} Nutzer überschreiten Limit von {license_info['max_users']}"
            )
            risk_score += 5
            
        # Überprüfe geografische Beschränkungen
        if "geo_restrictions" in license_info and usage["region"] in license_info["geo_restrictions"]:
            compliance_issues.append(
                f"{software}: Nutzung in Region {usage['region']} nicht erlaubt"
            )
            risk_score += 7
    
    return {
        "compliant": len(compliance_issues) == 0,
        "issues": compliance_issues,
        "risk_score": risk_score
    }
```
  ),
  caption: [Python-Funktion zur automatisierten Überprüfung der Lizenz-Compliance]
) <code-compliance>

Zudem müssen Unternehmen die Einhaltung von Lizenzvereinbarungen sicherstellen, um rechtliche Konsequenzen zu vermeiden. Die wichtigsten rechtlichen Aspekte sind in Tabelle @tbl-rechtliche-aspekte zusammengefasst.

#figure(
  table(
    columns: (auto, auto),
    inset: 6pt,
    align: (left, left),
    [*Rechtlicher Aspekt*], [*Relevanz für Softwarelizenzierung*],
    [#acr("DSGVO")], [Datenspeicherung, Datenverarbeitung, Datentransfer],
    [Urheberrecht], [Schutz des geistigen Eigentums, Lizenzbedingungen],
    [Vertragsrecht], [Rechtsgültigkeit von Lizenzvereinbarungen],
    [Kartellrecht], [Wettbewerbsrechtliche Aspekte bei Lizenzierung]
  ),
  caption: [Rechtliche Aspekte der Softwarelizenzierung]
) <tbl-rechtliche-aspekte>

=== Internationale Unterschiede
Bei international agierenden Unternehmen müssen zudem länderspezifische Unterschiede in der Gesetzgebung berücksichtigt werden #htwgCite("techniker2023industrie", page: "28").

=== Definitionen wichtiger Begriffe

Im Folgenden werden zentrale Begriffe der Softwarelizenzierung definiert:

/ Perpetual License: Eine dauerhaft gültige Lizenz, die nach einmaliger Zahlung unbegrenzt nutzbar ist. Wartungskosten können zusätzlich anfallen.

/ Subscription License: Ein zeitlich begrenztes Nutzungsrecht, das periodische Zahlungen erfordert und oft Updates und Support einschließt.

/ #acr("SaaS") (Software as a Service): Ein Bereitstellungsmodell, bei dem Software zentral gehostet und über das Internet als Dienst angeboten wird.

/ Open Source: Software, deren Quellcode öffentlich zugänglich ist und die frei genutzt, modifiziert und weitergegeben werden kann.

/ Compliance: Die Einhaltung aller rechtlichen, vertraglichen und regulatorischen Anforderungen im Zusammenhang mit Softwarelizenzen.

= Methodik
Auch dieses dritte Kapitel beginnt auf einer neuen Seite. Im Folgenden wird die methodische Vorgehensweise der Untersuchung detailliert erläutert.

== Forschungsdesign
Die vorliegende Studie basiert auf einem sequentiellen Mixed-Methods-Design, das qualitative und quantitative Forschungsmethoden kombiniert #htwgCite("wagner2021machine", pageRange: "78-80"). Der Forschungsprozess gliederte sich in drei Phasen, wie in Abbildung @fig-forschungsprozess dargestellt.

#figure(
  image("assets/img/research_process.svg", width: 75%),
  caption: [Schematische Darstellung des Forschungsprozesses]
) <fig-forschungsprozess>

== Datenerhebung und Stichprobe
Für die quantitative Datenerhebung wurde eine Online-Umfrage unter IT-Entscheidern in 250 mittelständischen Unternehmen durchgeführt. Die Stichprobe umfasste Unternehmen unterschiedlicher Branchen und Größen, wie in Tabelle @tbl-stichprobe dargestellt.

#figure(
  table(
    columns: (auto, auto, auto),
    inset: 6pt,
    align: center + horizon,
    [*Branche*], [*Anzahl Unternehmen*], [*Prozentualer Anteil*],
    [Produktion], [85], [34%],
    [IT & Telekommunikation], [62], [24.8%],
    [Handel], [45], [18%],
    [Dienstleistungen], [38], [15.2%],
    [Sonstige], [20], [8%],
    [*Gesamt*], [*250*], [*100%*]
  ),
  caption: [Zusammensetzung der Stichprobe nach Branchen]
) <tbl-stichprobe>

Die qualitative Datenerhebung erfolgte mittels semistrukturierter Experteninterviews mit 15 IT-Verantwortlichen ausgewählter Unternehmen #htwgCite("techniker2023industrie", vgl: true, page: "33"). Der verwendete Interviewleitfaden findet sich im Anhang.

= Ergebnisse
Und dieses vierte Kapitel beginnt ebenfalls auf einer neuen Seite. Im Folgenden werden die zentralen Ergebnisse der Untersuchung präsentiert.

== Quantitative Analyse der Lizenzkostenentwicklung
Die Analyse der erhobenen Daten zeigt signifikante Unterschiede in der Kostenentwicklung zwischen verschiedenen Lizenzierungsmodellen #htwgCite("meyer2022digitale", page: "137"). Abbildung @fig-kostenverlauf visualisiert die durchschnittliche Kostenentwicklung über einen Zeitraum von fünf Jahren.

#figure(
  image("assets/img/license_cost_comparison.svg", width: 80%),
  caption: [Vergleich der Kostenentwicklung verschiedener Lizenzierungsmodelle über 5 Jahre]
) <fig-kostenverlauf>

Die statistische Analyse ergab einen signifikanten Unterschied zwischen perpetuellen und abonnementbasierten Lizenzmodellen ($p < 0.01$, $n = 250$). Der Einsatz von #acr("SaaS")-Lösungen führte in 72% der untersuchten Fälle zu Kosteneinsparungen im Vergleich zu traditionellen Lizenzmodellen.

== Einfluss auf Unternehmenseffizienz
Die Implementierung moderner Lizenzmodelle und Cloud-basierter Dienste wirkt sich nachweislich positiv auf die Unternehmenseffizienz aus. Tabelle @tbl-effizienz fasst die wichtigsten Kennzahlen zusammen.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    inset: 6pt,
    align: center + horizon,
    [*Effizienzkriterium*], [*Traditionelles Modell*], [*Cloud-Modell*], [*Veränderung*],
    [IT-Verwaltungsaufwand (h/Woche)], [24.5], [12.8], [-47.8%],
    [Reaktionszeit bei Problemen (h)], [7.2], [2.1], [-70.8%],
    [Flexibilität (Skala 1-10)], [4.7], [8.3], [+76.6%],
    [Mitarbeiterzufriedenheit (Skala 1-10)], [6.2], [7.9], [+27.4%]
  ),
  caption: [Vergleich von Effizienzkriterien zwischen traditionellem und Cloud-basiertem Lizenzmodell]
) <tbl-effizienz>

Die qualitative Analyse der Experteninterviews bestätigt diese Ergebnisse und zeigt zudem, dass insbesondere der Einsatz von #acr("API")-basierten Integrationen die Effizienz weiter steigern kann #htwgCite("wagner2021machine", vgl: true, pageRange: "80-82").

== Compliance und Risikomanagement
Die Untersuchung der Compliance-Aspekte zeigt, dass 68% der befragten Unternehmen Schwierigkeiten bei der Einhaltung der #acr("DSGVO")-Anforderungen haben #htwgCite("bsi2024cybersecurity"). 

Folgende Risikobereiche wurden identifiziert:

1. Unzureichende Dokumentation von Lizenzen (73%)
2. Fehlende Prozesse für License Management (58%)
3. Unklare Verantwortlichkeiten (45%)
4. Mangelnde Schulung der Mitarbeiter (67%)

Die Implementierung eines elektronischen Lizenzmanagements (#acr("ELM")) kann diese Risiken signifikant reduzieren, wie Abbildung @fig-compliance verdeutlicht.

#figure(
  image("assets/img/compliance_radar.svg", width: 75%),
  caption: [Risikoreduktion durch Implementierung eines ELM-Systems]
) <fig-compliance>

= Diskussion
Dies ist das letzte Kapitel, und es beginnt ebenfalls auf einer neuen Seite. Die Verwendung von #acr("ELM") und anderen Technologien wird im Folgenden kritisch reflektiert.

== Interpretation der Ergebnisse
Die vorliegende Studie zeigt deutlich, dass moderne Lizenzierungsmodelle wie #acr("SaaS") und Cloud-basierte Dienste erhebliche Vorteile für Unternehmen bieten können #htwgCite("brassel2019softwarelizenzmanagement", pageRange: "80-85"). Die empirischen Ergebnisse bestätigen die in der Literatur vorherrschende Meinung, dass Cloud-Lösungen in vielen Fällen kosteneffizienter sind #htwgCite("meyer2022digitale").

Allerdings muss beachtet werden, dass die Implementierung solcher Modelle mit einem initialen Anpassungsaufwand verbunden ist, der bei der Kosten-Nutzen-Analyse berücksichtigt werden sollte. Die Übergangsphase kann durch folgende mathematische Beziehung beschrieben werden:

$ "ROI" = (sum_(i=1)^n "Benefits"_i - "InitialCost") / "InitialCost" $

Wobei der Return on Investment (ROI) erst nach einer gewissen Zeit positiv wird. Die typische Amortisationszeit liegt laut unseren Ergebnissen bei 12-18 Monaten.

Mit:
- $C_T$: Gesamtkosten über die Laufzeit
- $C_I$: Initiale Investitionskosten
- $C_M$: Jährliche Wartungskosten
- $C_L$: Jährliche Lizenzkosten (ohne Optimierung)
- $R_L$: Lizenzkostenreduktionsfaktor durch Optimierung (0-1)
- $eta_L$: Lizenznutzungseffizienz (0-1)
- $n$: Nutzungsdauer in Jahren

== Praktische Implikationen
Aus den Ergebnissen lassen sich wichtige Handlungsempfehlungen für die Praxis ableiten:

1. Unternehmen sollten eine systematische Bestandsaufnahme ihrer aktuellen Softwarelizenzen durchführen
2. Die Implementierung eines #acr("ELM")-Systems sollte erwogen werden
3. Lizenzmodelle sollten regelmäßig auf ihre Kosteneffizienz überprüft werden
4. Mitarbeiter sollten in die Nutzung neuer Systeme einbezogen werden

#figure(
  table(
    columns: (auto, auto, auto),
    inset: 6pt,
    align: (left + horizon, center + horizon, center + horizon),
    [*Handlungsempfehlung*], [*Zeitrahmen*], [*Priorität*],
    [Bestandsaufnahme durchführen], [1-2 Monate], [Hoch],
    [#acr("ELM") implementieren], [3-6 Monate], [Mittel],
    [Kostenanalyse bestehender Lizenzen], [1 Monat], [Hoch],
    [Mitarbeiterschulung organisieren], [2-3 Monate], [Mittel],
    [Compliance-Prüfung durchführen], [1-2 Monate], [Hoch]
  ),
  caption: [Übersicht der empfohlenen Maßnahmen und deren Priorisierung]
) <tbl-empfehlungen>

== Limitationen und weiterer Forschungsbedarf
Die vorliegende Studie unterliegt gewissen Limitationen, die bei der Interpretation der Ergebnisse beachtet werden sollten. Die Stichprobe konzentrierte sich hauptsächlich auf mittelständische Unternehmen in Deutschland, wodurch die Generalisierbarkeit auf andere Länder oder größere Unternehmensstrukturen eingeschränkt sein könnte #htwgCite("techniker2023industrie", vgl: true).

Für zukünftige Forschung wäre es interessant, folgende Aspekte näher zu untersuchen:

- Langzeitstudien zur Kostenentwicklung verschiedener Lizenzmodelle
- Einfluss neuer Technologien wie #acr("KI") und #acr("ML") auf Lizenzierungsmodelle
- Branchenspezifische Unterschiede in der Lizenzoptimierung
- Compliance-Herausforderungen in internationalen Kontexten

Die Integration von #acr("IoT")-Technologien in bestehende Lizenzierungskonzepte stellt ebenfalls ein vielversprechendes Forschungsfeld dar #htwgCite("wagner2021machine", pageRange: "82-85").

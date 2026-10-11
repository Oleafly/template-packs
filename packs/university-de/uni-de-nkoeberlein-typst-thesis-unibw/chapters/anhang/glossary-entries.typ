// =============================================================
// glossary-entries.typ – Glossareinträge
// =============================================================
//
// Einträge hier verwalten. Im Fließtext referenzieren:
//   @key              → beim ersten Mal vollständig, danach Kurzform
//   @key:long         → immer vollständige Form
//   @key:short        → immer Kurzform
//   @key:pl           → Plural
//   #gls("key")       → manueller Aufruf mit Optionen
//
// Pflichtfelder: key
// Optionale Felder: short, long, description, plural, longplural, group
//
// HINWEIS: Die folgenden Einträge sind Beispiele zur Demonstration.
// Eigene Abkürzungen ergänzen und nicht benötigte Einträge löschen.
// =============================================================

#let glossary-entries = (

  // ── Informatik ───────────────────────────────────────────────

  (
    key: "ki",
    short: "KI",
    long: "Künstliche Intelligenz",
    plural: "KIs",
    longplural: "Künstliche Intelligenzen",
    description: [Teilgebiet der Informatik, das sich mit der Automatisierung und Simulation intelligenten Verhaltens befasst.],
    group: "Informatik",
  ),
  (
    key: "ml",
    short: "ML",
    long: "Machine Learning",
    description: [Methoden, bei denen Algorithmen aus Daten lernen, ohne explizit programmiert zu werden. Teilbereich der @ki.],
    group: "Informatik",
  ),
  (
    key: "llm",
    short: "LLM",
    long: "Large Language Model",
    plural: "LLMs",
    description: [Auf großen Textmengen trainiertes neuronales Sprachmodell, das natürlichsprachliche Texte verarbeiten und generieren kann. Beispiele: GPT-4, Claude, Llama.],
    group: "Informatik",
  ),
  (
    key: "api",
    short: "API",
    long: "Application Programming Interface",
    plural: "APIs",
    description: [Definierte Schnittstelle, über die Softwarekomponenten miteinander kommunizieren können.],
    group: "Informatik",
  ),
  (
    key: "gui",
    short: "GUI",
    long: "Graphical User Interface",
    description: [Grafische Benutzeroberfläche zur interaktiven Bedienung eines Softwaresystems.],
    group: "Informatik",
  ),

  // ── Allgemein / Wissenschaft ──────────────────────────────────

  (
    key: "ict",
    short: "IKT",
    long: "Informations- und Kommunikationstechnologie",
    description: [Oberbegriff für alle technischen Mittel zur Verarbeitung und Übertragung von Informationen.],
    group: "Allgemein",
  ),
  (
    key: "sw",
    short: "SW",
    long: "Software",
    description: [Gesamtheit der Programme, Daten und Dokumentationen eines Computersystems. Gegenstück zur Hardware.],
    group: "Informatik",
  ),

  // ── Von Beispielkapiteln benötigt (bei eigener Arbeit ersetzen) ──────

  (
    key: "pdf",
    short: "PDF",
    long: "Portable Document Format",
    description: [Von Adobe entwickeltes, geräteunabhängiges Dateiformat für Dokumente.],
    group: "Informatik",
  ),
  (
    key: "url",
    short: "URL",
    long: "Uniform Resource Locator",
    plural: "URLs",
    description: [Eindeutige Adresse einer Ressource im Internet, z. B. einer Webseite oder Datei.],
    group: "Internet",
  ),
  (
    key: "uri",
    short: "URI",
    long: "Uniform Resource Identifier",
    plural: "URIs",
    description: [Zeichenkette zur eindeutigen Identifikation einer abstrakten oder physischen Ressource.],
    group: "Internet",
  ),
  (
    key: "ide",
    short: "IDE",
    long: "Integrated Development Environment",
    description: [Integrierte Entwicklungsumgebung: Editor, Compiler und Debugger in einer Anwendung. Beispiele: VS Code, IntelliJ.],
    group: "Informatik",
  ),
  (
    key: "os",
    short: "OS",
    long: "Operating System",
    description: [Betriebssystem. Verwaltet Hardware-Ressourcen und bietet Anwendungen eine einheitliche Schnittstelle.],
    group: "Informatik",
  ),

  // ── Weitere Einträge hier ergänzen ──────────────────────────
  // (
  //   key: "schluessel",
  //   short: "Abk.",
  //   long: "Vollständige Bezeichnung",
  //   description: [Beschreibung des Begriffs.],
  //   group: "Kategorie",
  // ),
)

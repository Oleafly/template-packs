// Anleitung für den
// Fagebogen der Fachschaft zu mündlichen Prüfungen im Informatikstudium
//
// Du kannst dieses Dokument auf zwei Arten verwenden.  Einmal kannst du es so
// wie es ist ausdrucken und von Hand ausfüllen.  In diesem Fall sind alle
// weiteren Instruktionen hinfällig.
//
// Zum anderen kannst du entsprechend den Kommentaren in dieser Datei verfahren
// um dein Protokoll elektronisch auszufüllen.
//
// Passe hierzu das unten stehende `data` Dictionary, entsprechend der Kommentare
// und Beispielwerte an. Optionale Felder können bei `none` belassen werden.
// Alle anderen solltest du ausfüllen. Wenn du die Antwort auf eine Frage nicht weißt
// oder nicht angeben möchtest, kannst du den speziellen Wert `#N-A#` verwenden.
//
// Anschließend kannst du längere Ausführungen im Freitextteil der Datei
// `mein-freitext-protokoll.typ` unterbringen.  Dieser wird automatisch
// in die `main.typ` Datei eingefügt.
//
// Um die PDF zu erstellen, compiliere die `main.typ` Datei:
// `typst compile --format pdf --pdf-standard=a-2b main.typ fsmi-protocol.pdf`
//
//  Bitte überprüfe vor dem Ausdrucken, dass deine Antworten in den dafür
//  vorgesehenen Feldern Platz haben und passe sie gegebenenfalls entsprechend
//  an.
#import "template/fsmi-template.typ": N-A, protocol-template

#let data = (
  // Was studierst du? ("Informatik", "Mathematik", "Physik")
  // studiengang: "Informatik",
  studiengang: none,
  // Optional. Für welchen Abschluss studierst du gerade? (none, "Bachelor", "Master", "Diplom")
  // abschluss: "Bachelor",
  abschluss: none,
  // In welchem Fach wurdest du geprüft? ("Lineare Algebra I", "On Sunflowers and Matrix Multiplication")
  // prüfungsfach: Lineare Algebra I,
  prüfungsfach: none,
  // Optional. Wo findet sich das Fach in deinem Studienleistungen wieder?
  // "W" - Wahlpflichtfach
  // "V" - Vertiefungsfach
  // "E" - Ergänzungsfach
  // none - keine Ahnung/keine Angabe
  fachart: none,
  // Was war das Datum der Prüfung?
  // prüfungsdatum: datetime(year: 2025, month: 01, day: 01),
  prüfungsdatum: none,
  // Wer war der Prüfer/die Prüferin?
  prüferIn: (
    // name: "Peter Sanders",
    name: none,
    // Optional. Du kannst auf das Institut oder Website der Person verweisen.
    // verweis: "Institut für theoretische Informatik",
    verweis: none,
  ),
  // Wer war der Beisitzer/die Beisitzerin?
  beisitzerIn: (
    // name: N-A,
    name: none,
    // Optional. Du kannst auf das Institut oder Website der Person verweisen.
    verweis: none,
  ),
  //
  // Über welche Veranstaltungen wurdest du geprüft?
  //
  // Bitte erstelle für jede Veranstaltung ein Dictionary (siehe Beispiel unten).
  // WICHTIG: 1-elementige Listen benötigen in Typst ein nachgestelltes Komma!
  // Der Platz in der Tabelle ist einigermaßen beengt, also prüfe bitte, ob deine
  // Angaben sinnvoll Platz haben und benutze erforderlichenfalls Abkürzungen.
  // veranstaltungen: (
  //   (
  //     // Titel der Veranstaltung
  //     titel: "Algorithmik II",
  //     // Dozent(in)
  //     dozentIn: "Peter Sanders",
  //     // Jahr bzw. Semester, in dem du die Veranstaltung gehört hast
  //     jahr: "WS 2025/2026",
  //     // Wie regelmäßig hast du die Veranstaltung besucht?
  //     besuch: "meistens, ca. 80%",
  //   ), // WICHTIG: 1-elementige Listen benötigen in Typst ein nachgestelltes Komma!
  // ),
  veranstaltungen: none,
  // Welche Note hast du bekommen?
  // note: "1.0",
  note: none,
  // Optional. Fandest du die Note angemessen?
  // fairness: "Kann mich nicht beschweren.",
  fairness: none,
  // Wie lange hat die Prüfung gedauert?
  // dauer: "ca. 30 Minuten",
  dauer: none,
  // Als nächstes kommen einige Fragen, auf die du etwas längere, ausformulierte
  // Antworten geben kannst. Du kannst Typst Syntax verwenden, um z.B. Absätze zu  erstellen.
  //
  // Wie war der Prüfungsstil des Prüfers / der Prüferin?
  //
  // Prüfungsatmosphäre, (un)klare Fragestellungen, Frage nach Einzelheiten oder
  // eher größeren Zusammenhängen, kamen häufiger Zwischenfragen oder ließ er /
  // sie dich erzählen, wurde dir weitergeholfen, wurde in Wissenslücken gebohrt?
  prüfungsstil: [
    // ...
  ],
  // Hat sich der Besuch / Nichtbesuch der Veranstaltung für dich gelohnt?
  besuch-gelohnt: [
    // ...
  ],
  // Wie lange und wie hast du dich alleine oder mit anderen auf die Prüfung
  // vorbereitet?
  vorbereitung: [
    // ...
  ],
  // Welche Tipps zur Vorbereitung kannst du geben?
  //
  // Wichtige / unwichtige Teile des Stoffes, gute Bücher / Skripten, Lernstil, …
  vorbereitung-tipps: [
    // ...
  ],
  // Kannst du ihn / sie weiterempfehlen?  Warum?
  // Der erste Parameter
  empfehlung: (
    // Optional.
    // none - keine Angabe
    // true - Empfehlung
    // false - keine Empfehlung
    ja: none,
    // Begründung deiner Empfehlung
    begründung: [
      // ...
    ],
  ),
  // Fanden vor der Prüfung Absprachen zu Form oder Inhalt statt? Wurden sie
  // eingehalten?
  absprachen: [
    // ...
  ],
  // Kannst du Ratschläge für das Verhalten in der Prüfung geben?
  verhalten-rat: [
    // ...
  ],
)

// --- NICHT ANFASSEN ----------------------------------------|
#let your-protocol = include "mein-freitext-protokoll.typ" // |
#show: protocol-template(data, your-protocol)              // |
// --- NICHT ANFASSEN ----------------------------------------|

// Deinen Freitext Teil kannst du in der Datei `mein-freitext-protokoll.typ` einfügen.

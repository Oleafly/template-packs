// etc/appendix.typ
// ═══════════════════════════════════════════════════════════════════════════
// Anhang (H 3.10, optional)
//
// Der Anhang ist Teil des PDF: Material, das den Textfluss stören würde, aber
// mitgedruckt wird. Dateien, die du separat als Beigaben-ZIP abgibst, gehören
// NICHT hierher, sondern ins Beigabenverzeichnis (etc/attachments.typ, H 3.12).
//
// Regeln aus den Hinweisen:
// - Das Zwischenblatt "Anhang" setzt das Template automatisch davor.
// - "Jeder in sich geschlossene Teil des Anhangs wird mit einer fortlaufenden
//   Anlagenummer und mit einer entsprechenden Überschrift versehen und ins
//   Inhaltsverzeichnis aufgenommen."
//   → Dafür einfach eine Überschrift der Ebene 1 (`=`) schreiben. Das Template
//     nummeriert sie automatisch als "Anlage 1", "Anlage 2", … und nimmt sie
//     ins Inhaltsverzeichnis auf. Jede Anlage beginnt auf einer neuen Seite.
// - Jeder Anhang muss im Textteil mindestens einmal erwähnt werden
//   ("… siehe Anlage 1").
// - Umfang: "Ein Anhang sollte keinesfalls mehr als die Hälfte des Textteils
//   umfassen."
// - Fremde Quellen im Anhang unter der Anlage nachweisen (`#quelle[…]`).
//
// Nicht benötigt? In main.typ `appendix_src: none` setzen.
// ═══════════════════════════════════════════════════════════════════════════

#import "../lib/components.typ": quelle, quelle-links

= Aufbau des Anhangs

Jede Anlage beginnt mit einer Überschrift der Ebene 1 (`= Titel`) und erhält
damit automatisch die nächste Anlagenummer sowie einen Eintrag im
Inhaltsverzeichnis. Untergliedern lässt sich eine Anlage mit den üblichen
Überschriftenebenen (`==`, `===`); im Anhang werden diese nicht weiter
durchnummeriert.

Typische Inhalte des Anhangs sind lange Datentabellen, Programm-Listings,
umfangreiche Modelle sowie Erhebungsinstrumente wie Interviewleitfäden oder
Fragebögen.

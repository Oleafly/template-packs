// =============================================================================
// FOM-Template: Zentrale Layout-Konstanten
// Quelle: FOM-Leitfaden zur formalen Gestaltung von Seminar- und
//         Abschlussarbeiten (Stand Januar 2024), Kapitel 1.2 "Layout"
// =============================================================================
// Alle Werte sind hier zentral definiert, damit Anpassungen (z. B. nach
// Absprache mit dem Erstgutachter) an genau einer Stelle erfolgen können.

// --- Schrift -----------------------------------------------------------------
// Leitfaden 1.2 Nr. 2a: Schriftgrad 12 pt (Times New Roman) bzw. angepasst
// für andere Schrifttypen (z. B. Arial in 11,5 pt).
// Die Fallback-Schriften greifen, wenn Times New Roman nicht installiert ist
// (z. B. auf Linux-CI-Systemen: Liberation Serif ist metrisch kompatibel).
#let schrift-fallbacks = ("Liberation Serif",)

// Ermittelt den korrekten Schriftgrad zur gewählten Schriftart.
#let schriftgroesse-fuer(schriftart) = {
  if lower(schriftart) == "arial" { 11.5pt } else { 12pt }
}

// Damit die Fallback-Schrift überall gefunden wird, liegt Liberation Serif
// im Ordner /fonts des Projekts. Beim Kompilieren von Hand ggf. angeben:
//   typst compile --font-path fonts main.typ thesis.pdf
// (Makefile, Skripte und CI übernehmen das automatisch.)

// --- Zeilenabstand -----------------------------------------------------------
// Leitfaden 1.2 Nr. 2a: Zeilenabstand im Text 1,5-zeilig.
// Word erzeugt bei Times New Roman 12 pt und 1,5-zeiligem Abstand einen
// Grundlinienabstand von ca. 20,7 pt. Typst berechnet den Grundlinienabstand
// als leading + Versalhöhe (cap-height, bei TNR 0,662 em):
//   20,7 pt = leading + 7,95 pt  =>  leading = 12,75 pt = 1,06 em
#let zeilenabstand = 1.06em

// Leitfaden 1.2 Nr. 2a: Absatzabstand 0 pt davor, 6 pt danach.
// Typst kennt nur einen Gesamtabstand zwischen Absätzen: Zeilenabstand + 6 pt.
#let absatzabstand = zeilenabstand + 6pt

// Leitfaden 1.2 Nr. 2b: Abstand bei Überschriften (inkl. Beschriftungen von
// Abbildungen, Tabellen und Formeln): 12 pt davor, 6 pt danach.
#let abstand-vor-ueberschrift = zeilenabstand + 12pt
#let abstand-nach-ueberschrift = zeilenabstand + 6pt

// --- Fußnoten ----------------------------------------------------------------
// Leitfaden 1.2 Nr. 2c: Fußnoten einzeilig, 10 pt (TNR) bzw. 9,5 pt (Arial),
// Empfehlung: linksbündig.
#let fussnoten-groesse-fuer(schriftart) = {
  if lower(schriftart) == "arial" { 9.5pt } else { 10pt }
}
#let fussnoten-zeilenabstand = 0.45em // entspricht einzeiligem Word-Abstand

// --- Seitenlayout ------------------------------------------------------------
// Leitfaden 1.2 Nr. 9: Seitenränder oben 4 cm, unten 2 cm, links 4 cm,
// rechts 2 cm. Kopf- und Fußzeile jeweils 2 cm vom Seitenrand.
#let seitenraender = (top: 4cm, bottom: 2cm, left: 4cm, right: 2cm)

// Abstand der Kopfzeile (Seitenzahl) vom Satzspiegel: platziert die
// Seitenzahl ca. 2 cm unterhalb der oberen Blattkante.
#let kopfzeilen-abstand = 1.75cm

// --- Literaturverzeichnis ----------------------------------------------------
// Leitfaden 2.6: einfacher Zeilenabstand innerhalb der Einträge,
// 1-facher Abstand zwischen den Einträgen, hängender Einzug ab Zeile 2.
#let literatur-zeilenabstand = 0.45em
#let literatur-eintragsabstand = 1.1em

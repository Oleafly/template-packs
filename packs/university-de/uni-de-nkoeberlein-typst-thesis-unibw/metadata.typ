// =============================================================
// metadata.typ – Alle persönlichen Angaben HIER eintragen!
// Dies ist die einzige Datei, die du vor dem Schreiben anpassen musst.
// =============================================================

// --- Autor ---
#let myname = "Vorname Nachname"
#let matricle = "Matrikelnummer"

// --- Arbeit ---
#let mytitle = "Titel der Arbeit"
#let myseminar = "Oberbegriff oder Seminartitel" // Leer lassen ("") wenn kein Themenbereich
#let mytype = "Seminararbeit"   // Bachelorarbeit / Masterarbeit / Seminararbeit

// --- Institution ---
#let myuniversity = "Universität der Bundeswehr München"
#let myfaculty = "Fakultät für Informatik"
#let myinstitute = "Institut für ..."
#let myprofessur = "Prof. Dr. Mustermann"

// --- Betreuer (optionale Felder: "" = wird auf der Titelseite ausgeblendet) ---
#let reviewerone = "Prof. Dr. Mustermann"
#let reviewertwo = ""         // Zweitgutachter, "" wenn keiner
#let advisor = ""         // Betreuer/Ansprechpartner, "" wenn keiner

// --- Datum & Ort ---
#let timeend = datetime.today() // oder z.B. "10.12.2026" um es manuell anzugeben
#let myplace = "Neubiberg"

// --- Metadaten als Dictionary (wird an template übergeben) ---
#let meta = (
  myname: myname,
  matricle: matricle,
  mytitle: mytitle,
  myseminar: myseminar,
  mytype: mytype,
  myuniversity: myuniversity,
  myfaculty: myfaculty,
  myinstitute: myinstitute,
  myprofessur: myprofessur,
  reviewerone: reviewerone,
  reviewertwo: reviewertwo,
  advisor: advisor,
  timeend: timeend,
  myplace: myplace,
)

// =============================================================
// VALIDIERUNG (optional)
// Einkommentieren um sicherzustellen, dass alle Pflichtfelder
// ausgefüllt sind – Kompilierung schlägt dann mit klarer
// Fehlermeldung fehl, solange Platzhalter stehen.
// =============================================================
// #assert(myname   != "Vorname Nachname", message: "metadata.typ ➜ 'myname' anpassen!")
// #assert(mytitle  != "Titel der Arbeit", message: "metadata.typ ➜ 'mytitle' anpassen!")
// #assert(matricle != "Matrikelnummer",   message: "metadata.typ ➜ 'matricle' anpassen!")



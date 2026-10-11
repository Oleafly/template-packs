// Genera il thumbnail del frontespizio per Typst Universe.
// Compila con:
//   typst compile thumbnail.typ thumbnail.png --format png --pages 1

#import "lib.typ": thesis-setup

#show: thesis-setup.with(
  titolo:       "Titolo dell'Elaborato di Tesi",
  autore:       "Mario Rossi",
  matricola:    "123456",
  relatore:     "Prof. Luigi Bianchi",
  correlatore:  "Dott. Anna Verdi",
  universita:   "Università degli Studi di Modena e Reggio Emilia",
  dipartimento: "<Dipartimento>",
  corso:        "<Corso di Laurea>",
  anno_acc:     "Anno Accademico 2024/2025",
  logo:         none,   // sostituisci con image("template/images/unimore/logo.png", width: 8cm)
)

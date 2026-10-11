/*
  File: daftarTabel.typ
  Description: Generates the List of Tables. It specifically filters the document
               for elements classified as 'table' within the figure kind.
*/

= DAFTAR TABEL
#v(1cm)
#outline(
  title: none,
  target: figure.where(kind: table),
)

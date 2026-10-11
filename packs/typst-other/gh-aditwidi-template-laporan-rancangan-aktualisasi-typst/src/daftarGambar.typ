/*
  File: daftarGambar.typ
  Description: Generates the List of Figures and Illustrations. It specifically filters
               the document for elements classified as 'image' within the figure kind.
*/

= DAFTAR GAMBAR
#v(1cm)
#outline(
  title: none,
  target: figure.where(kind: image),
)

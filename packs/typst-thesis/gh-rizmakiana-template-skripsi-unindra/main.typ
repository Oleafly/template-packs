#import "config/config.typ": *

#show: document_style

#set page(numbering: "i")

#include "frontmatter/cover.typ"              // Sampul
#include "frontmatter/approval.typ"           // Lembar Persetujuan
#include "frontmatter/ratification.typ"       // Lembar Pengesahan
#include "frontmatter/declaration.typ"        // Lembar Pernyataan
#include "frontmatter/abstract.typ"           // Abstrak
#include "frontmatter/motto.typ"              // Moto
#include "frontmatter/preface.typ"            // Kata Pengantar
#include "frontmatter/toc.typ"                // Daftar Isi 
#include "frontmatter/list-of-table.typ"      // Daftar Tabel
#include "frontmatter/list-of-image.typ"      // Daftar Gambar
#include "frontmatter/list-of-attachment.typ" // Daftar Lampiran

#set page(numbering: "1")
#counter(page).update(1)

#include "chapter/1.typ"                      // BAB I
#include "chapter/2.typ"                      // BAB II
#include "chapter/3.typ"                      // BAB III
#include "chapter/4.typ"                      // BAB IV
#include "chapter/5.typ"                      // BAB V

#include "backmatter/reference.typ"           // Referensi
#include "backmatter/source-person.typ"       // Narasumber
#include "backmatter/author-bio.typ"          // Biografi Penulis
#include "backmatter/attachment.typ"          // Lampiran
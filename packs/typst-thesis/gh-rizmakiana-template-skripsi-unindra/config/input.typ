#let thesis-title = "Template SKRIPSI UNINDRA dengan TYPESETTING Typst"

#let name = "Rizky Maulana Donny F"
#let npm = "202243502885"

#let study-program = "Program Studi Teknik Informatika"
#let faculty = "Fakultas Teknik dan Ilmu Komputer"

// Pembimbing Materi
#let thesis-advisor1 = "Retno Nengsih S.Pd, M.Pd"
#let thesis-advisor1-id = "1234567890"

// Pembimbing Teknik
#let thesis-advisor2 = "Aulia Paramita S.Kom, M.Kom"
#let thesis-advisor2-id = "1234567890"

#let rector-university = "Prof. Dr. H. Sumaryoto"
#let secretary-of-university = "Ir. Soepardi Harris, M.T"

#let examiner1 = "Forkas Tiroy Santos Butarbutar, M.Kom."
#let examiner2 = "Reza Avrizal, S.T., M.M., M.Kom."
#let examiner3 = "Rahmat Pujiyanto, M.Kom"

#let keyword = (
  "Typst",
  "Typesetting",
  "LaTeX",
  "Java",
  "SpringBoot",
) // Kata kunci untuk abstrak. 3-5 kata

#let abstract-point-e = [Bagian ini diuraikan minimal terdiri atas tujuan penelitian, metode penelitian, dan hasil penelitian dengan maksimal jumlah kata yang digunakan 200-250.]


#let motto = "Man jadda wa jadda"

#let dean = "Ir. H. Soepardi Harris, M.T.,"
#let head-of-department = "Mei Lestari, M.Kom"
#let secretary-of-department = "Ni Wayan Parwati Septiani, MM., M.Kom"





#let months = (
  "Januari", 
  "Febuari",
  "Maret",
  "April",
  "Mei",
  "Juni",
  "Juli",
  "Agustus",
  "September",
  "Oktober",
  "November",
  "Desember"
)

#let today = datetime.today(offset: +7)
#let today_month = months.at(today.month() - 1)
#let today_year = today.year()

#let author_name = "Muhammad Qarani"
#let author_id = "NIM. 2155301097"
#let author_gen = "21"

#let report_type = "Proposal Proyek Akhir"
//#let report_type = "Laporan Proyek Akhir"
#let title_txt = "Implementasi Penulisan Proyek Akhir dalam Typst"
#let title_block = [
  Implementasi Proyek Akhir\
  dalam Typst
  \
  \
  \
]

// datetime in typst only support english locale
#let today = datetime.today()
//#let date_of_release = [#today.display("[month repr:long] [day], [year]")]
#let date_of_release = [18 Juni 2025]
#let year = today.year()


#let advisor_honorific = "Bapak"
#let advisor_name = "Nama Pembimbing"
#let advisor_id = "NIP. 123456"

#let reviewer_names = (
  "Nama Reviewer 1",
  "Nama Reviewer 2",
)
#let reviewer_ids = (
  "NIP. 123456",
  "NIP. 123456",
)
#let reviewer_honorifics = (
  "Bapak",
  "Ibu",
)


#let head_of_study_honorific = "Ibu"
#let head_of_study_name = "Nama Kaprodi"
#let head_of_study_id = "NIP. 123456"

#let coord_honorific= "Ibu"
#let coord_name = "Nama Koor"
#let coord_id = "NIP. 123456"

#let campus_name = "Politeknik Caltex Riau"
#let program_of_study = "Program Studi Teknik Informatika"
#let degree = "Sarjana Terapan Komputer (S. Tr. Kom.)"


#let lang = "id"
#let hyphenate = true

#let root_font_size = 11pt
#let root_font = "Times New Roman"

#let heading_1_font_size = if report_type == "Laporan Proyek Akhir" {12pt} else {14pt}
#let heading_1_font_weight = "bold"
#let heading_1_bottom_padding = if report_type == "Laporan Proyek Akhir" {18pt} else {2.5em * .25}

#let heading_n_font_size = 11pt
#let heading_n_font_size = if report_type == "Laporan Proyek Akhir" {11pt} else {12pt}
#let heading_n_font_weight = "bold"
#let heading_n_bottom_padding = 8pt
#let heading_n_bottom_padding = if report_type == "Laporan Proyek Akhir" {8pt} else {1.5em * .25}

#let par_first_line_indent = 3 * root_font_size
#let par_first_line_indent_all = true

#let appendix_subheading_outline = false
#let virtual_appendix_page = state("virtual_appendix_page", 1)
#let footer_logo_width = 3cm

#let page_layout = if report_type == "Laporan Proyek Akhir" {
  "a5"
} else {
  "a4"
}
#let page_margin = if report_type == "Laporan Proyek Akhir" {
  (
    top: 1.5cm,
    right: 1.5cm,
    left: 2cm,
    bottom: 1.5cm,
  )
} else {
  (
    top: 3cm,
    right: 3cm,
    left: 4cm,
    bottom: 3cm,
  )
}

#let cover_bg_primary_color = rgb(127,127,127,255)
#let cover_bg_secondary_color = white
#let cover_bg_line_color = red
#let cover_bg_line_stroke_color = rgb(56,93,138,255)


#let abstract_ringkasan = if report_type == "Laporan Proyek Akhir" {
  "Abstrak"
} else {
  "Ringkasan"
}

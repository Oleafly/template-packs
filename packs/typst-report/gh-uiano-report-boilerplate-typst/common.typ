// In this file one adds imports and variables which should be available
// throughout the entire project
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#import "@preview/dashy-todo:0.1.3": todo

// Language of the report
// nb: norsk bokmål
// nn: norsk nynorsk
// en: english
#let report_lang = "nb"
// Titlepage variables
#let report_title = "Obligatorisk Innlevering 1"
#let report_group = "Gruppe 0"
#let report_authors = "Ed Mercer, John LaMarr and Gordon Malloy"
#let report_course_code = "IKT100"
#let report_course_name = "Nettverk, sikkerhet og personvern"
#let report_department = "Institutt for informasjons- og kommunikasjonsteknologi"
#let report_faculty = "Fakultet for teknologi og realfag"


// NOTE: The lines below calculate variables based of the selected language.
// These should not need to be touched unless one is adding support for a new
// language.
#let report_lang_error_msg = "Unknown language. Template supports nb, nn,and en"
// Titlepage calculated variables
#let titlepage_img_path= if report_lang == "nb" {
  "images/uia_norsk.png"
} else if  report_lang == "nn" {
  "images/uia_norsk.png"
} else if report_lang == "en" {
  "images/uia_eng.png"
} else {report_lang_error_msg}

#let titlepage_in = if report_lang == "nb" {
  "i"
} else if  report_lang == "nn" {
  "i"
} else if report_lang == "en" {
  "in"
} else {report_lang_error_msg}

#let titlepage_consisting_of = if report_lang == "nb" {
  "Bestående av"
} else if  report_lang == "nn" {
  "Bestående av"
} else if report_lang == "en" {
  "Consisting of"
} else {report_lang_error_msg}

// Listing names
// table of contents
#let report_listing_contents = if report_lang == "nb" {
  "Innholdsfortegnelse"
} else if  report_lang == "nn" {
  "Innholdsfortegnelse"
} else if report_lang == "en" {
  "Table of contents"
} else {report_lang_error_msg}

// Figure listing name
#let report_listing_figure = if report_lang == "nb" {
  "Figurliste"
} else if  report_lang == "nn" {
  "Figurliste"
} else if report_lang == "en" {
  "Figure listings"
} else {report_lang_error_msg}

// Table listing name
#let report_listing_table = if report_lang == "nb" {
  "Tabellliste"
} else if  report_lang == "nn" {
  "Tabellliste"
} else if report_lang == "en" {
  "Table listings"
} else {report_lang_error_msg}

// code listing name
#let report_listing_code = if report_lang == "nb" {
  "Kodeliste"
} else if  report_lang == "nn" {
  "Kodeliste"
} else if report_lang == "en" {
  "Code listings"
} else {report_lang_error_msg}

#let report_listing_bib = if report_lang == "nb" {
  "Referanser"
} else if  report_lang == "nn" {
  "Referanser"
} else if report_lang == "en" {
  "Bibliography"
} else {report_lang_error_msg}

// Localised datetime
#let report_datetime = if report_lang == "nb" {
  datetime.today().display("[day].[month].[year]")
} else if  report_lang == "nn" {
  datetime.today().display("[day].[month].[year]")
} else if report_lang == "en" {
  datetime.today().display()
} else {report_lang_error_msg}

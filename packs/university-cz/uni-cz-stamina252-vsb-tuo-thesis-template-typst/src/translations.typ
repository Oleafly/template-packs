#import "../meta.typ": thesis_type, thesis_lang

#let abstract_en = "Abstract"

#if thesis_type == "doctoral" {
  abstract_en = "Abstract and Contributions"
}

#let keywords_en = "Keywords"

#let abstract_local = "Abstrakt"

#if thesis_type == "doctoral"{
  if thesis_lang == "en" or thesis_lang == "cs" {
    abstract_local = "Abstrakt a přínos práce"
  } else if thesis_lang == "sk" {
    abstract_local = "Abstrakt a prínos práce"
  }
}

#let keywords_local = "Klíčová slova"
#if thesis_lang == "sk" {
  keywords_local = "Kľúčové slová"
}

#let type_en = (bachelor: "Bachelor Thesis", master: "Diploma Thesis", doctoral: "PhD Thesis", ).at(thesis_type)
#let supervisor_label_en = (bachelor: "Supervisor: ", master: "Supervisor: ", doctoral: "Supervisor: ", ).at(thesis_type)
#let type_cs = (bachelor: "Bakalářská práce", master: "Diplomová práce", doctoral: "Disertační práce", ).at(thesis_type)
#let supervisor_label_cs =  (bachelor: "Vedoucí práce: ", master: "Vedoucí práce: ", doctoral: "Školitel: ", ).at(thesis_type)
#let type_sk = (bachelor: "Bakalářská práce", master: "Diplomová práce", doctoral: "Disertační práce", ).at(thesis_type)
#let supervisor_label_sk = (bachelor: "Vedoucí práce: ", master: "Vedoucí práce: ", doctoral: "Školitel: ", ).at(thesis_type)
#let translations = (
  en: (
    type: type_en,
    supervisor_label: supervisor_label_en,
    acknowledgement: "Acknowledgement",
    contents: "Contents",
    acronyms_symbols: "List of abbreviations and symbols",
    list_of_figures: "List of figures",
    list_of_tables: "List of tables",
    list_of_listings: "List of listings",
    references: "Bibliography",
    appendix: "Appendix",
    chapter: "Chapter",
    figure: "Figure",
    table: "Table",
    listing: "Listing",
  ),
  cs: (
    type: type_cs,
    supervisor_label: supervisor_label_cs,
    acknowledgement: "Poděkování",
    contents: "Obsah",
    acronyms_symbols: "Seznam použitých zkratek a symbolů",
    list_of_figures: "Seznam obrázků",
    list_of_tables: "Seznam tabulek",
    list_of_listings: "Seznam výpisů",
    references: "Literatura",
    appendix: "Příloha",
    chapter: "Kapitola",
    figure: "Obrázek",
    table: "Tabulka",
    listing: "Výpis",
  ),
  sk: (
    type: type_sk,
    supervisor_label: supervisor_label_sk,
    acknowledgement: "Poďakovanie",
    contents: "Obsah",
    acronyms_symbols: "Zoznam použitých skratiek a symbolov",
    list_of_figures: "Zoznam obrázkov",
    list_of_tables: "Zoznam tabuliek",
    list_of_listings: "Zoznam zoznamov",
    references: "Literatura",
    appendix: "Dodatok",
    chapter: "Kapitola",
    figure: "Obrázok",
    table: "Tabuľka",
    listing: "Zoznam",
  ),
)
#let tran = translations.at(thesis_lang)

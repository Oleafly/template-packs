
// Icon package / Package pour les icônes de font awesome
#import "@preview/fontawesome:0.6.0": fa-icon

// Catppuccin theme package / Package pour les palettes de couleur catppuccin
#import "@preview/catppuccin:1.0.1": catppuccin, flavors, get-flavor

// Listing package for alignment / Package pour l'alignemnt des listes avec les blocs ou box
#import "@preview/itemize:0.2.0" as el
#show: el.default-enum-list

// Default palette color
#let colors = get-flavor("latte").colors

//
// Args :
// - *flavor* : Catppuccin Flavor / Palette de couleur choisie pour Catppuccin
// - *color* : Color selected / Couleur souhaitée
// 
#let get_color(flavor: "latte", color: "blue") = {
  let palette = get-flavor(flavor).colors
  if color == "lavender" {
    return palette.lavender.rgb
  } else if color == "blue" {
    return palette.blue.rgb
  } else if color == "green" {
    return palette.green.rgb
  } else if color == "red" {
    return palette.red.rgb
  } else if color == "mauve" {
    return palette.mauve.rgb
  } else if color == "yellow" {
    return palette.yellow.rgb
  } else if color == "maroon" {
    return palette.maroon.rgb
  } else if color == "peach" {
    return palette.peach.rgb
  } else if color == "pink" {
    return palette.pink.rgb
  } else if color == "text" {
    return palette.text.rgb
  } else if color == "base" {
    return palette.base.rgb
  } else if color == "mantle" {
    return palette.mantle.rgb
  } else if color == "crust" {
    return palette.crust.rgb
  } else if color == "black" {
    return black
  } else if color == "white" {
    return white
  }
}

// 
// Block configuration / Configuration des blocs
// 

//
// Args :
// - *title* : Block title / Titre du bloc
// - *flavor* : Catppuccin Flavor / Palette de couleur choisie pour Catppuccin
// - *title_color* : Title color / Couleur du titre
// - *text_color* : Text color / Couleur du texte
// - *fill_color* : Block background color / Couleur du bloc
// - *linebreak* : Boolean to add a line after the title / Booléen pour sauter ou non une ligne après le titre
// - *show_icon* : Boolean to show the icon / Booléen pour afficher ou non l'icône
// - *icon* : Icon label / Le label de l'icône sur font awesome
// - *solid_icon* : Boolean to show the solid version of the icon / Booléen pour afficher la version "solide" de l'icône
// 
#let note(title: "Note", flavor: "latte", title_color: "lavender", text_color: "black", fill_color: "base", linebreak: true, show_icon: true, icon: "circle-info", solid_icon: false, content) = {

  if flavor == "mocha" and (fill_color == "lavender" or fill_color == "green" or fill_color == "blue" or fill_color == "mauve" or fill_color == "red") {
    title_color = "black"
    text_color = "black"
  }

  if flavor == "mocha" and fill_color != "lavender" and fill_color != "green" and fill_color != "blue" and fill_color != "mauve" and fill_color != "red" {
    text_color = "text"
    fill_color = "crust"
  }

  let tl_color = get_color(flavor: flavor, color: title_color)
  let tx_color = get_color(flavor: flavor, color: text_color)
  let f_color = get_color(flavor: flavor, color: fill_color)

  block(
    fill: f_color,
    inset: 10pt,
    width: 100%,
    radius: 3pt,
    if show_icon { fa-icon(icon, fill: tl_color, solid: solid_icon) + "  "} + text(title + if linebreak [ \ ] else { "  " }, tl_color, weight: "bold") + text(tx_color, content),
  )
}

#let skill = note.with(
  title: "Compétences", 
  title_color: "white",
  text_color: "white",
  fill_color: "lavender"
)

#let tip = note.with(
  title: "Aide", 
  title_color: "white",
  text_color: "white",
  fill_color: "green",
  icon: "circle-question", 
  solid_icon: true
)

#let comment = note.with(
  title: "Remarque", 
  title_color: "white",
  text_color: "white",
  fill_color: "blue"
)

#let important = note.with(
  title: "Important", 
  title_color: "white",
  text_color: "white",
  fill_color: "mauve",
  icon: "circle-exclamation"
)

#let warning = note.with(
  title: "Attention", 
  title_color: "white",
  text_color: "white",
  fill_color: "red",
  icon: "triangle-exclamation"
)

//
// Pill configuration / Configuration des pills
//
// Args :
// - *flavor* : Catppuccin Flavor / Palette de couleur choisie pour Catppuccin
// - *text_color* : Text color / Couleur du texte
// - *fill_color* : Block background color / Couleur du bloc
// - *show_icon* : Boolean to show the icon / Booléen pour afficher ou non l'icône
// - *icon* : Icon label / Le label de l'icône sur font awesome
// - *solid_icon* : Boolean to show the solid version of the icon / Booléen pour afficher la version "solide" de l'icône
// 

#let pill(flavor: "latte", text_color: "black", fill_color: "crust", show_icon: true, icon: "file-pdf", solid_icon: false, content) = {

  if flavor == "mocha" {
    text_color = "black"
  }

  if flavor == "mocha" and fill_color == "crust" {
    text_color = "text"
  }

  let t_color = get_color(flavor: flavor, color: text_color)
  let f_color = get_color(flavor: flavor, color: fill_color)

  "   " + box(
    fill: f_color,
    outset: 4pt,
    radius: 10pt,
    if show_icon { fa-icon(icon, fill: t_color, size: 7pt, solid: solid_icon)} + " " + text(t_color, content, weight: "bold"),
  )
}


#let code(font: "Cascadia Code", text_color: black, content) = text(font: font, fill: text_color, content)

//
// Document template / Template des documents
// 
// Args :
// - *title* : Document title / Titre du document
// - *school* : School or company / Ecole ou structure
// - *page_paper* : The document paper format / Format de la page (A4, A3, ...)
// - *landscape* : Boolean to choose a landscape format / Booléen pour choisir le format paysage ou portrait
// - *margin* : Document margin / Marges du document
// - *space_title* : Space between the header and the title / Espace entre l'en-tête et le titre
// - *header_numbering* : Title format / Format des titres (exemples : "1.1.", "I)", "a.", "A)")
// - *num_page* : Page numbering / Affichage des numéros de page (none ou "1")
// - *nb_columns* : Column number / Nombre de colonnes pour le document
// - *column_space* : Column spacing / Espace entre les colonnes
// - *lang* : Document language / Langue du fichier (exemples : "en" ou "fr")
// - *font* : Document font / La police de votre document
// - *font_code* : Code bloc font / La police des blocs de code
// - *font_size* : Font size / Taille de la police dans le document
// - *spacing* : Spacing between lines / Espacement entre les lignes
// - *include_title_in_zone* : Boolean to include the title in its own zone / Booléen pour inclure le titre dans une zone à part
// - *show_table_of_content* : Boolean to show the table of content / Booléen pour afficher ou non le sommaire
// - *show_bib* : Boolean to show the biliography / Booléen pour afficher ou non la bibliographie
// - *show_header* : Boolean to show the document header / Booléen pour afficher ou non le bandeau d'en-tête
// - *bib_file* : The name of the .bib file / Nom du fichier .bib
// - *theme* : Catppuccin Flavor selected and the colors / Palette de couleur choisie pour Catppuccin
// 
#let template(
  title: none,
  school: none,
  page_paper: "a4",
  landscape: false,
  margin: (top: 1.5cm, bottom: 1.5cm, right: 1.5cm, left: 1.5cm),
  space_title: 10%,
  header_numbering: none,
  num_page: none,                   
  nb_columns: 1,
  column_space: 20pt,
  lang: "fr",
  font: "Nunito",
  font_code: "Cascadia Code",
  font_size: 10pt,
  spacing: 10pt,
  include_title_in_zone: true,
  show_table_of_content: false,
  show_bib: false,
  show_header: true,
  bib_file: "Bibliographie.bib",
  theme: (flavor: "latte", text_color: black, fill_color: none, page_color: none),
  doc,
) = {


  if theme.flavor == "latte" {
    theme.text_color = get_color(flavor: theme.flavor, color: "black")
    theme.fill_color = get_color(flavor: theme.flavor, color: "base")
    theme.page_color = get_color(flavor: theme.flavor, color: "white")
  }

  if theme.flavor == "mocha" {
    theme.text_color = get_color(flavor: theme.flavor, color: "text")
    theme.fill_color = get_color(flavor: theme.flavor, color: "base")
    theme.page_color = get_color(flavor: theme.flavor, color: "base")
  }



  show: catppuccin.with(theme.flavor)
  
  // 
  // Page/text and paragraph configuration
  // Configuration pour la page, du texte et des paragraphes
  // 
  
  set document(title: title)

  set page(
    paper: page_paper,                 
    margin: margin, 
    columns: nb_columns,
    flipped: landscape,
    numbering: num_page,  
    header: if show_header {text(8pt, school) } + h(1fr) + text(8pt, title),
    fill: theme.page_color
  ) 

  set text(
    font: font, 
    size: font_size,  
    lang: lang,
    fill: theme.text_color,
  )

  set par(
    justify: true,                      // alignement du texte
    spacing: spacing,
    leading: spacing,
  )

  set columns(gutter: column_space)


  set heading(numbering: header_numbering)
  show heading: set text(get_color(flavor: theme.flavor, color: "lavender"))
//  show bibliography: set heading(numbering: "1.")     // Pour afficher la numérotation avec la bibliographie
  show heading: set block(above: 1.5em, below: 1.5em)

  // 
  // Code block configuration / Configuration pour les blocs de code
  // 

  //#set raw(theme: "latte.tmTheme")
  
  show raw: set text(font: font_code)
  show raw.where(block: true): set text(1em, fill: theme.text_color)
  //show raw.where(block: false): it => highlight(it, fill: colors.base.rgb, radius: 1pt)
  show raw.where(block: false): it => highlight(fill: get_color(flavor: theme.flavor, color: "mantle"), extent: 1pt, radius: 1pt)[#text(it, fill: theme.text_color)]
  show raw.where(block: true): block.with(
    width: 100%,
    fill: get_color(flavor: theme.flavor, color: "mantle"),
    inset: 8pt,
    radius: 3pt
  )

  // 
  // Quote configuration / Configuration pour les citations
  // 

  set quote(block: true)
  show quote: set text(style: "italic")

  //
  //  Link configuration / Configuration des liens
  // 

  show link: set text(style: "italic", get_color(flavor: theme.flavor, color: "lavender"))
  show link: it => {
  	it + " " + fa-icon("arrow-up-right-from-square", size: 7pt)
  }
  //
  // Table configuration / Configuration des tableaux
  // 
  
  show table.cell.where(y: 0): strong

  //
  // Configuration des balises de math
  // 
  
  //show math.equation: set text(font: "Nunito")

  //
  // Listings alignment with blocks / Pour les listings alignés correctement avec les blocs
  // 
  show: el.default-enum-list


  if include_title_in_zone {
    place(
      top + left,
      float: true,
      scope: "parent",
      clearance: 2em,
      {

        if show_table_of_content {
          v(space_title)
          text(title, weight: "bold", size: 18pt)
        }
        else {
          v(space_title)
          text(title, weight: "bold", size: 18pt)
          v(2%)
        }
        
      }
    )
  } else {

    if show_table_of_content {
      v(space_title)
      text(title, weight: "bold", size: 18pt)
    }
    else {
      v(space_title)
      text(title, weight: "bold", size: 18pt)
      v(2%)
    }

  }
  
  
  if show_table_of_content [
    #v(3%)
    #outline()
    #v(2%)
  ]

  doc


  if show_bib {
    bibliography(
      bib_file
    )
  }
  
}
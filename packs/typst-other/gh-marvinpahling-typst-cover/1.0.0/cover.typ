#let _bundled-logos = (
  "mtu": "logos/mtu.svg",
  "ostfalia": "logos/ostfalia.svg",
)

/// Generates a standardized cover page.
///
/// - title (str): The main title of the document.
/// - logo (str): The logo to use. Can be a custom file path or a bundled preset.
///   Available presets: `"mtu"`, `"ostfalia"`.
/// - display-logo (bool): Whether to render the logo on the page.
#let cover(
  title: "",
  subtitle: "",
  course: "",
  authors: ((name: "", id: ""),),
  author-label: "Author:",
  id-label: "Id:",
  date-label: "Date:",
  institution: "",
  department: "",
  logo: "",
  display-logo: true,
) = {
  let logo-path = if logo in _bundled-logos {
    _bundled-logos.at(logo)
  } else {
    logo
  }

  align(center)[
    #v(1cm)
    #text(size: 24pt, weight: "bold")[
      #title
    ]
    #v(0.5cm)
    #text(size: 18pt)[
      #subtitle
    ]
    #v(1cm)
    #text(size: 14pt)[
      Module: #course
    ]


    #v(1fr)

    #if display-logo and logo-path != "" {
      image(logo-path, width: 10cm)
      v(1fr)
    } else {
      v(2fr)
    }


    #text(size: 12pt)[
      #for author in authors [
        *#author-label* #author.name \
        *#id-label* #author.id \
        #v(0.5cm)
      ]
      *#date-label* #datetime.today().display("[month repr:long] [day], [year]")
    ]
    #v(1fr)

    #v(1fr)
    #text(size: 11pt)[
      #institution \
      #department
    ]
  ]
  pagebreak()
}


/// Generates a standardized cover page from yaml specifications
#let load_from_yaml(path: "") = {
  let data = yaml(path)

  let authors = {
    let result = ()
    let texts = data.authors
    for (key, value) in data.authors {
      result.push((name: value.name, id: value.id))
    }
    result
  }

  cover(
    title: data.title,
    subtitle: data.subtitle,
    course: data.course,
    authors: authors,
    author-label: data.author-labels.name,
    id-label: data.author-labels.id,
    date-label: data.date-label,
    institution: data.institution,
    department: data.department,
    logo: data.logo.path,
    display-logo: data.logo.display,
  )
}

#load_from_yaml(path: "./example-config.yaml")

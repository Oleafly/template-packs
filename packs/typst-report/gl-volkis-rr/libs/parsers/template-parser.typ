#import "/libs/project-values.typ": chosen_template, title, version_history, contributors, company, longcompany, client, longclient, draft, vulnfolder
#import "/libs/rr.typ": get_files_in_folder, get_file, get_from_rr_metadata, get_folders_in_root_folder, capitalize
#import chosen_template as template_module
#import "template-defaults.typ" as defaults

#let config = dictionary(template_module)

#let get_value_or_panic_if_undefined(variable) = {
  let value = config.at(variable, default: none)

  if value == none {
    panic(variable + " must be defined as a key in template config")
  }

  return value
}

// Numbering
#let normal_numbering = config.at("normal_numbering", default: none)
#let vuln_numbering = config.at("vuln_numbering", default: none)

#let format_link = config.at("format_link", default: (x) => (x))

// Required variables
#let conf = get_value_or_panic_if_undefined("conf")
#let titlepage = get_value_or_panic_if_undefined("titlepage")

// Outline
#let outline = config.at("rr_outline", default: defaults.outline)
#let risk_in_outline = config.at("risk_in_outline", default: false)

// Priorities for security review type reports
#let priorities = config.at("priorities", default: defaults.priorities)

// Vulnerability risks
#let likelihoods = config.at("likelihoods", default: defaults.likelihoods)
#let impacts = config.at("impacts", default: defaults.impacts)
#let risks = config.at("risks", default: defaults.risks)
#let risk_matrix = config.at("risk_matrix", default: defaults.risk_matrix)
#let vulnerability_titles = config.at("vulnerability_titles", default: defaults.vulnerability_titles)

#let risk_calculate(likelihood: "", impact: "") = {
    let r_impact = capitalize(impact)
    let r_likelihood = capitalize(likelihood)
    return risk_matrix.at(r_likelihood).at(r_impact);
}

// Do a test to make sure the risk_matrix at least makes sense
#{
  let found_risks = ()

  for likelihood in likelihoods {
    let result = risk_matrix.at(likelihood, default: none)
    if result == none {
        risk_matrix_errors = true
    } else {
      for impact in impacts {
        let result = result.at(impact, default: none)

        if result == none {
          risk_matrix_errors = true
        } else {
          found_risks.push(result)
        }
      }
    }
  }

  if found_risks.dedup().len() != risks.len() {
    panic("risk_matrix in the template is malformed, this can happen if you edit risk_matrix but not risks, likelihoods and impacts, or if certain risks are not reachable")
  }
}

#let risk_format = get_value_or_panic_if_undefined("risk_format")

#let risk_formatting(risk, risk_format: risk_format) = {
  let risk_fmt = risk_format.at(lower(risk))

  return (
      "fg": risk_fmt.at("fg", default: rgb("#000000")),
      "bg": risk_fmt.at("bg", default: rgb("#FFFFFF")),
      "bold": risk_fmt.at("bold", default: true),
  )
}

#let risk_cell(risk, content: none) = {
    let f = risk_formatting(risk)

    let cell_body = risk

    if content != none {
      cell_body = content
    }

    table.cell(fill: f.bg,
      if f.bold {
        strong(text(fill: f.fg, cell_body))
      } else {
        text(fill: f.fg, cell_body)
      }
    )
}

#let priority_cell(priority) = {
    let priority_format = get_value_or_panic_if_undefined("priority_format")
    let f = risk_formatting(priority, risk_format: priority_format)

    if f.bold {
        table.cell(fill: f.bg, strong(text(fill: f.fg, priority)))
    } else {
        table.cell(fill: f.bg, text(fill: f.fg, priority))
    }
}

#let color_palette = get_value_or_panic_if_undefined("color_palette")

#let new_section = config.at("new_section", default: pagebreak(weak: true))
#let last_page = config.at("last_page", default: [])

// Legacy help
#let section_break = last_page

#let tb_format = config.at("table_format", default: (
  (
    bg: white,
    stroke: black + 1pt,
    heading: (
      fg: white,
      bg: black,
      bold: true
    )
  )
))

// If font and size exist, populate text_options with it, otherwise populate it with defaults
#let text_options = (
  font: "Source Sans Pro",
  size: 11pt,
  // If font or size is defined in text_options, this will get overwritten
  ..config.at("text_options",  default: (:))
)

#let vuln_section_sorting = config.at("vuln_section_sorting", default: sections => {
  let sections = (:)

  for vuln_section in get_folders_in_root_folder(vulnfolder) {
    let file_names = get_files_in_folder(vulnfolder + "/" + vuln_section).filter((x) => not x.ends-with("introduction.typ"))

    let rr_metadata = file_names.map(x => get_file(x).rr_metadata)

    let risk_idx = rr_metadata.map(x => {
      let impact = capitalize(get_from_rr_metadata(x, "impact"))
      let likelihood = capitalize(get_from_rr_metadata(x,  "likelihood"))
      if not impacts.contains(impact) { 
        panic("'" + x.filename + "' has an invalid Impact value.")
      } else if not likelihoods.contains(likelihood) {
        panic("'" + x.filename + "' has an invalid Likelihood value.")
      } else {
        risk_calculate(likelihood: likelihood, impact: impact)
      }
    }).fold(0, (acc, risk) => {
      let risk_idx = risks.position(x => x == risk)

      if risk_idx > acc {
        return risk_idx
      } else {
        acc
      }
    })

    // get_vuln_section_weight
    // let x = sections.at(str(section_weight))


    // We need to construct a dict that should look like
    // sections = (
    //  "section_weight": (
    //    risk_idx: (section, section) 
    //  ),
    //  "section_weight": (
    //    risk_idx: (section, section) 
    //    risk_idx: (section) 
    //  )
    //)

    // And it should return just (section, section, section, section), but sorted appropriately

    // Currently, since we don't have a section_weight, we just display the section with the highest risk_idx first.

    // If there are two that are the same, show them alphabetically sorted

    let x = sections.at(str(risk_idx), default: ())
    x.push(vuln_section)
    sections.insert(str(risk_idx), x)
  }

  return sections.keys().map(x => int(x)).sorted().rev().map(idx => {
    sections.at(str(idx)).sorted()
  }).flatten()
})

// Parse table_format and fill in default values.
#let table_format = {
  let heading = tb_format.at("heading", default: (:))
  (
    bg: tb_format.at("bg", default: white),
    stroke: tb_format.at("stroke", default: black + 1pt),
    heading: (
      fg: heading.at("fg", default: white),
      bg: heading.at("bg", default: black),
      bold: heading.at("bold", default: true)
    )
  )
}

#let heading_style(..args) = {
  let heading_format = table_format.at("heading")

  args.pos().map(element => {
    if heading_format.at("bold") {
      strong(text(fill: heading_format.at("fg"), element))
    } else {
      text(fill: heading_format.at("fg"), element)
    }
  })
}

#let table_fill_function(row) = {
  if row == 0 {
    return table_format.at("heading").at("bg")
  } 
  
  let background = table_format.at("bg")

  if type(background) == function {
    return background(row)
  } 

  return background;
}

#let initialise_document(doc) = {
    show: doc => conf(
    title: title,
    company: company,
    client: {
        if longclient != none {
            longclient
        } else {
            client
        }
    },
    version_history: version_history,
    contributors: contributors,
    doc)

    set table(
        fill: (_, row) => table_fill_function(row),
        stroke: table_format.at("stroke")
    )

    show table.cell.where(y: 0): x => text(fill: table_format.heading.fg, {
        if table_format.heading.bold {
            strong(x)
        } else {
            x
        }
    })

    set text(
      ..text_options
    )

    set page(foreground: place(horizon + center, rotate(-45deg, text(fill: rgb(0, 0, 0, 40), size: 125pt, "DRAFT")))) if draft

    doc
}

#import "/libs/rr.typ": get
#import "/libs/project-values.typ": chosen_template, company
#import "/libs/rr-metadata.typ": config
#import chosen_template as template_module

#let template = dictionary(template_module)

#let input_structure_file = {
    let structure_file = template.at("structure_file", default: none)

    if structure_file != none {
      let explicit_template = get(config, "template")

      if explicit_template == none {
          structure_file = "/templates/" + lower(company) + "/" + structure_file
      } else {
          structure_file = "/templates/" + explicit_template + "/" + structure_file
      }
    }

    structure_file
}

#import "/libs/parsers/rr-structure.typ" as default

#let input = {
  if input_structure_file != none {
    import input_structure_file as input
    dictionary(input)
  } else {
    (:)
  }
}

#let structure = (
    : // Tell Typst this is a dict ;)
    ..dictionary(default),
    ..input // overwrite any defaults with the stuff from our user file
)


#let vulnerability_tables_wrapper(..args) = {
  (structure.vulnerability_tables)(..args, fields_function: structure.vulnerability_table_fields)
}

#let vulnerability_sections_wrapper(..args) = {
  (structure.vulnerability_sections)(..args, fields_function: structure.vulnerability_fields)
}

#let structure = (
  ..structure,
  vulnerability_tables: vulnerability_tables_wrapper,
  vulnerability_sections: vulnerability_sections_wrapper,
)

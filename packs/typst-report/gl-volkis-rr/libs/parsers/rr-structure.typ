#import "/libs/rr.typ": *
#import "/libs/project-values.typ": *
#import "template-parser.typ": risk_calculate, risks, risk_cell, priorities, priority_cell, table_format, vuln_section_sorting, vulnerability_titles, risk_format, risk_in_outline

#let vulnerability_table_fields(all_files_metadata, counter: 0) = {
    let details = all_files_metadata
        .map(x => (get_from_rr_metadata(x, "title"), risk_calculate(likelihood: get_from_rr_metadata(x, "likelihood"), impact: get_from_rr_metadata(x, "impact"))))
        .sorted(key: (x) => risks.position((y) => y == x.at(1)))
        .rev()
        .map(x => (x.at(0), risk_cell(x.at(1))))

    let details = range(counter, details.len() + counter).map(x => {strong(str(x))}).zip(details).flatten()

    return (
        columns: (1cm, 3fr, 1fr),
        align: (x, _) => (horizon + center, horizon + left, horizon + center).at(x),
        data: (
            (table.header([], [Title], [Risk])),
            ..details,
        )
    )
}

#let vulnerability_tables(vuln_section_order: none, fields_function: none, summaries: ()) = {
    let vuln_counter = counter("vuln_num_tables")

    let start = 1

    let vuln_sections = if vuln_section_order == none {
        vuln_section_sorting(get_folders_in_root_folder(vulnfolder))
    } else {
        resolve_section_order(vuln_section_order, get_folders_in_root_folder(vulnfolder))
    }

    for vuln_section in vuln_sections {
        let file_names = get_files_in_folder(vulnfolder + "/" + vuln_section).filter((x) => not x.ends-with("introduction.typ"))

        if file_names.len() == 0 {
            continue;
        }

        let rr_metadata = file_names.map(x => get_file(x).rr_metadata)

        let fields = fields_function(rr_metadata, counter: start)

        start += file_names.len()

        // If there's only one vulnerability section, there's no need to print the section name.
        // Instead just print "List of vulnerabilities"
        if vuln_sections.len() == 1 {
            heading(level: 3, "List of vulnerabilities", outlined: false)
        } else {
            heading(level: 3, strong(capitalize(vuln_section)), outlined: false)
        }

        // If there's a summary, print it under the heading prior to the list of vulnerabilities
        if (vuln_section in summaries) {
            block(sticky: true, summaries.at(vuln_section))
        }

        // Print the table containing the list of vulnerabilities
        table(
            columns: fields.columns,
            inset: 0.65em,
            align: fields.at("align", default: left),
            ..fields.data.flatten(),
        )
    }
}

#let vulnerability_fields(contents) = {
    let likelihood = capitalize(get_from_rr_metadata(contents.rr_metadata, "likelihood"))
    let impact = capitalize(get_from_rr_metadata(contents.rr_metadata, "impact"))
    let risk = risk_calculate(likelihood: likelihood, impact: impact)

    return (
        columns: (1fr, 1fr, 1fr),
        align: center + horizon,
        data: (
            (table.header([Likelihood], [Impact], [Risk])),
            ((likelihood, impact, risk_cell(risk)))
        )
    )
}

#let vulnerability_sections(vuln_section_order: none, fields_function: none) = {
    //Start counter at 1
    let vuln_counter = counter("vuln_num")
    vuln_counter.update(1)

    let vuln_sections = if vuln_section_order == none {
        vuln_section_sorting(get_folders_in_root_folder(vulnfolder))
    } else {
        resolve_section_order(vuln_section_order, get_folders_in_root_folder(vulnfolder))
    }

    for vuln_section in vuln_sections {
        if vuln_sections.len() == 1 {
            heading("Detailed " + vulnerability_titles.plural, level: 1)
        } else {
            heading("Detailed " + vulnerability_titles.plural + ": " + capitalize(vuln_section), level: 1)
        }

        let file_names = get_files_in_folder(vulnfolder + "/" + vuln_section)

        let introduction_fn = file_names.find((x) => x.ends-with("/introduction.typ"))

        if not introduction_fn == none {
            let introduction_contents = get_file(introduction_fn)

            introduction_contents.content
        }

        let file_names = file_names.filter((x) => not x.ends-with("/introduction.typ"))

        let rr_metadata = file_names.zip(file_names.map(x => get_file(x).rr_metadata))

        let sorted_file_names = rr_metadata
            .map(x => {
                let file_meta = x.at(1)

                (x.at(0), risk_calculate(likelihood: get_from_rr_metadata(file_meta, "likelihood"), impact: get_from_rr_metadata(file_meta, "impact")))
            })
            .sorted(key: (x) => risks.position((y) => y == x.at(1)))
            .rev()
            .map(x => x.at(0))

        let current_labels = ()

        for vulnerability_fn in sorted_file_names {
            let contents = get_file(vulnerability_fn)
            let fields = fields_function(contents)

            // Make a custom label to reference later
            let custom_label = lower(vuln_section).replace(" ", "_") + "." + {
              lower(vulnerability_fn.match(regex("^.*/([^/]+?)(?:\\s*\\(.*\\))?\\.typ$")).captures.at(0).replace(" ", "_"))
            }

            let vuln_heading = [#heading(get_from_rr_metadata(contents.rr_metadata, "title"), supplement: vulnerability_titles.singular, level: 2, numbering: (..a) => vulnerability_titles.singular + " " + vuln_counter.display() + ":", outlined: false, bookmarked: false)]

            if not current_labels.contains(custom_label) {
              [#heading(get_from_rr_metadata(contents.rr_metadata, "title"), supplement: vulnerability_titles.singular, level: 2, numbering: (..a) => vulnerability_titles.singular + " " + vuln_counter.display() + ":", outlined: not risk_in_outline) 
                #label(custom_label)]

                current_labels.push(custom_label)
            } else {
              heading(get_from_rr_metadata(contents.rr_metadata, "title"), supplement: vulnerability_titles.singular, level: 2, numbering: (..a) => vulnerability_titles.singular + " " + vuln_counter.display() + ":", outlined: not risk_in_outline) 
            }

            // Show the risk bubbles
            if risk_in_outline {
                let risk = risk_calculate(likelihood: get_from_rr_metadata(contents.rr_metadata, "likelihood"), impact: get_from_rr_metadata(contents.rr_metadata, "impact"))

                let risk_bubble = box(
                  fill: risk_format.at(lower(risk)).bg, 
                  radius: 5pt, 
                  inset: 2pt, 
                  outset: 3pt, 
                  width: 50pt,
                  text(
                    fill: risk_format.at(lower(risk)).at("fg", default: luma(0)),
                    align(center, 
                      strong(risk)
                    )
                  )
                )

                [
                  #show heading: none
                  #heading(
                    box(grid(
                      align: left + horizon, 
                      columns: 2, 
                      risk_bubble, h(10pt) + get_from_rr_metadata(contents.rr_metadata, "title"),
                    )),
                    supplement: vulnerability_titles.singular, 
                    level: 2, 
                    numbering: (..a) => vulnerability_titles.singular + " " + vuln_counter.display() + ":")
                ]
            }

            vuln_counter.step()

            table(
                columns: fields.columns,
                inset: 0.6em,
                align: fields.at("align", default: left),
                ..fields.data.flatten()
            )

            contents.content

            // Only page break between vulnerabilities if this is not the last
            // vulnerability

            pagebreak(weak: true)
        }

    }
}

#let security_review_tables(security_review_folder: "security_review_findings") =  {

    let folders = get_folders_in_root_folder(security_review_folder)

    for folder in folders {
        let fns = get_files_in_folder(security_review_folder + "/" + folder).filter((x) => not x.ends-with("introduction.typ"))

        if fns.len() == 0 {
            continue;
        }

        let rr_metadata = fns.map(x => get_file(x).rr_metadata)

        let findings = rr_metadata
            .map(x => {
                return (get_from_rr_metadata(x, "title"), get_from_rr_metadata(x, "priority"))
            })
            .sorted(key: (x) => priorities.position((y) => y == x.at(1)))
            .rev()
            .enumerate()
            .map(z => {
                let (idx, values) = z
                (str(idx + 1), values.at(0), priority_cell(values.at(1)))
            })
            .flatten()

        strong(capitalize(folder) + " Security Review")

        table(
            columns: (auto, 4fr, 1fr),
            align: (col, row) => (center, left, center).at(col),
            table.header([], [Failed Security Control], [Priority]),
            ..findings
        )
    }
}

#let security_review_sections(security_review_folder: "security_review_findings") = {
    let folders = get_folders_in_root_folder(security_review_folder)

    for folder in folders {
        heading(folder + " Security Review", level: 1)

        let fns = get_files_in_folder(security_review_folder + "/" + folder)

        let introduction_fn = fns.find((x) => x.ends-with("/introduction.typ"))

        if not introduction_fn == none {
            let introduction_contents = get_file(introduction_fn)

            introduction_contents.content
        }

        let fns = fns.filter((x) => not x.ends-with("/introduction.typ"))

        let fns_and_rr_metadata = fns.zip(fns.map(x => get_file(x).rr_metadata))

        let sorted_fns = fns_and_rr_metadata
            .map(x => {
                let file_meta = x.at(1)

                (x.at(0), get_from_rr_metadata(file_meta, "priority"))
            })
            .sorted(key: (x) => priorities.position((y) => y == x.at(1)))
            .rev()
            .map(x => x.at(0))

        // We need to sort our fns here too:

        for fn in sorted_fns {
            let file = get_file(fn)

            heading(get_from_rr_metadata(file.rr_metadata, "title"), level: 2)

            [Priority: #get_from_rr_metadata(file.rr_metadata, "priority")]

            file.content

            pagebreak(weak: true)
        }
    }
}

#let appendices(allowlist: none, blocklist: none) = {
    if allowlist != none and blocklist != none {
        panic("Can't have an allowlist and a blocklist for appendices()")
    }

    let all_files = get_files_in_folder("appendices")

    if allowlist != none {
        if allowlist.any((x) => not (type(x) == str or type(x) == regex)) {
            panic("Allowlist contains non-regex or string entries.")
        }
    }

    if blocklist != none {
        if blocklist.any((x) => not (type(x) == str or type(x) == regex)) {
            panic("Allowlist contains non-regex or string entries.")
        }
    }

    let appendices_fns = {
        if allowlist != none {
            for item in allowlist {
                let found = all_files.any((fn) => if type(item) == str { fn.ends-with(item) } else if type(item) == regex { fn.find(item) != none })
                if not found {
                    panic("Allow-list string/rule '" + item + "' is missing from the appendices folder.")
                }
            }

            all_files.filter((fn) => allowlist.any((rule) => {
                if type(rule) == str { 
                    fn.ends-with(rule) 
                } else if type(rule) == regex { 
                    fn.find(rule) != none 
                }
            }))
        } else if blocklist != none {
            all_files.filter((fn) => not blocklist.any((rule) => {
                if type(rule) == str { 
                    fn.ends-with(rule) 
                } else if type(rule) == regex { 
                    fn.find(rule) != none
                }
            }))
        } else {
            all_files
        }
    }

    if appendices_fns.len() == 0 {
        return
    }

    heading([Appendices], level: 1, numbering: none)

    counter(heading).update(())

    let appendices = appendices_fns
        .map((fn) => (fn, get_file(fn)))
        .sorted(key: (x) => {
            if x.at(1).rr_metadata.keys().contains("weight") {
                x.at(1).rr_metadata.weight
            } else {
                return 0
            }
        })

    let current_labels = ()

    for (fn, appendix) in appendices {
        let custom_label = "appendix." + {
            lower(fn.match(regex("^.*/([^/]+?)(?:\\s*\\(.*\\))?\\.typ$")).captures.at(0).replace(" ", "_"))
        }

        if not current_labels.contains(custom_label) {
            [#heading(get_from_rr_metadata(appendix.rr_metadata, "title"), supplement: "Appendix", level: 2, numbering: (x, ..y) => "Appendix " + numbering("A", ..y) + ":")
             #label(custom_label)]

            current_labels.push(custom_label)
        } else {
            heading(get_from_rr_metadata(appendix.rr_metadata, "title"), supplement: "Appendix", level: 2, numbering: (x, ..y) => "Appendix " + numbering("A", ..y) + ":")
        }

        appendix.content

        // Add a pagebreak in-between appendices (but not at the end of the document)
        pagebreak(weak: true)
    }
}

#let overview_section(title: none, folder: none) = {
    if title == none {
        title = folder.split("_").map((x) => capitalize(x)).join(" ")
    }

    let fns = get_files_in_folder(folder)

    let introduction_fn = fns.find((x) => x.ends-with("/introduction.typ"))

    let fns = fns.filter((x) => not x.ends-with("/introduction.typ"))

    if fns.len() > 0 {
        heading(title, level: 2)
        v(0.2em)

        if not introduction_fn == none {
            get_file(introduction_fn).content
        }

        for fn in fns {
            let contents = get_file(fn)

            v(0.2em)
            heading(get_from_rr_metadata(contents.rr_metadata, "title"), level: 3)
            v(0.2em)

            contents.content
        }
    }
}

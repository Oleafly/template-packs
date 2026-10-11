#import "rr.typ": get_rr_metadata, get_folders_in_root_folder, get_from_rr_metadata
#import "rr-metadata.typ": rr_metadata
#import "project-values.typ": *
#import "parsers/template-parser.typ": risk_calculate, risks

#let get_vuln_sections() = {
    if vulnfolder == none {
        return ()
    } else {
        return get_folders_in_root_folder(vulnfolder)
    }
}

#let get_files_in_vuln_section(vuln_section) = {
    let key = rr_metadata.file_tree.keys().filter(x => x.ends-with("/" + vuln_section)).first()

    return rr_metadata.file_tree.at(key).map(at => key + "/" + at);
}

#let vuln_sections_rr_metadata = get_vuln_sections().map((x) => {
    get_files_in_vuln_section(x).filter((z) => not z.ends-with("/introduction.typ")).map((y) => {
        get_rr_metadata(y)
    })
}).flatten()

#let risks_per_section = get_vuln_sections().map((x) => {
    (x, get_files_in_vuln_section(x))
}).fold((:), (x, y) => {
    x.insert(y.at(0), y.at(1).len())
    x
})

#let total_risks = {
    let values = risks_per_section.values()

    if values.len() > 0 {
        values.sum()
    } else {
        0
    }
}

#let all_risks = vuln_sections_rr_metadata.map((x) => {
    (
        get_from_rr_metadata(x, "title"), 
        risk_calculate(
            likelihood: get_from_rr_metadata(x, "likelihood"),
            impact: get_from_rr_metadata(x, "impact")
        )
    )
})

#let risk_breakdown = {
    let risk_dict = risks
        .fold((:), (x, y) => {
            x.insert(y, 0)
            x
        })

    all_risks
        .map((x) => x.at(1))
        .fold(risk_dict, (x, y) => {
            x.at(y) = x.at(y) + 1
            x
        })
}

#let highestrisk = {
    let valid_risks = risk_breakdown
        .pairs() // Get the pairs
        .filter((x) => { x.at(1) != 0 }) // If a risk count was 0, we don't care

    if valid_risks.len() == 0 {
        "NO RISK, PLEASE REMOVE"
    } else {
        valid_risks
            .map((x) => {x.at(0)}) // Get just the risk level
            .sorted(key: (x) => risks.position((y) => y == x)) // Sort by the risk ordering in the template
            .rev() // Reverse cause sorting is always ascending
            .first() // Grab the first elem (which will be the highest risk)
    }
}

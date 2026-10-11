#import "rr.typ": get
#import "rr-metadata.typ": *

#let title = get(config, "title")
#let company = get(config, "company")
#let longcompany = get(config, "longcompany")
#let client = get(config, "client")
#let longclient = get(config, "longclient")

#let draft = config.at("draft", default: false)

#let version_history = {
    let vh = get(config, "version_history")

    if vh != none {
        vh.map(history => {
            let (year, month, day) = (..history.remove("date").split("-").map((x) => int(x)))

            history.insert("date", datetime(year:year, month:month, day:day))

            history
        })
    } else {
        vh
    }
}

#let contributors = get(config, "contributors")

#let vulnfolder = config.at(
        "vuln_config", 
        default: config.at(
            "vulnerabilities_folder", 
            default: none
    )
)

#let section_order = config.at("section_order", default: none)


#let chosen_template = {
    let explicit_template = get(config, "template")

    if explicit_template == none {
        "/templates/" + lower(company) + "/template.typ"
    } else {
        "/templates/" + explicit_template + "/template.typ"
    }
}
#import "/libs/rr.typ": *
//#import "/libs/project-values.typ": *
#import "/libs/parsers/template-parser.typ": risk_calculate, risk_cell

// Example of how you would, say, add OWASP into your reports

//#let vulnerability_fields(contents) = {
//    let likelihood = get_from_rr_metadata(contents.rr_metadata, "likelihood")
//    let impact = get_from_rr_metadata(contents.rr_metadata, "impact")
//    let risk = risk_calculate(likelihood: likelihood, impact: impact)
//    let owasp = get_from_rr_metadata(contents.rr_metadata, "owasp")
//
//    return (
//        columns: (1fr, 1fr, 1fr, 1fr),
//        align: center + horizon,
//        data: (
//            (table.header([Likelihood], [Impact], [Risk], [OWASP])),
//            ((likelihood, impact, risk_cell(risk), owasp))
//        )
//    )
//}

//#let vulnerability_table_fields(all_files_metadata, counter: 0) = {
//      let details = all_files_metadata
//        .map(x => (
//          get_from_rr_metadata(x, "title"), 
//          get_from_rr_metadata(x, "owasp"),
//          risk_calculate(likelihood: get_from_rr_metadata(x, "likelihood"), impact: get_from_rr_metadata(x, "impact")),
//          )
//        )
//        .sorted(key: (x) => risks.position((y) => y == x.at(1)))
//        .rev()
//        .map(x => (x.at(0), x.at(1), risk_cell(x.at(2))))
//
//    let details = range(counter, details.len() + counter).map(x => {strong(str(x))}).zip(details).flatten()
//
//    return (
//        columns: (1cm, 3fr, auto, 1fr),
//        align: (x, _) => (horizon + center, horizon + left, horizon + left, horizon + center).at(x),
//        data: (
//            (table.header([], [Title], [OWASP], [Risk])),
//            ..details,
//        )
//    )
//}
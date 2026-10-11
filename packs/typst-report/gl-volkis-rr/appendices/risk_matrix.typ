#import "/libs/diagbox.typ": *
#import "/constants.typ": template
#import template: color_palette, heading_style, risk_matrix, risk_calculate, impacts, likelihoods, risk_cell, table_format, table_fill_function

#let table_values = {
    for impact in impacts.rev() {
        (..heading_style(impact), ..likelihoods.map(likelihood => {
            let risk = risk_calculate(likelihood: likelihood, impact: impact)

            risk_cell(risk)
        }))
    }
}

///! title = "Risk assessment methodology"
///! weight = 1000

A qualitative risk assessment is performed on each vulnerability to determine the impact and likelihood of the vulnerability being exploited. An overall risk is calculated based on the table below:

#{
    set text(hyphenate: false)
    table(
    columns: (100pt,) + ((1fr,) * likelihoods.len()),
    rows: (auto,) + ((1cm,) * impacts.len()),
    fill: (col, row) => {
        if col == 0 or row == 0 {
            table_fill_function(0)
        } else {
            table_fill_function(row)
        }
    },
    stroke: table_format.at("stroke"),
    align: horizon + center,
    bdiagbox(line_stroke: table_format.at("stroke"), width: 100pt)[#heading_style([Impact]).at(0)][#heading_style([Likelihood]).at(0)],
    ..heading_style(..likelihoods),
    ..table_values
)}

The risk assessment methodology is derived from industry standards such as ISO
31000 #footnote[https://www.iso.org/iso-31000-risk-management.html] and OWASP Risk Rating Methodology #footnote[https://www.owasp.org/index.php/OWASP_Risk_Rating_Methodology].

The impact rating is deduced from multiple factors that consider both technical
impact and business impact:

- *Loss of confidentiality*: How much sensitive information could be accessed or leaked and how sensitive was it?

- *Loss of integrity*: How much data could be corrupted and what degree of corruption was possible? Was it possible to perform actions on behalf of others?

- *Loss of availability*: How much services could be disrupted, preventing users from performing their tasks? What was the degree of impairment?

- *Financial damage*: How much money could be lost as a result?

- *Reputational damage*: How badly would the company's reputation be damaged and how much trust could customers lose?

- *Non-compliance*: Would the business be in breach of certain compliance standards they are obliged to comply with? (E.g. Privacy Act)

The likelihood is deduced from considering who the adversary may be and factors around the vulnerability:

- *Skill of adversary*: How skilful is the attacker likely to be?

- *Motive*: What are the motivating factors that the adversary may have?

- *Resources*: How much time and economic resources does the adversary have?

- *Ease of discovery*: How likely is the adversary to discover the vulnerability?

- *Ease of exploitation*: How easy is the vulnerability to exploit and are there publicly available tools to aid in doing so?

- *Detection*: How likely is the attack to be discovered by the organisation?

An overall rating (from Low to Critical) is given to each vulnerability. The vulnerabilities
are then sorted in order from importance and urgency to remediate.


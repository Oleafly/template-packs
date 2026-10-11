#import "/constants.typ": title, client, longclient, company, version_history, contributors, template
#import template: color_palette, heading_style, table_fill_function

///! title = "Document Control"
///! weight = 1001

=== Document information

#let history = version_history.last()

#let get_version(version) = if calc.rem(version, 1) == 0 {str(version) + ".0" } else { str(version) }

#[
    #table(
        columns: (1fr, 2fr),
        fill: (col, row) => table_fill_function(col),
        inset: 6pt,
        ..heading_style([Client]), {
          context {
            strong(delta: -strong.delta, text(fill: black, if longclient != none { longclient } else { client }))
          }
        },
        ..heading_style([Document Name]), title,
        ..heading_style([Document Version]), get_version(history.version)
    )
]

=== Document changes

#let document_changes = version_history.map(details => {
    return (
        get_version(details.version),
        details.date.display("[year]-[month]-[day]"),
        details.contributor,
        details.notes,
    )
}).flatten()

#table(
    columns: (1.25fr, 2fr, 3fr, 4fr),
    inset: 6pt,
    ..heading_style([Version], [Date], [Name], [Changes]),
    ..document_changes,
)

=== Document contributors

#let document_contributors = contributors.map(details => {
    return (
        details.contributor,
        par(justify: false, details.title),
        details.ph,
        details.email,
    )
}).flatten()

#table(
    columns: (auto, auto, 0.85fr, 1.5fr),
    inset: 6pt,
    ..heading_style([Name], [Role], [Phone Number], [Email Address]),
    ..document_contributors,
)



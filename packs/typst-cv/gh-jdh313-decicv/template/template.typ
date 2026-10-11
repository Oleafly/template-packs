#import "../cv.typ": * // TODO: Update to Typst Universe package once published

#let cvdata = yaml("template.yml")

#let uservars = (
    headingfont: "Libertinus Serif",
    bodyfont: "Libertinus Serif",
    fontsize: 10pt,          // https://typst.app/docs/reference/layout/length
    linespacing: 6pt,        // length
    sectionspacing: 0pt,     // length
    showAddress:  false,     // was: true
    showNumber: true,        // bool
    showTitle: true,         // bool
    headingsmallcaps: true,  // was: false
    sendnote: false,         // bool. set to false to have sideways endnote
)

// setrules and showrules can be overridden by re-declaring it here
// #let setrules(doc) = {
//      // add custom document style rules here
//
//      doc
// }

#let customrules(doc) = {
    // add custom document style rules here
    set page(                 // https://typst.app/docs/reference/layout/page
        paper: "us-letter",
        numbering: none,       // was: "1 / 1"
        margin: 1.25cm,
    )

    // set list(indent: 1em)

    doc
}

#let cvinit(doc) = {
    doc = setrules(uservars, doc)
    doc = showrules(uservars, doc)
    doc = customrules(doc)

    doc
}

// each section body can be overridden by re-declaring it here
// #let cveducation = []
#let cvsummary(info, title: "Summary", isbreakable: true) = {
    if info.at("summary", default: none) != none {block[
        #info.summary
    ]} else {}
}

// ========================================================================== //

#show: doc => cvinit(doc)

#cvheading(cvdata, uservars)
#cvsummary(cvdata)
#cvwork(cvdata)
#cveducation(cvdata)
#cvaffiliations(cvdata)
#cvprojects(cvdata)
#cvawards(cvdata)
#cvcertificates(cvdata)
#cvpublications(cvdata)
#cvskills(cvdata)
#cvreferences(cvdata)
// #endnote(uservars)  // uncomment to show build timestamp footer

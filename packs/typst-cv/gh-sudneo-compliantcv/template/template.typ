#import "utils.typ"
#import "cv.typ"
// Load all the data
#let data = toml("/data/data.toml")

// Set some configuration values
#let uservars = (
    headingfont: data.typst.fontHeading,
    bodyfont: data.typst.fontBody,
    fontsize: 10pt,
    linespacing: 5pt,
    sectionspacing: 5pt,
    showAddress:  data.typst.showAddress,
    showNumber: data.typst.showNumber,
    showTitle: data.typst.showTitle,
    showProfiles: data.typst.showProfiles,
    showPortrait: data.typst.showPortrait,
    portraitPath: data.typst.portraitPath,
    showQR: data.typst.showQR,
    QRPath: data.typst.QRPath,
    headingsmallcaps: data.typst.headingSmallCaps,
    sendnote: data.typst.sendNote,
    accentColor: rgb(data.typst.color),
)

#let customrules(doc) = {
    // add custom document style rules here
    set page(                 // https://typst.app/docs/reference/layout/page
        paper: "a4",
        numbering: "1 / 1",
        number-align: center,
        margin: (left:1.25cm, right: 1.25cm)
    )
    // Colored banner
    place(
      dx: -1.25cm,
      dy: -2.5cm,
      rect(
        width: 21cm,
        height: 4.5cm,  // Adjust height as needed
        fill: uservars.accentColor,
        stroke: none,
      ),
  )

    doc
}

#let cvinit(doc) = {
    doc = cv.setrules(uservars, doc)
    doc = cv.showrules(uservars, doc)
    doc = customrules(doc)

    doc
}

#show: doc => cvinit(doc)

#cv.cvheading(data, uservars)
// Reorder sections if you wish
#cv.cvwork(data)
#cv.cvcertificates(data)
#cv.cveducation(data)
#cv.cvskills(data)
#cv.cvprojects(data)
#cv.cvpublications(data)
#cv.endnote(uservars)

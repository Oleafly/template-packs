#import "title-page.typ": title-page

#let basic-document(
  logo: image,
  document-kind: "Wirtschaftsprojekt",
  title: "",
  students: (),
  year: "",
  institution: "",
  study-program: "",
  supervisor: "",
  expert: "",
  client: "",
  public: false,
  secret: false,
  scanned-signature-page: none,
  acknowledgements: none,
  abstract,
  doc,
  bib: "",
  abbr: "",
  imgol: "",
  tabol: "",
  ai: "",
) = {
  set page(numbering: none)
  set heading(outlined: false)
  title-page(
    logo: logo,
    document-kind: document-kind,
    title: title,
    students: students,
    year: year,
    institution: institution,
    study-program: study-program,
    supervisor: supervisor,
    expert: expert,
    client: client,
    public: public,
    secret: secret,
    scanned-signature-page: scanned-signature-page,
    acknowledgements: acknowledgements,
  )
  counter(page).update(1)


  set page(
    footer: context [
      #align(
        right + horizon,
        counter(page).display(
          "1 von 1",
          both: true,
        ),
      )

    ],
  )
  abstract
  pagebreak()
  outline(title: "Inhaltsverzeichnis", depth: 3)

  set heading(numbering: "1.1.1", outlined: true)
  show heading: it => {
    if (it.level >= 4) {
      block(it.body)
    } else {
      block(counter(heading).display() + " " + it.body)
    }
  }

  doc

  if (abbr != "" or bib != "" or imgol != "" or tabol != "" or ai != "") {
    set heading(numbering: "A.1", outlined: true)
    show heading: it => {
      block(it.body)
    }
    if abbr != "" {
      pagebreak()
      abbr
    }
    if bib != "" {
      pagebreak()
      bib
    }
    if imgol != "" {
      pagebreak()
      imgol
    }
    if tabol != "" {
      pagebreak()
      tabol
    }
    if ai != "" {
      pagebreak()
      ai
    }
  }
}

#let basic-wipro(
  logo: image,
  title: "",
  students: (),
  year: "",
  institution: "",
  study-program: "",
  supervisor: "",
  expert: "",
  client: "",
  public: false,
  secret: false,
  scanned-signature-page: none,
  abstract,
  doc,
  bib: "",
  abbr: "",
  imgol: "",
  tabol: "",
  ai: "",
) = basic-document(
  logo: logo,
  document-kind: "Wirtschaftsprojekt",
  title: title,
  students: students,
  year: year,
  institution: institution,
  study-program: study-program,
  supervisor: supervisor,
  expert: expert,
  client: client,
  public: public,
  secret: secret,
  scanned-signature-page: scanned-signature-page,
  abstract,
  doc,
  bib: bib,
  abbr: abbr,
  imgol: imgol,
  tabol: tabol,
  ai: ai,
)

#let basic-bachelor(
  logo: image,
  title: "",
  students: (),
  year: "",
  institution: "",
  study-program: "",
  supervisor: "",
  expert: "",
  client: "",
  public: false,
  secret: false,
  scanned-signature-page: none,
  acknowledgements: none,
  abstract,
  doc,
  bib: "",
  abbr: "",
  imgol: "",
  tabol: "",
  ai: "",
) = basic-document(
  logo: logo,
  document-kind: "Bachelorarbeit",
  title: title,
  students: students,
  year: year,
  institution: institution,
  study-program: study-program,
  supervisor: supervisor,
  expert: expert,
  client: client,
  public: public,
  secret: secret,
  scanned-signature-page: scanned-signature-page,
  acknowledgements: acknowledgements,
  abstract,
  doc,
  bib: bib,
  abbr: abbr,
  imgol: imgol,
  tabol: tabol,
  ai: ai,
)

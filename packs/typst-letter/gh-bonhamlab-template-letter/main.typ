#import "assets/letter.typ": letter-template, tmc-style, gsbs-style

// The commented lines below are the default values.
// See assets/letter.typ for the definitions.
// Where not obvious, other options are shown in comments
// following the default values.
#show: letter-template.with(
  // name: "Kevin Bonham, PhD",
  // email: "kevin.bonham@tuftsmedicine.org",
  // title: "Assistant Professor of Medicine",
  // affiliation: "GI Division | Tufts Medical Center",
  // date: datetime.today(),
  // salutation: "To whom it may concern,",
  // vmargins: 0.3in,
  // signature: v(0.5in), // image(height: 0.5in, "assets/signature.png"),
  // style: tmc-style // gsbs-style
)

// Content goes here, lorem is a placeholder and can be deleted
#lorem(100)

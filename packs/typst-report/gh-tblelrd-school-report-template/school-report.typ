#let report(
  matric: 0,
  tutor: "",
  date: "",
  module: "",

  font: "Charter BT Roman, New Computer Modern",
  header_size: 0.8em,

  body,
) = [
  // Make the caption of a test-table to appear on top of the table.
  #show figure.where(
    kind: "test-table"
  ): set figure.caption(position: top);

  #set text(font: font)
  #set par(justify: true)
  #set page(numbering: "1 of 1");

  // Header that doesn't render on <noheader>
  #set page(header: context {
    // Finds the noheader tag
    let tags = query(selector(<noheader>).after(here()))

    // Don't write header if noheader tag is anywhere on the page.
    for tag in tags {
      if tag.location().page() == here().page() { return; }
    }

    text(size: header_size)[#align(center)[#grid(
      columns: (1fr, 1fr, 1fr, 1fr),

      [ #module Assignment],
      [ #matric ],
      [ Tutor: #tutor ],
      [ Date: #date],
    )]]
  })

  // Title page
  #align(center)[
    #heading(outlined: false)[#module Report] \
    Tutor: #tutor \
    Matriculation ID: #matric \
    Date: #date
  ] <noheader>

  #outline(title: "Table of Contents")
  #pagebreak();

  #body
];

// Error message to string
#let to-string(it) = {
  if type(it) == str {
    it
  } else if type(it) != content {
    str(it)
  } else if it.has("text") {
    it.text
  } else if it.has("children") {
    it.children.map(to-string).join()
  } else if it.has("body") {
    to-string(it.body)
  } else if it == [ ] {
    " "
  }
}

// A test table that can be referenced.
#let test-table(
  title: none,
  tests: (),
) = figure(
  kind: "test-table",
  supplement: "Test Matrix",
  numbering: "1",
  caption: title,
)[
  #set par(justify: false);

  // Check that tests are 4 wide always
  #let valid = tests.all(row => row.len() == 4);
  #for test in tests {
    if test.len() != 4 {
      panic(to-string([ERROR: Row #tests.position(t => t == test) has length #test.len(), should be 4]))
    }
  }
  #if not(valid) { return [Table should always have 4 columns] }
  
  #table(
    stroke: none,
    align: left,
    columns: 4,
    table.hline(),
    table.header(
      [What is being tested],
      [Pre-conditions],
      [Expected Outcomes],
      [Pass / Fail?],
    ),
    table.hline(stroke: 0.3pt),
    ..tests.flatten(),
    table.hline(),
  )
];

// Another show rule for appendices.
// Can't do subheadings.
#let appendix(body) = {
  pagebreak();
  heading(level: 1)[Appendix];
  set heading(
    level: 2,
    numbering: (..nums) => numbering("A", nums.at(1, default: 1)),
    supplement: [Appendix]
  );
  counter(heading).update(0)
  body
}

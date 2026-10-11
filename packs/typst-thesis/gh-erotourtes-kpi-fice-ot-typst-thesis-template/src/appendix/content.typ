#import "lib/index.typ": appendix_page, appendix_title_page
#import "../lib/lib.typ": page_range_sheet_count

#let appendix_content(meta: none, thesis: none, body) = {
  let code = thesis.document.codes.at(meta.code_key)

  [
    #appendix_title_page(
      number: meta.number,
      letter: meta.letter,
      topic: thesis.topic,
      code: code,
      city: thesis.document.city,
      year: thesis.document.year,
      sheet_count: page_range_sheet_count(
        start_label: meta.start_label,
        end_label: meta.end_label,
      ),
      title_label: meta.title_label,
    )

    #appendix_page(
      meta: meta,
      topic: thesis.topic,
      group: thesis.student.group,
      code: code,
      implemented_by: thesis.student.initials,
      reviewed_by: thesis.advisor.initials,
      norm_controller: thesis.consultant.initials,
      approved_by: thesis.document.approved_by,
    )[#body]
  ]
}

#let appendix_d1_meta = (
  number: [1],
  letter: [А],
  code_key: "d1",
  title_label: <appendix_d1_title>,
  start_label: <appendix_d1_start>,
  end_label: <appendix_d1_end>,
)

#let appendix_d2_meta = (
  number: [2],
  letter: [Б],
  code_key: "d2",
  title_label: <appendix_d2_title>,
  start_label: <appendix_d2_start>,
  end_label: <appendix_d2_end>,
)

#let appendix_d3_meta = (
  number: [3],
  letter: [В],
  code_key: "d3",
  title_label: <appendix_d3_title>,
  start_label: <appendix_d3_start>,
  end_label: <appendix_d3_end>,
)

#let appendix_d4_meta = (
  number: [4],
  letter: [Г],
  code_key: "d4",
  title_label: <appendix_d4_title>,
  start_label: <appendix_d4_start>,
  end_label: <appendix_d4_end>,
)

#let d1_content(thesis: none, body) = appendix_content(
  meta: appendix_d1_meta,
  thesis: thesis,
)[#body]

#let d2_content(thesis: none, body) = appendix_content(
  meta: appendix_d2_meta,
  thesis: thesis,
)[#body]

#let d3_content(thesis: none, body) = appendix_content(
  meta: appendix_d3_meta,
  thesis: thesis,
)[#body]

#let d4_content(thesis: none, body) = appendix_content(
  meta: appendix_d4_meta,
  thesis: thesis,
)[#body]

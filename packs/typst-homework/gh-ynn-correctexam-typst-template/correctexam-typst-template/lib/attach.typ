#import "markers.typ": _collect-markers

#let _attach-markers() = context {
  let markers = _collect-markers()
  let json-str = json.encode(markers, pretty: false)
  pdf.attach(
    "/correctexam-markers.json",
    bytes(json-str),
    mime-type: "application/json",
    relationship: "data",
    description: "CorrectExam zone markers - machine-readable exam metadata",
  )
}

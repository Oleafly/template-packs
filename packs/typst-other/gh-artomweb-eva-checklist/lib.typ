#let c = state("Crew Member", "P")
#let t = state("With Time?", false)
#let n = state("With Numbers?", false)

#let sequence(title: "", withTime: false, withNumbers: false, body) = context {
  let step-num = counter("step").get().at(0)
  if step-num > 0 {
    // If there was a sequence before this, give it some space
    v(3mm)
  }
  counter("step").update(0)
  counter("sequenceStep").update(1)
  counter("subStep").update(1)
  counter("crewSection").update(0)
  counter("localTimeBadge").update(0)
  t.update(withTime)
  n.update(withNumbers)
  if title != "" {
    upper[#underline()[#title:]]
    v(4mm)
  }
  body
}

#let step-component(atTime: "00:00", isSubstep: false, body) = {
  context {
    counter("step").step()
    if not isSubstep {
      counter("sequenceStep").step()
      counter("subStep").update(1) // Reset substep counter for each main step
    } else {
      counter("subStep").step() // Increment substep counter for substeps
    }
    let step-num = counter("step").get().at(0)
    let seq-step-num = counter("sequenceStep").get().at(0)
    let sub-step-num = counter("subStep").get().at(0)
    let section-num = counter("crewSection").get().at(0)
    let globalTimeBadge = counter("globalTimeBadge").get().at(0)
    let time-width = 2.8em // Fixed width for time column

    if step-num == 1 and section-num != 1 {
      v(2mm)
    }

    grid(
      inset: if isSubstep { (left: 1.2em) } else { 0pt },
      columns: if t.get() {
        if n.get() {
          (1em, 1.4em, 1fr, time-width)
        } else {
          (1em, 1fr, time-width)
        }
      } else {
        if n.get() {
          (1em, 1em, 1fr)
        } else {
          (1em, 1fr)
        }
      },
      column-gutter: 0.9em,
      // Column 1: Crew member (always present, conditionally populated)
      if step-num == 1 {
        let crew-member = c.get()
        crew-member
      },
      // Column 2: Step number (conditional based on n.get())
      ..if n.get() {
        (
          if not isSubstep {
            align(right)[#box(inset: (right: 5pt))[#text[#str(seq-step-num).]]]
          } else {
            box(inset: (left: 1.5em))[#align(right)[#enum(numbering: "a.", enum.item(sub-step-num)[])]]
          },
        )
      },
      // Column 3: Body text (always present)
      par(hanging-indent: 1.2em)[#upper[#body]],
      // Column 4: Time badge (conditional based on t.get())
      if t.get() and (step-num == 1 and section-num == 1 or atTime != "00:00") {
        counter("globalTimeBadge").step()
        counter("localTimeBadge").step()
        align(right)[
          #box(width: time-width)[#underline()[#atTime] #label(("timeBadge" + str(globalTimeBadge + 1)))]
        ]
      },
    )
  }

  context {
    if t.get() {
      let localTimeBadge = counter("localTimeBadge").get().at(0)
      let globalTimeBadge = counter("globalTimeBadge").get().at(0)
      if localTimeBadge > 1 and atTime != "00:00" {
        let pos = locate(label("timeBadge" + str(globalTimeBadge - 1))).position()
        let currPos = locate(label("timeBadge" + str(globalTimeBadge))).position()

        if currPos.page == pos.page {
          place(top)[
            #line(start: (pos.x + 8.7pt, pos.y + 7pt), end: (currPos.x + 8.7pt, currPos.y - 10pt))
          ]
          place(top, dx: currPos.x + 6.7pt, dy: currPos.y - 11pt)[
            #curve(
              stroke: black,
              fill: black,
              curve.move((0.5pt, 0pt)),
              curve.line((2pt, 3.5pt)),
              curve.line((3.5pt, 0pt)),
              curve.close(),
            )
          ]
        }
      }
    }
  }
}

#let step(atTime: "00:00", body) = {
  step-component(atTime: atTime, body, isSubstep: false)
}

#let subStep(atTime: "00:00", body) = {
  step-component(atTime: atTime, body, isSubstep: true)
}

#let withCrew(crewMember, body) = {
  counter("step").update(1)
  counter("crewSection").step()
  c.update(crewMember)
  body
}

#let checklist(title: none, body) = {
  set page(
    width: 83mm,
    height: 203mm,
    margin: 2mm,
  )
  set text(size: 11pt)
  set text(font: ("Liberation Mono", "Cascadia Mono"))
  set sub(size: 1em, typographic: false, baseline: .4em)
  set underline(offset: 1mm, stroke: 0.08em)
  set par(spacing: 0.6em)
  counter("globalTimeBadge").update(0)
  body
}

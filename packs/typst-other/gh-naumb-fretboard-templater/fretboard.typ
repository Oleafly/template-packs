#import "@preview/cetz:0.4.0"

#import "/notes.typ": *

#let draw_fretboard(
  width: 16cm, //default: din a4 is 21 cm with a margin of 2.5 cm on each side
  height: 5cm,
  frets: 24,
  strings: 6,
  tuning: none,
  body: none,
) = {
  cetz.canvas({
    import cetz.draw: *

    // Calculate spacing between frets and actually used width
    let spacing_factor = 1 / calc.root(2, 12)

    // If tuning is provided, offset everything a bit to the right to make room for note names left of each string
    let left = 0cm
    if tuning != none {
      set-ctx(ctx => {
        ctx.shared-state.tuning = tuning
        return ctx
      })
      left = 0.5cm
    }

    let brutto_width = (width - left) / (1 - calc.pow(spacing_factor, frets))

    // Draw nut
    line((left, 0), (left, height), stroke: 2pt)

    // Draw individual frets
    let fret = 1
    while fret <= frets {
      let x = brutto_width * (1 - calc.pow(spacing_factor, fret)) + left
      line((x, 0), (x, height))
      
      fret = fret + 1
    }

    // maximum fret marker size
    let marker_size = 0.4cm

    // Place fret markers
    // For now:
    //   - each odd number that is not (a multiple of 12)+-1 gets 1 marker
    //   - every multiple of 12 gets two markers
    let fret = 1
    while fret <= frets {
      if (calc.odd(fret)) and (calc.rem((fret - 1), 12) != 0) and (calc.rem((fret + 1), 12) != 0) {
        let x_curr = brutto_width * (1 - calc.pow(spacing_factor, fret))
        let x_prev = brutto_width * (1 - calc.pow(spacing_factor, fret - 1))
        let x = (x_curr + x_prev) / 2 + left

        circle((x, height / 2), radius: marker_size/(calc.pow(fret, spacing_factor)), fill: black)
      }

      if calc.rem(fret, 12) == 0 {
        let x_curr = brutto_width * (1 - (calc.pow(spacing_factor, fret)))
        let x_prev = brutto_width - (calc.pow(spacing_factor, fret - 1) * brutto_width)
        let x = (x_curr + x_prev) / 2 + left

        circle((x, height / 3), radius: marker_size/(calc.pow(fret, spacing_factor)), fill: black)
        circle((x, 2 * height / 3), radius: marker_size/(calc.pow(fret, spacing_factor)), fill: black)
      }

      fret += 1
    }

    // Draw strings
    let string_spacing = height / strings
    let string = 0
    while string < strings {
      let y = string_spacing * (string + 0.5)
      let thickness = calc.pow((strings - string), 0.3) * 1pt
      line((left, y), (width, y), stroke: (thickness))

      // Annotate tuning if available
      if tuning != none {
        if (type(tuning) == array) and (tuning.len() == strings) {
          content((0, y), tuning.at(string), anchor: "mid-west")
        // }
        } else {
          panic("`tuning` must be an array of strings (note names) with len `strings`")
        }
      }

      string += 1
    }

    if tuning != none {
      // Helper function to find center positions between frets
      let fret_center_position(string, fret) = {
        let x_fret = brutto_width * (1 - calc.pow(spacing_factor, fret))
        let x_prev = brutto_width * (1 - calc.pow(spacing_factor, fret - 1))
        let x = (x_fret + x_prev) / 2 + left

        let string_spacing = height / strings
        let y = string_spacing * (string + 0.5)

        return (x, y)
      }

      // place this helper function in cetz-context to use in highlight function
      set-ctx(ctx => {
        ctx.shared-state.fret_center_position = fret_center_position

        return ctx
      })

      // Helper function to get note at specific string and fret
      let note_at(string, fret) = {
        let note = tuning.at(string)
        while fret > 0 {
          note = next_note(note)
          fret -= 1
        }
        return note
      }

      // prepare set of all (fret, string)-positions of all notes
      let notes = NOTE_NAMES.map(n => (n, ())).to-dict()

      for string in range(0, strings) {
        for fret in range(0, frets + 1) {
          // Unfortunately, dict keys have to be strings. Hence, "(fret, string) : note" is not possible here.
          // Alternative: "note" : ((fret, string), ...) is used
          let note = note_at(string, fret)
          notes.insert(note, notes.at(note) + ((string, fret),))
        }
      }

      // place all positions in cetz-context to use in highlight function
      
      set-ctx(ctx => {
        ctx.shared-state.notes = notes
        return ctx
      })


      // Additional function calls (like highlighting individual notes, chords, scales, ranges, etc.)
      if body != none {
        body
      }
    }
  })
}

#let highlight(note, color) = {
  import cetz.draw: * 

  get-ctx(ctx => {
    let notes = ctx.shared-state.notes
    let fret_center_position = ctx.shared-state.fret_center_position

    // TODO: refactor for better name indicating string/fret-positions
    let placements = notes.at(note)

    for placement in placements {
      let x = fret_center_position(placement.at(0), placement.at(1)).at(0)
      let y = fret_center_position(placement.at(0), placement.at(1)).at(1)

      circle((x, y), radius: 0.25, fill: color)

      if luma(color).components().at(0) > 66% {
        content((x, y), text(note, fill: black))
      } else {
        content((x, y), text(note, fill: white))
      }
    }
  })
}
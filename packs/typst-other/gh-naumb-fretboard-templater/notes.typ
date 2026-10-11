#let NOTE_NAMES = ("A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#")

#let normalize_note_name(note) = {
  //Lets hope that at some point match statements are introduced...
       if note in ("a", "A")               { return "A"  }
  else if note in ("a#", "A#", "bb", "Bb") { return "A#" }
  else if note in ("b", "B")               { return "B"  }
  else if note in ("c", "C")               { return "C"  }
  else if note in ("c#", "C#", "db", "Db") { return "C#" }
  else if note in ("d", "D")               { return "D"  }
  else if note in ("d#", "D#", "eb", "Eb") { return "D#" }
  else if note in ("e", "E")               { return "E"  }
  else if note in ("f", "F")               { return "F"  }
  else if note in ("f#", "F#", "gb", "Gb") { return "F#" }
  else if note in ("g", "G")               { return "G"  }
  else if note in ("g#", "G#", "ab", "Ab") { return "G#" }
  else { panic("note " + note + " is not valid!") }
}

#let next_note(note) = {
  let n = normalize_note_name(note)
  let i = NOTE_NAMES.enumerate().find(t => t.at(1) == n)
  if i == none { panic("note " + n + " not found!") }
  else {
    i = i.at(0) + 1
  }
  if i == NOTE_NAMES.len() { i = 0 }
  NOTE_NAMES.at(i)
}